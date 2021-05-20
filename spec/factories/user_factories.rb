FactoryBot.define do
  sequence :user_email do |ii|
    "somebody#{ii}@provider.new"
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
  end
end
