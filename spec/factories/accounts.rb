FactoryGirl.define do
  factory :account do
    currency 'BTC'

    after(:build) do |a|
      a.wallet ||= create(:wallet)

      if a.addresses.empty?
        a.addresses << FactoryGirl.build(:address, account: a, currency: a.currency)
      end
    end
  end
end
