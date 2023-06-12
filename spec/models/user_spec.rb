RSpec.describe "Users", type: :system do
  before do
    driven_by(:rack_test)
  end
  
  describe '#create' do
    context '無効な値の場合' do
      it 'エラーメッセージ用の表示領域が描画されていること' do
        visit signup_path
        fill_in 'Name', with: ''
        fill_in 'Email', with: 'user@invlid'
        fill_in 'Password', with: 'foo'
        fill_in 'Confirmation', with: 'bar'
        click_button 'Create my account'
  
        expect(page).to have_selector 'div#error_explanation'
        expect(page).to have_selector 'div.field_with_errors'
      end
    end
  end

  context '有効な値の場合' do
    let(:user_params) { { user: { name: 'Example User',
                                  email: 'user@example.com',
                                  password: 'password',
                                  password_confirmation: 'password' } } }
 
    it '登録されること' do
      expect {
        post users_path, params: user_params
      }.to change(User, :count).by 1
    end
 
    it 'users/showにリダイレクトされること' do
      post users_path, params: user_params
      user = User.last
      expect(response).to redirect_to user
    end
    it 'flashが表示されること' do
      post users_path, params: user_params
      expect(flash).to be_any
    end
  end
 end