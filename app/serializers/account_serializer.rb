class AccountSerializer < ActiveModel::Serializer
  attributes :currency, :balance
  has_many :addresses
end
