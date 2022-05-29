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
  has_many :users, through: :user_purchases, dependent: :destroy

  validates :name, presence: true
  validates :user_id, presence: true

  after_update :update_all_debts, if: -> { saved_change_to_draft? && draft == false }
  before_update do
    check_draft
    throw(:abort) if errors.present?
  end

  before_create :set_fields

  before_destroy do
    check_draft
    throw(:abort) if errors.present?
  end

  accepts_nested_attributes_for :user_purchases

  def amount
    user_purchases.sum(:amount)
  end

  private

  def update_all_debts
    user_purchases.each(&:touch)
  end

  def check_draft
    return if will_save_change_to_draft?(from: true, to: false)

    errors.add(:base, 'Cannot delete or update non-draft purchase') if draft == false
  end

  def set_fields
    self.purchased_at ||= Time.current
  end
end
