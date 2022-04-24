require 'rails_helper'

RSpec.describe BalanceService, factory_default: :keep do
  subject { described_class }

  let_it_be(:borrower) { create(:user) }
  let_it_be(:purchase) { create(:purchase, user: (create :user)) }
  let_it_be(:purchase2) { create(:purchase, user: (create :user)) }
  let_it_be(:user_purchase) { create(:user_purchase, user: borrower, purchase:, amount: 100) }
  let_it_be(:user_purchase2) { create(:user_purchase, user: borrower, purchase: purchase2, amount: 200) }

  describe '#balance' do
    context 'when there are purchases and no payments' do
      it 'returns sum of purchases' do
        expect(subject.balance(borrower)).to eq(-user_purchase.amount - user_purchase2.amount)
      end
    end

    context 'when there are purchases and payments' do
      let!(:payment) { create(:payment, sender: borrower, receiver: purchase.user, amount: user_purchase.amount) }

      it 'returns sum of purchases minus sum of payments' do
        expect(subject.balance(borrower)).to eq(-user_purchase2.amount)
      end
    end
  end

  describe '#owes_to' do
    context 'when there are purchases and no payments' do
      it 'returns sum of purchases' do
        expect(subject.owes_to(borrower:, lender: purchase.user)).to eq(-user_purchase.amount)
      end
    end

    context 'when there are purchases and payments' do
      let!(:payment) { create(:payment, sender: borrower, receiver: purchase.user, amount: user_purchase.amount) }

      it 'returns sum of purchases minus sum of payments' do
        expect(subject.owes_to(borrower:, lender: purchase.user)).to eq 0
      end
    end
  end
end
