class Address < ActiveRecord::Base
  belongs_to :account, inverse_of: :addresses

  validates_presence_of :currency, :address, :encrypted_private_key, :account
  validates_uniqueness_of :address
  validate :matches_account_currency

  before_validation :set_currency, on: :create

  private

  def matches_account_currency
    unless account.currency == currency
      errors.add(:currency, 'Invalid Currency')
    end
  end

  def set_currency
    self.currency ||= account.currency
  end
end
