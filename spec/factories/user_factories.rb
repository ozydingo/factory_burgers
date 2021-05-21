FactoryBot.define do
  sequence :user_email do |ii|
    "somebody#{ii}@provider.net"
  end

  sequence :user_login do |ii|
    "somebody#{ii}"
  end

  sequence :user_name do |ii|
    firstnames = %w[Alice Bob Claire Dylan]
    firstnames[ii % firstnames.length]
  end

  factory :user do
    email { generate :user_email }
    login { generate :user_login }
    name { generate :user_name }

    trait :silly do
      name { generate(:user_name) + "?" }
    end

    trait :serious do
      name { generate(:user_name) + "!" }
    end
  end
end
