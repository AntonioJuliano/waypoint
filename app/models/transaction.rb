class Transaction < ActiveRecord::Base
  has_many :debits
  has_many :credits
  # TODO has_one :script ?

  before_validation :set_default_fee, unless: -> (t) { fee.present? }

  validates :fee, presence: true, numericality: { only_integer: true,
                                                  greater_than_or_equal_to: 0 }
  validate :zero_sum
  validate :same_payment_currency

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
    total = fee

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

  def set_default_fee
    self.fee ||= 0 # TODO
  end

  def payments
    debits << credits
  end
end
