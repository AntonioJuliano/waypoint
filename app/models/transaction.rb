class Transaction < ActiveRecord::Base
  state_machine initial: :created do
    before_transition on: :signed, do: :start_payments

    event :signed do
      transition :created => :signed
    end

    event :broadcast do
      transition :signed => :broadcast
    end
  end

  belongs_to :wallet
  has_many :payments, inverse_of: :tx, foreign_key: 'transaction_id'
  # TODO has_one :script ?

  validates :payments, :length => { :minimum => 2 }
  validate :zero_sum
  validate :same_payment_currency

  def debits
    payments.to_a.keep_if { |p| p.is_a?(Debit) }
  end

  def credits
    payments.to_a.keep_if { |p| p.is_a?(Credit) }
  end

  private

  def same_payment_currency
    currency = nil

    payments.each do |p|
      currency ||= p.currency

      if currency && currency != p.currency
        return errors.add(:base, 'All payments must have same currency')
      end
    end
  end

  def payments_sum
    total = 0

    credits.each do |c|
      total += c.amount
    end

    debits.each do |d|
      total -= d.amount
    end

    total
  end

  def zero_sum
    if payments_sum != 0
      errors.add(:base, 'Payments must sum to zero')
    end
  end
end
