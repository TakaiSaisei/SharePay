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
require 'rails_helper'

RSpec.describe UserPurchase, type: :model do
  it 'has a valid factory' do
    expect(build_stubbed(:user_purchase)).to be_valid
  end
end
