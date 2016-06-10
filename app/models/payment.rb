class Payment < ActiveRecord::Base
  belongs_to :account

  validates_presence_of :currency
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
end
