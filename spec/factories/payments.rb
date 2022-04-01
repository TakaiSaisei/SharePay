# == Schema Information
#
# Table name: payments
#
#  id          :bigint           not null, primary key
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
FactoryBot.define do
  factory :payment do
    currency { 'RUB' }
    association :receiver, factory: :user
    association :sender, factory: :user
  end
end
