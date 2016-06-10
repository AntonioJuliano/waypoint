module TransactionGenerators
  extend ActiveSupport::Concern

  module ClassMethods
    def tag_limit(value)
      self.tag_limit_value = value
    end
  end
end