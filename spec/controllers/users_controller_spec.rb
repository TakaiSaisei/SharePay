require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  include_context 'authenticated_user'

  describe '#index' do
    it 'returns 200' do
      get :index
      expect(response).to have_http_status :ok
    end
  end

  describe '#show' do
    context 'with user' do
      let(:user) { create(:user) }

      it 'returns user' do
        get :show, params: { id: user.id }
        expect(response).to have_http_status :ok
        expect(response.body).to eq user.to_json
      end
    end

    context 'without user' do
      it 'returns 404' do
        get :show, params: { id: 0 }
        expect(response).to have_http_status :not_found
      end
    end
  end

  describe '#update' do
    let(:user) { create(:user) }

    context 'with processable params' do
      let(:user_attributes) { attributes_for(:user) }

      it 'updates user' do
        expect do
          put :update, params: { id: user.id, user: user_attributes }
          user.reload
        end.to change { user.phone }.to user_attributes[:phone]

        expect(response).to have_http_status :no_content
      end
    end

    context 'with unprocessable params' do
      it 'returns 422' do
        expect do
          put :update, params: { id: user.id, user: { phone: nil } }
          user.reload
        end.not_to change { user.phone }

        expect(response).to have_http_status :unprocessable_entity
      end
    end
  end

  describe '#destroy' do
    let!(:user) { create(:user) }

    it 'destroys user' do
      expect do
        delete :destroy, params: { id: user.id }
      end.to change { User.count }.by(-1)

      expect(response).to have_http_status :no_content
    end
  end
end
