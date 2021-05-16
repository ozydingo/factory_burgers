FactoryBot.define do
  factory :comment do
    author
    post
    body { "Lorem ipsum, dolor sit amet." }
  end
end
