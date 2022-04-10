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
class Purchase < ApplicationRecord
  belongs_to :user
  has_many :user_purchases
  has_many :users, through: :user_purchases

  validates :name, presence: true
  validates :user_id, presence: true

  accepts_nested_attributes_for :user_purchases
end
