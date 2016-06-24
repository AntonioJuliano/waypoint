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
    create_params = { name: params[:name] }

    keys_arr = []

    params[:keys].each do |k|
      keys_arr << {
        currency: k[:currency],
        addresses_attributes: [{
          address: k[:address],
          encrypted_private_key: k[:encrypted_private_key]
        }]
      }
    end

    create_params[:accounts_attributes] = keys_arr

    create_params
  end
end
