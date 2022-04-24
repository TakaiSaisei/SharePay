# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  phone      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :user, aliases: %i[receiver sender] do
    sequence(:phone, &:to_s)
  end
end
