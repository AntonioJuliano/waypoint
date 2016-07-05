class PaymentSerializer < BaseSerializer
  attributes :amount, :currency, :wallet_name

  def wallet_name
    object.wallet.name
  end
end
