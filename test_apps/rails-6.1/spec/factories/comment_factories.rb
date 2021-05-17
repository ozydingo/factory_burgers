FactoryBot.define do
  factory :comment do
    association :author, factory: "user"
    association :post
    body { "Lorem ipsum, dolor sit amet." }
  end
end
