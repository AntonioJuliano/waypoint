class TransactionGenerator
  class << self
    def create_transaction(from, to)
      currency = from.currency

      total = 0
      to.each { |t| total += t[:amount].to_i }

      tx = Transaction.new
      tx.wallet = from.wallet

      d = Debit.new(
        currency: currency,
        amount: total,
        tx: tx,
        account: from
      )
      tx.payments << d

      to.each do |t|
        c = Credit.new(
          currency: currency,
          amount: t[:amount].to_i,
          tx: tx,
          account: t[:account]
        )
        tx.payments << c
      end

      tx.save

      tx
    end
  end
end
