FactoryBot.define do
  factory :user do
    name {'sampler'}
    email {'123456@sample.com'}
    password {'password'}
    password_confirmation {'password'}
  end

  factory :current_user, class: User do
    name {'current_sampler'}
    email {'999999929292@sample.com'}
    password {'password'}
    password_confirmation {'password'}
    admin {'true'}
  end
end