require 'rails_helper'

RSpec.describe TransactionController do
  let(:from_wallet) { create(:wallet) }
  let(:to_wallet) { create(:wallet) }
  let(:amount) { 10_000_000 }

  describe ".create" do
    it "creates wallet on valid params" do
      from_account = from_wallet.account('BTC')
      to_account = to_wallet.account('BTC')

      starting_from_balance = from_account.balance
      starting_to_balance = to_account.balance

      expect {
        post :create,
          from: from_wallet.name,
          currency: 'BTC',
          to: [{
            name: to_wallet.name,
            amount: amount
          }]
      }.to change(Transaction,:count).by(1)

      expect(response.status).to eq(200)

      tx = Transaction.last
      expect(tx.debits.length).to eq(1)
      expect(tx.credits.length).to eq(1)

      d = tx.debits.first
      c = tx.credits.first

      expect(d.amount).to eq(amount)
      expect(d.is_a?(Debit)).to be_truthy
      expect(c.amount).to eq(amount)
      expect(c.is_a?(Credit)).to be_truthy

      expect(from_account.reload.balance).to eq(starting_from_balance)
      expect(to_account.reload.balance).to eq(starting_to_balance)
    end
  end

  describe ".broadcast" do
    it "signs transaction and adjusts balances" do
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
