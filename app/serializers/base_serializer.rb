class BaseSerializer < ActiveModel::Serializer
  def attributes
    hash = super
    hash[:errors] = object.errors.full_messages unless object.errors.blank?
    hash
  end
end
