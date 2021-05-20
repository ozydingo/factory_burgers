FactoryBot.define do
  factory :post do
    association :author, factory: "user"
    body { "Lorem ipsum, dolor sit amet." }
  end
end
