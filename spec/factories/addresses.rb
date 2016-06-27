FactoryGirl.define do
  factory :address do
    currency 'BTC'
    sequence(:address) { |n| "PubKey-#{n}" }
    encrypted_private_key 'crypted'

    after(:build) do |a|
      a.account ||= create(:account, currency: a.currency)
    end
  end
end
