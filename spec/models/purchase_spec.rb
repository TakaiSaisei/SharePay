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
require 'rails_helper'

RSpec.describe Purchase, type: :model do
  it 'has a valid factory' do
    expect(build_stubbed(:purchase)).to be_valid
  end

  describe 'callbacks' do
    describe 'update_debt' do
      context 'when purchase created as draft' do
        let(:purchase) { create(:purchase, :with_user_purchases, draft: true) }

        it 'does not update debt' do
          expect(DebtService).not_to receive(:increase)
          purchase
        end

        it 'updates debt after draft is set to false' do
          expect(DebtService).to receive(:increase)
          purchase.update(draft: false)
        end
      end

      context 'when purchase created' do
        let(:purchase) { create(:purchase, :with_user_purchases) }

        it 'updates debt' do
          expect(DebtService).to receive(:increase)
          purchase
        end
      end
    end
  end
end
