# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  phone      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe User, type: :model do
  let_it_be(:user) { create :user }

  it 'has a valid factory' do
    expect(user).to be_valid
  end
end
