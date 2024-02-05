FactoryBot.define do
  factory :post do
    body {"body"}
    association :user
  end
end
