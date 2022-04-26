module DebtService
  class << self
    def increase(debtor_id:, creditor_id:, amount:)
      update(debtor_id, creditor_id, amount, :+)
    end

    def decrease(debtor_id:, creditor_id:, amount:)
      update(debtor_id, creditor_id, amount, :-)
    end

    private

    def update(debtor_id, creditor_id, amount, fn)
      debtor_debt = Debt.find_or_initialize_by(debtor_id:, creditor_id:)
      creditor_debt = Debt.find_or_initialize_by(debtor_id: creditor_id, creditor_id: debtor_id)

      debtor_debt.amount = if debtor_debt.persisted?
                             debtor_debt.amount.send(fn, amount)
                           else
                             0.send(fn, amount)
                           end

      creditor_debt.amount = if creditor_debt.persisted?
                               creditor_debt.amount.send(opposite[fn], amount)
                             else
                               0.send(opposite[fn], amount)
                             end

      ActiveRecord::Base.transaction do
        debtor_debt.save!
        creditor_debt.save!
      end
    end

    def opposite
      { :- => :+, :+ => :- }
    end
  end
end
