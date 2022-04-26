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
class Debt < ApplicationRecord; end
