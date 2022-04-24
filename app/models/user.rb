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

  has_many :income_payments, class_name: 'Payment', foreign_key: :receiver_id
  has_many :outcome_payments, class_name: 'Payment', foreign_key: :sender_id

  has_many :purchases

  def payments
    income_payments.or(outcome_payments)
  end
end
