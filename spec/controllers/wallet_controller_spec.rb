require 'rails_helper'

RSpec.describe WalletController do
  let(:name) { 'my_wallet' }
  let(:currency) { 'BTC' }
  let(:address) { 'test addr' }
  let(:pk) { 'key1' }

  describe ".create" do
    it "creates wallet on valid params" do
      expect{
        post :create,
          name: name,
          keys: [{
            currency: currency,
            address: address,
            encrypted_private_key: pk
          }]
      }.to change(Wallet,:count).by(1)

      expect(response.status).to eq(200)

      w = Wallet.last
      a = Account.last
      addr = Address.last

      expect(w.name).to eq(name)
      expect(w.accounts.length).to eq(1)
      expect(w.accounts.first).to eq(a)

      expect(a.currency).to eq(currency)
      expect(a.addresses.length).to eq(1)
      expect(a.addresses.first).to eq(addr)

      expect(addr.currency).to eq(currency)
      expect(addr.address).to eq(address)
      expect(addr.encrypted_private_key).to eq(pk)
    end
  end

  describe ".get" do
    it "gets wallet matching name" do
      w = create(:wallet)
      expect(Wallet.last).to eq(w)

      post :get, name: w.name

      expect(response.status).to eq(200)

      r = JSON.parse(response.body)['wallet']

      expect(r['name']).to eq(w.name)

      r['accounts'].each do |a|
        matching_account = w.accounts.where(currency: a['currency']).first
        expect(matching_account).to be_present
        expect(a['balance']).to eq(matching_account.balance)

        a['addresses'].each do |addr|
          matching_address = matching_account.addresses.where(address: addr['address']).first

          expect(matching_address).to be_present
          expect(addr['encrypted_private_key']).to eq(matching_address.encrypted_private_key)
        end
      end
    end
  end
end
