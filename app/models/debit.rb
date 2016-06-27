class Debit < Payment
  private

  def payout
    raise 'Invalid Payout' if paid_out?
    account.update_attributes(balance: account.balance - amount)
  end

  def refund
    raise 'Invalid Payout' unless paid_out?
    account.update_attributes(balance: account.balance + amount)
  end
end
