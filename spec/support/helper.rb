# frozen_string_literal: true

# テストユーザーがログイン中の場合にtrueを返す
def is_logged_in?
  !session[:user_id].nil?
end

# feature spec 用テストユーザーがログインしていればtrueを返す
def logged_on?(user)
  click_link 'Account' if current_path == user_path(user)
  page.has_link? 'Log out'
end

# テストユーザーとしてログインする
def log_in_as(user)
  session[:user_id] = user.id
end

def remember(user)
  user.remember
  cookies.permanent.signed[:user_id] = user.id
  cookies.permanent[:remember_token] = user.remember_token
end

# テストユーザーとしてログインする remember_meをcheckした状態
def log_in_with_remember(user, password: 'password', remember_me: '1')
  visit login_path
  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password
  # expect(page).to have_checked_field("Remember me on this computer")
  check 'Remember me on this computer' if remember_me == '1'
  click_on 'Log in'
end