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
end
