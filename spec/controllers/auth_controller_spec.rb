require 'rails_helper'

RSpec.describe AuthController, type: :controller do
  include_context 'user'

  describe '#login' do
    context 'without sms code' do
      it 'sends code' do
        post :login, params: { auth: { phone: user.phone } }
        expect(response).to have_http_status :ok
      end
    end

    context 'when sms code is not right' do
      it 'returns 409' do
        post :login, params: { auth: { phone: user.phone, sms_code: '4321' } }
        expect(response).to have_http_status :conflict
      end
    end

    context 'when user exists' do
      it 'returns token' do
        expect_any_instance_of(JsonWebToken).to receive(:encode_token).with({ user_id: user.id }).and_return('token')
        post :login, params: { auth: { phone: user.phone, sms_code: '1234' } }
        expect(response).to have_http_status :ok
        expect(JSON.parse(response.body)).to include('token' => 'token')
      end
    end

    context 'when user not exists' do
      let(:user_attributes) { attributes_for(:user) }

      it 'creates new user' do
        expect_any_instance_of(JsonWebToken).to receive(:encode_token).with(any_args).and_return('token')
        expect do
          post :login, params: { auth: { phone: user_attributes[:phone], sms_code: '1234' } }
        end.to change(User, :count).by(1)
        expect(response).to have_http_status :created
        expect(JSON.parse(response.body)).to include('token' => 'token')
      end
    end
  end
end
