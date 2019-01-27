require 'rails_helper'

RSpec.describe "Users_signup", type: :system do

  let(:user) { FactoryBot.build(:user) }

  it "Signupページにページ遷移できるか" do
    visit root_path
    click_on "登録する"

    expect(page).to have_content("Sign up")
  end

  it "ユーザー登録できること" do
    visit new_user_path

    expect {
      fill_in "名前", with: user.name
      fill_in "メール", with: user.email
      fill_in "パスワード", with: user.password
      fill_in "パスワード再入力", with: user.password_confirmation
      click_button "登録する"
    }.to change(User, :count).to(1)
  end

  it "エラーメッセージが正しく表示されること" do
    visit new_user_path

    fill_in "名前", with: " "
    fill_in "メール", with: " "
    fill_in "パスワード", with: " "
    fill_in "パスワード再入力", with: " "
    click_button "登録する"

    expect(page).to have_content("The form contains 5 error.")

  end
end
