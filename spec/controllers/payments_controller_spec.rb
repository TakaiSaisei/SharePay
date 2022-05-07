require 'rails_helper'

RSpec.describe PaymentsController, type: :controller do
  include_context 'authenticated_user'
  render_views

  describe '#index' do
    it 'returns 200' do
      get :index
      expect(response).to have_http_status :ok
    end
  end

  describe '#create' do
    context 'with processable params' do
      let(:payment_attributes) do
        attributes_for(:payment).merge(receiver_id: create(:receiver).id)
      end

      it 'creates payment' do
        expect do
          post :create, params: payment_attributes
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
end
