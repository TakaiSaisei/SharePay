# == Schema Information
#
# Table name: purchases
#
#  id           :bigint           not null, primary key
#  currency     :integer
#  description  :string
#  draft        :boolean          default(FALSE), not null
#  emoji        :string
#  name         :string           not null
#  purchased_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :purchase do
    sequence(:name) { |n| "Purchase #{n}" }
    currency { 'rub' }
    association :user

    trait :with_user_purchases do
      after(:create) do |purchase, _evaluator|
        user = create(:user)
        create(:user_purchase, purchase:, user:)
      end
    end
  end
end
