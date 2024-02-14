FactoryBot.define do
  factory :habit do
    name { 'test' }
    description { 'test_description' }
    start_date { Date.today }
    end_date { Date.today + 5.days }
    association :user
  end
end
