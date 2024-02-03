FactoryBot.define do
  factory :profile do
    user_name { "ユーザー名" }
    user # Profile_modelに基づいているUser_modelを指定
  end
end
