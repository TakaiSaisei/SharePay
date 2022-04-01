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
FactoryBot.define do
  factory :user_purchase do
    sequence(:amount) { |n| 1000 + n }
    association :purchase
    association :user
  end
end
