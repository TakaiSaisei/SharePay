# == Schema Information
#
# Table name: debts
#
#  id          :bigint           not null, primary key
#  amount      :float            not null
#  creditor_id :bigint
#  debtor_id   :bigint
#
# Indexes
#
#  index_debts_on_creditor_id  (creditor_id)
#  index_debts_on_debtor_id    (debtor_id)
#
# Foreign Keys
#
#  fk_rails_...  (creditor_id => users.id)
#  fk_rails_...  (debtor_id => users.id)
#
class Debt < ApplicationRecord
  belongs_to :creditor, class_name: 'User', foreign_key: :creditor_id
  belongs_to :debtor, class_name: 'User', foreign_key: :debtor_id

  def amount
    events.sum do |event|
      creditor_id == event.user_lost_id ? event.amount : -event.amount
    end
  end

  def events
    DebtEvent.all(self)
  end
end
