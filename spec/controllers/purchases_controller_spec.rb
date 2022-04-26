require 'rails_helper'

RSpec.describe PurchasesController, type: :controller do
  include_context 'authenticated_user'
  render_views

  describe '#index' do
    it 'returns 200' do
      get :index
      expect(response).to have_http_status :ok
    end
  end

  describe '#show' do
    context 'with purchase' do
      let(:purchase) { create(:purchase) }

      it 'returns purchase' do
        get :show, params: { id: purchase.id }
        expect(response).to have_http_status :ok
      end
    end

    context 'without purchase' do
      it 'returns 404' do
        get :show, params: { id: 0 }
        expect(response).to have_http_status :not_found
      end
    end
  end

  describe '#create' do
    context 'with processable params' do
      let(:purchase_attributes) { attributes_for(:purchase) }
      let(:user_purchase) { attributes_for(:user_purchase).merge(user_phone: user.phone) }

      it 'creates purchase and user purchases' do
        expect do
          post :create, params: { purchase: purchase_attributes.merge({ user_purchases_attributes: [user_purchase] }) }
        end.to change { Purchase.count }.by(1).and change { UserPurchase.count }.by(1)

        expect(response).to have_http_status :created
        expect(JSON.parse(response.body, symbolize_names: true)).to include purchase_attributes
      end
    end
  end
end
