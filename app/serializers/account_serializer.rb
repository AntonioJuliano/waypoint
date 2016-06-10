class AccountSerializer < ActiveModel::Serializer
  attributes :id, :currency, :balance
end
