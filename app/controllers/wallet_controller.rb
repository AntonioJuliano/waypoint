class WalletController < ApplicationController
  def create
    render json: Wallet.create(create_wallet_params)
  end

  def get
    render json: Wallet.find_by(name: params['name'])
  end

  private

  def create_wallet_params
    params.require(:wallet).permit(:name)
  end
end
