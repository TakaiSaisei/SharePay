# == Schema Information
#
# Table name: payments
#
#  id          :bigint           not null, primary key
#  amount      :float
#  currency    :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  receiver_id :bigint
#  sender_id   :bigint
#
# Foreign Keys
#
#  fk_rails_...  (receiver_id => users.id)
#  fk_rails_...  (sender_id => users.id)
#
class Payment < ApplicationRecord
  include HasCurrency

  belongs_to :receiver, class_name: 'User'
  belongs_to :sender, class_name: 'User'

  validates :amount, presence: true
  validates :currency, presence: true
  validates :receiver_id, presence: true
  validates :sender_id, presence: true

  after_create :update_debt

  def as_json(options = nil)
    super.merge('receiver_phone' => User.find(receiver_id).phone, 'sender_phone' => User.find(sender_id).phone)
  end

  private

  def update_debt
    DebtService.decrease(debtor_id: sender_id, creditor_id: receiver_id, amount:)
  end
end
