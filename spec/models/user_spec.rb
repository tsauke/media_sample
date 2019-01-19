require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { FactoryBot.build(:user) }

  it "userが有効" do
    user.valid?
  end

  it "名前が無効" do
    user.email = " "

    expect(user).to be_invalid
  end

  it "名前が長すぎないか" do
    user.name = "a" * 51
    expect(user).to be_invalid
  end

  it "メールが長すぎないか" do
    user.email = "a" * 244 + "@example.com"
    expect(user).to be_invalid
  end

  it "有効なメールアドレスか" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                              foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      user.email = invalid_address
      expect(user).to be_invalid
    end
  end

  it "一意か" do
    duplicate_user = user.dup
    user.save
    expect(duplicate_user).to be_invalid
  end

  it "パスワードが６桁の時" do
    user.password = "a" * 6
    binding.pry
    user.password_confirmation = "a" * 6
    expect(user).to be_valid
  end

  it "パスワードが５桁の時" do
    user.password = "a" * 5
    user.password_confirmation = "a" * 5
    expect(user).to be_invalid
  end




end