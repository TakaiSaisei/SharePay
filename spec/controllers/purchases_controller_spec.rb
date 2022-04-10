require 'rails_helper'

RSpec.describe PurchasesController, type: :controller do
  describe '#index' do
    context 'without purchases' do
      it 'returns 200' do
        get :index
        expect(response).to have_http_status :ok
      end
    end

    context 'with purchases' do
      let!(:purchases) { create_list(:purchase, 3) }

      it 'returns purchases' do
        get :index
        expect(response).to have_http_status :ok
        expect(JSON.parse(response.body).count).to eq 3
      end
    end
  end

  describe '#show' do
    context 'with purchase' do
      let_it_be(:purchase) { create(:purchase) }

      it 'returns purchase' do
        get :show, params: { id: purchase.id }
        expect(response).to have_http_status :ok
        expect(response.body).to eq purchase.to_json
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
    let_it_be(:purchase_attributes) { nested_attributes_for(:purchase) }

    context 'with processable params' do
      it 'creates purchase' do
        expect do
          post :create, params: { purchase: purchase_attributes }
        end.to change { Purchase.count }.by(1)

        expect(response).to have_http_status :created
        expect(JSON.parse(response.body, symbolize_names: true)).to include purchase_attributes
      end
    end

    context 'with unprocessable params' do
      it 'returns 422' do
        expect do
          post :create, params: { purchase: { name: 'name' } }
        end.not_to change { Purchase.count }

        expect(response).to have_http_status :unprocessable_entity
      end
    end
  end

  describe '#update' do
    let!(:purchase) { create :purchase }

    context 'with processable params' do
      let_it_be(:purchase_attributes) { attributes_for(:purchase) }

      it 'updates purchase' do
        expect do
          put :update, params: { id: purchase.id, purchase: purchase_attributes }
          purchase.reload
        end.to change { purchase.name }.to purchase_attributes[:name]

        expect(response).to have_http_status :no_content
      end
    end

    context 'with unprocessable params' do
      it 'returns 422' do
        expect do
          put :update, params: { id: purchase.id, purchase: { name: nil } }
          purchase.reload
        end.not_to change { purchase.name }

        expect(response).to have_http_status :unprocessable_entity
      end
    end
  end

  describe '#destroy' do
    let!(:purchase) { create :purchase }

    it 'destroys purchase' do
      expect do
        delete :destroy, params: { id: purchase }
      end.to change { Purchase.count }.by -1

      expect(response).to have_http_status :no_content
    end
  end
end
