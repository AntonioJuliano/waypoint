FactoryGirl.define do
  factory :wallet do
    name 'factory_wallet'

    after(:build) do |w|
      if w.accounts.empty?
        w.accounts << FactoryGirl.build(:account, wallet: w)
      end
    end
  end
end
