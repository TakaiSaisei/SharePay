# == Schema Information
#
# Table name: purchases
#
#  id          :bigint           not null, primary key
#  description :string
#  emoji       :string
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :purchase do
    sequence(:name) { |n| "Purchase #{n}" }
    association :user
  end
end
