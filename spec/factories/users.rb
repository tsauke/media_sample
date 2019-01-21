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
    admin { true }
  end

  factory :archer, class: User do
    name { 'Sterling Archer' }
    email { 'duchess@example.gov' }
    password { 'password' }
    password_digest { User.digest('password') }
  end

  factory :lana, class: User do
    name { 'Lana Kane' }
    email { 'hands@example.gov' }
    password { 'password' }
    password_digest { User.digest('password') }
  end

end