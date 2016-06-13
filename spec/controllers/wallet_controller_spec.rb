require 'rails_helper'

RSpec.describe WalletController do
  let(:name) { 'my_wallet' }
  let(:currency) { 'btc' }
  let(:address) { 'test addr' }
  let(:pk) { 'key1' }

  describe ".create" do
    it "creates wallet on valid params" do
      expect{
        post :create,
          name: name,
          accounts_attributes: [{
            currency: currency,
            addresses_attributes: [{
              address: address,
              encrypted_private_key: pk
            }]
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
end
