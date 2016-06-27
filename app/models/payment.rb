class Payment < ActiveRecord::Base
  state_machine initial: :created do
    before_transition on: :started, do: :payout

    before_transition on: :reverse, do: :refund

    event :start do
      transition :created => :started
    end

    event :complete do
      transition :started => :completed
    end

    event :cancel do
      transition :created => :canceled
    end

    event :reverse do
      transition :started => :reversed, :completed => :reversed
    end

    state all - [:started, :completed] do
      def paid_out?
        false
      end
    end

    state :started, :completed do
      def paid_out?
        true
      end
    end
  end

  belongs_to :account
  belongs_to :tx, class_name: 'Transaction', inverse_of: :payments, foreign_key: 'transaction_id'

  validates_presence_of :currency, :tx
  validates_presence_of :account, unless: :external?

  validates :amount, presence: true, numericality: { only_integer: true,
                                                     greater_than_or_equal_to: 0 }
  validate :matches_account_currency

  private

  def matches_account_currency
    unless account.currency == currency
      errors.add(:currency, 'Must match account currency')
    end
  end

  def payout
    raise NotImplementedError
  end

  def refund
    raise NotImplementedError
  end
end
