class Account < ActiveRecord::Base
  VALID_CURRENCIES = ['btc']

  belongs_to :wallet, inverse_of: :accounts

  has_many :debits
  has_many :credits

  has_many :addresses, inverse_of: :account
  accepts_nested_attributes_for :addresses

  validates_presence_of :currency, :wallet
  validates_inclusion_of :currency,
    in: VALID_CURRENCIES,
    message: "Invalid"
  validates :balance, presence: true, numericality: { only_integer: true,
                                                      greater_than_or_equal_to: 0 }
  validates :addresses, :length => { :minimum => 1 }
  validate :correct_balance

  private

  def correct_balance
    total = 0

    credits.each do |c|
      total += c.amount
    end

    debits.each do |d|
      total -= d.amount
    end

    unless total == balance
      errors.add(:balance, 'Balance does not match payments')
    end
  end
end
