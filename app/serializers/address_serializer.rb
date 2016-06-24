class AddressSerializer < ActiveModel::Serializer
  attributes :address, :encrypted_private_key
end
