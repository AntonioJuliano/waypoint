class WalletSerializer < BaseSerializer
  attributes :name
  has_many :accounts
end
