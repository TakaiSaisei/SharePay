# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  phone      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
  validates :phone, presence: true, uniqueness: true

  has_many :mine_debts, class_name: 'Debt', foreign_key: :debtor_id
  has_many :their_debts, class_name: 'Debt', foreign_key: :creditor_id

  has_many :income_payments, class_name: 'Payment', foreign_key: :receiver_id
  has_many :outcome_payments, class_name: 'Payment', foreign_key: :sender_id

  has_many :purchases

  def balance
    their_debts.sum(:amount)
  end

  def debts
    mine_debts.or(their_debts)
  end

  def payments
    income_payments.or(outcome_payments)
  end
end
