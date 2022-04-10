require 'rails_helper'

RSpec.describe PaymentsController, type: :controller do
  describe '#index' do
    it 'returns 200' do
      get :index
      expect(response).to have_http_status :ok
    end
  end

  describe '#show' do
    context 'with payment' do
      let(:payment) { create(:payment) }

      it 'returns payment' do
        get :show, params: { id: payment.id }
        expect(response).to have_http_status :ok
        expect(response.body).to eq payment.to_json
      end
    end

    context 'without payment' do
      it 'returns 404' do
        get :show, params: { id: 0 }
        expect(response).to have_http_status :not_found
      end
    end
  end

  describe '#create' do
    context 'with processable params' do
      let(:payment_attributes) do
        attributes_for(:payment).merge(receiver_id: create(:receiver).id, sender_id: create(:sender).id)
      end

      it 'creates payment' do
        expect do
          post :create, params: { payment: payment_attributes }
        end.to change { Payment.count }.by(1)

        expect(response).to have_http_status :created
        expect(JSON.parse(response.body, symbolize_names: true)).to include payment_attributes
      end
    end

    context 'with unprocessable params' do
      it 'returns 422' do
        expect do
          post :create, params: { payment: { amount: 1 } }
        end.not_to change { Payment.count }

        expect(response).to have_http_status :unprocessable_entity
      end
    end
  end

  describe '#update' do
    let(:payment) { create :payment }

    context 'with processable params' do
      let(:payment_attributes) { attributes_for(:payment) }

      it 'updates payment' do
        expect do
          put :update, params: { id: payment.id, payment: payment_attributes }
          payment.reload
        end.to change { payment.amount }.to payment_attributes[:amount]

        expect(response).to have_http_status :no_content
      end
    end

    context 'with unprocessable params' do
      it 'returns 422' do
        expect do
          put :update, params: { id: payment.id, payment: { amount: nil } }
          payment.reload
        end.not_to change { payment.amount }

        expect(response).to have_http_status :unprocessable_entity
      end
    end
  end

  describe '#destroy' do
    let!(:payment) { create :payment }

    it 'destroys payment' do
      expect do
        delete :destroy, params: { id: payment.id }
      end.to change { Payment.count }.by(-1)

      expect(response).to have_http_status :no_content
    end
  end
end
