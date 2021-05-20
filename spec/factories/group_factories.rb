FactoryBot.define do
  sequence :group_name do |ii|
    "Group #{ii}"
  end

  factory :group do
    name { generate :group_name }
  end
end
