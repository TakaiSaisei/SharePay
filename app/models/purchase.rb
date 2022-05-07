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
class Purchase < ApplicationRecord
  include HasCurrency

  belongs_to :user
  has_many :user_purchases
  has_many :users, through: :user_purchases

  validates :name, presence: true
  validates :user_id, presence: true

  after_update :update_all_debts, if: :saved_change_to_draft?

  accepts_nested_attributes_for :user_purchases

  private

  def update_all_debts
    return unless draft == false

    user_purchases.each(&:touch)
  end
end
