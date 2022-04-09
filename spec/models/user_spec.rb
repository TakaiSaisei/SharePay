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
require 'rails_helper'

RSpec.describe User, type: :model do
  let_it_be(:user) { create :user }

  it 'has a valid factory' do
    expect(user).to be_valid
  end

  describe '#owes' do
    let_it_be(:receiver) { create :user }
    let_it_be(:amount) { 100 }

    context 'when there are no payments and purchases' do
      it 'returns 0' do
        expect(user.owes(receiver)).to eq 0
      end
    end

    context 'when there are purchases and no payments' do
      let!(:purchases) { create_list :purchase, 3, :with_items, user: receiver, items_user: user, items_amount: amount }

      it 'returns sum of purchases' do
        expect(user.owes(receiver)).to eq(-amount * 3)
      end
    end

    context 'when there are purchases and payments' do
      let!(:purchases) { create_list :purchase, 3, :with_items, user: receiver, items_user: user, items_amount: amount }
      let!(:payment) { create_list :payment, 2, sender: user, amount:, receiver: }

      it 'returns sum of purchases minus sum of payments' do
        expect(user.owes(receiver)).to eq(-amount)
      end
    end
  end
end
