FactoryBot.define do
  factory :user do
    name {'tanaka'}
    email {'example@example.com'}
    password {'foobar'}
    password_confirmation {'foobar'}
  end

  factory :michael, class: User do
    name { 'Michael Example' }
    email { 'michael@example.com' }
    password { 'password' }
    password_digest { User.digest('password') }
  end

end