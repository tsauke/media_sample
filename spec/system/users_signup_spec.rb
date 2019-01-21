require 'rails_helper'

RSpec.describe "Users_signup", type: :system do

  let(:user) { FactoryBot.build(:user) }

  it "Signupページにページ遷移できるか" do
    visit root_path
    click_on "Sign up"

    expect(page).to have_content("Sign up")
  end

  it "ユーザー登録できること" do
    visit new_user_path

    expect {
      fill_in "Name", with: user.name
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      fill_in "Password confirmation", with: user.password_confirmation
      click_button "Create my account"
    }.to change(User, :count).to(1)
  end

  it "エラーメッセージが正しく表示されること" do
    visit new_user_path

    fill_in "Name", with: " "
    fill_in "Email", with: " "
    fill_in "Password", with: " "
    fill_in "Password confirmation", with: " "
    click_button "Create my account"

    expect(page).to have_content("can't be blank")

  end
end
