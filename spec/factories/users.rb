FactoryBot.define do
  factory :user do
    name {'tanaka'}
    email {'example@example.com'}
    password {'foobar'}
    password_confirmation {'foobar'}
  end
end