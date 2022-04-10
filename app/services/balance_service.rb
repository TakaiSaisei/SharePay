module BalanceService
  extend self

  def balance(account)
    payments(sender: account).sum(:amount) - purchases(made_to: account).sum(:amount)
  end

  def owes_to(borrower:, lender:)
    payments(sender: borrower, receiver: lender).sum(:amount) - purchases(made_to: borrower, made_by: lender).sum(:amount)
  end

  private

  def payments(sender:, receiver: nil)
    scope = Payment.where(sender:)
    return scope unless receiver.present?

    scope.where(receiver:)
  end

  def purchases(made_to:, made_by: nil)
    scope = UserPurchase.includes(:purchase).where('user_purchases.user': made_to)
    return scope unless made_by.present?

    scope.where('purchases.user': made_by)
  end
end
