FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user_#{n}@example.com"}
    password { "password" }
    password_confirmation { "password" }
    
    # User_modelに基づいたProfile_modelを作成
    after(:build) do |user|
      build(:profile, user: user)
    end
  end
end
