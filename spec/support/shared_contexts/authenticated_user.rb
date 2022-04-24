RSpec.shared_context 'authenticated_user' do
  include_context 'user'

  before do
    allow_any_instance_of(JsonWebToken).to receive(:decoded_token).and_return({ 'user_id' => user.id })
  end
end
