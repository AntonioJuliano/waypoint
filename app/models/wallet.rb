class Wallet < ActiveRecord::Base
  has_many :accounts

  validates_presence_of :name

  after_create :create_accounts

  private

  def create_accounts
    Account.create!(currency: 'BTC', wallet: self)
  end
end
