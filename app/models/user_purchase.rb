# == Schema Information
#
# Table name: user_purchases
#
#  id          :bigint           not null, primary key
#  amount      :float            not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  purchase_id :bigint
#  user_id     :bigint
#
# Indexes
#
#  index_user_purchases_on_purchase_id  (purchase_id)
#  index_user_purchases_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (purchase_id => purchases.id)
#  fk_rails_...  (user_id => users.id)
#
class UserPurchase < ApplicationRecord
  belongs_to :purchase
  belongs_to :user

  after_create :update_debt, if: -> { purchase.draft == false }
  after_touch :update_debt

  private

  def update_debt
    DebtService.increase(debtor_id: user_id, creditor_id: purchase.user_id, amount:)
  end
end
