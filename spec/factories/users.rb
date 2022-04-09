# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  phone      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "name_#{n}" }
    sequence(:phone) { |n| n.to_s }
  end
end
