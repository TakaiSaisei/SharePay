RSpec.shared_context 'user' do
  before(:all) do
    @user = TestProf::AnyFixture.register(:user) { create(:user) }
  end

  let(:user) { TestProf::AnyFixture.register(:user) }
end
