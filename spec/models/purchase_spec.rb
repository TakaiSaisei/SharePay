# == Schema Information
#
# Table name: purchases
#
#  id           :bigint           not null, primary key
#  description  :string
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
require 'rails_helper'

RSpec.describe Purchase, type: :model do
  it 'has a valid factory' do
    expect(build_stubbed(:purchase)).to be_valid
  end
end
