# == Schema Information
#
# Table name: payments
#
#  id          :bigint           not null, primary key
#  currency    :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  receiver_id :bigint
#  sender_id   :bigint
#
# Foreign Keys
#
#  fk_rails_...  (receiver_id => users.id)
#  fk_rails_...  (sender_id => users.id)
#
require 'rails_helper'

RSpec.describe Payment, type: :model do
  it 'has a valid factory' do
    expect(build_stubbed(:payment)).to be_valid
  end
end
