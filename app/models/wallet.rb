class Wallet < ActiveRecord::Base
  has_many :accounts, inverse_of: :wallet
  has_many :transactions, inverse_of: :wallet
  accepts_nested_attributes_for :accounts

  validates_presence_of :name
  validate :validate_accounts

  def account(currency)
    accounts.find_by(currency: currency)
  end

  private

  def validate_accounts
    unless accounts.length > 0
      errors.add(:accounts, 'Wallet must have at least one account')
    end

    accounts.each do |a|
      if accounts.where(currency: a.currency).length > 1
        errors.add(:accounts, 'Only one account per currency allowed')
      end
    end
  end
end
