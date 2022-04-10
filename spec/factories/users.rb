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
  factory :user, aliases: %i[receiver sender] do
    sequence(:name) { |n| "First Second #{n}" }
    sequence(:phone, &:to_s)
  end
end
