
require 'rails_helper'

RSpec. describe 'UserEdit', type: :system do
  let(:user) { FactoryBot.create(:michael) }

  describe 'User edit' do
    context 'when unsuccessful edit' do
      before do
        log_in_with_remember(user)
        visit edit_user_path(user)
      end
      scenario 'return users edit' do
        fill_in '名前',         with: ''
        fill_in 'メール',        with: 'foo@invalid'
        fill_in 'パスワード',     with: 'foo'
        fill_in 'パスワード再入力', with: 'foo'
        click_button '更新する'
        expect(page).to have_selector 'h1', text: 'プロフィールの更新'
      end
    end
    context 'when successful edit with friendly forwarding' do
      before do
        visit edit_user_path(user)
        log_in_with_remember(user)
      end
      scenario 'redirect to user' do
        expect(current_path).to eq edit_user_path(user)
        name = 'Foo Bar'
        email = 'foo@bar.com'
        fill_in 'Name',         with: name
        fill_in 'Email',        with: email
        fill_in 'Password',     with: ''
        fill_in 'Password confirmation', with: ''
        click_button 'Save changes'
        expect(page).to have_selector '.alert'
        expect(current_path).to eq user_path(user)
        user.reload
        expect(user.name).to eq name
        expect(user.email).to eq email
      end
    end
  end
end
