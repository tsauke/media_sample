require 'rails_helper'

RSpec.describe "Users_login", type: :system do

  describe 'Users login' do
    let(:user) { FactoryBot.create(:michael) }
    # let(:params) { { name: 'michael', email: 'user@example.com', password: 'foobar' } }

    context 'when login with valid information followed by logout' do
      scenario 'login changes layouts' do
        visit login_path
        expect(page).to have_selector 'h1', text: 'Log in'
        # ログインフォームに有効な情報を入れる
        fill_in 'Email',    with: user.email
        fill_in 'Password', with: user.password
        # ボタンをクリックする
        click_button 'Log in'
        # ログインに成功したことを検証
        expect(current_path).to eq user_path(user)
        expect(page).to have_link nil, href: login_path, count: 0
        expect(page).to have_link nil, href: logout_path
        expect(page).to have_link nil, href: user_path(user)
        # logout
        click_link 'Log out'
        expect(current_path).to eq root_path
        expect(page).to have_link nil, href: login_path
        expect(page).to_not have_link nil, href: logout_path
        expect(page).to_not have_link nil, href: user_path(user)
      end
    end
  end
end