FactoryGirl.define do
  factory :wallet do
    sequence(:name) { |n| "Wallet-#{n}" }

    after(:build) do |w|
      if w.accounts.empty?
        w.accounts << FactoryGirl.build(:account, wallet: w)
      end
    end
  end
end
