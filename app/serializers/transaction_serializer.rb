class TransactionSerializer < BaseSerializer
  attributes :id
  has_many :debits, :credits
end
