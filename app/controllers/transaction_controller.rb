class TransactionController < ApplicationController
  def create
    w = Wallet.find_by(name: params['from'])
    from_account = w.accounts.find_by(currency: params['currency'])

    to_arr = []
    params['to'].each do |t|
      to_wallet = Wallet.find_by(name: t['name'])
      to_account = to_wallet.accounts.find_by(currency: params['currency'])
      to_arr << {
        account: to_account,
        amount: t['amount']
      }
    end

    t = TransactionGenerator::create_transaction(from_account, to_arr)

    render json: t
  end

  def broadcast
    tx = Transaction.find(params['id'])
    if tx.signed
      render :status => 200, nothing: true
    else
      render :status => 400, nothing: true
    end
  end

  def list

  end

  private


end
