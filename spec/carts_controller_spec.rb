describe Carts do
  describe 'GET #show' do
    it 'requires login' do
      get :show
      expect(response).to redirect_to login_url
    end
  end
end
