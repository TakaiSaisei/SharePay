require 'rails_helper'

RSpec.describe DebtsController, type: :controller do
  include_context 'authenticated_user'

  describe '#index' do
    it 'returns 200' do
      get :index
      expect(response).to have_http_status :ok
    end
  end
end
