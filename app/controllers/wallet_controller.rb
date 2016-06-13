class WalletController < ApplicationController
  def create
    w = Wallet.create(
      create_wallet_params
    )

    render json: w
  end

  def get
    render json: Wallet.find_by(name: params['name'])
  end

  def restore

  end

  private

  def create_wallet_params
    params.permit(
      :name,
      accounts_attributes: [
        :currency,
        { addresses_attributes: [:currency, :address, :encrypted_private_key]}
      ]
    )
  end
end
