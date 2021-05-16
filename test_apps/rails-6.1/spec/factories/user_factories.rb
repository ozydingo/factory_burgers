FactoryBot.define do
  sequence :user_firstname do |ii|
    firstnames = %w[Alice Bob Claire Dylan]
    firstnames[ii % firstnames.length]
  end

  sequence :user_lastname do |ii|
    lastnames = %w[Doe Smith Johnson]
    lastnames[ii % lastnames.length]
  end

  sequence :user_email do |ii|
    "my_email_#{ii}@provider.net"
  end

  sequence :admin_email do |ii|
    "my_email_#{ii}@company.org"
  end

  sequence :user_login do |ii|
    "user#{ii}"
  end

  factory :user do
    type { "Member" }
    firstname { generate :user_firstname}
    lastname { generate :user_lastname}
    login { generate :user_login}
    email { generate :user_email}
  end

  factory :admin, parent: :user do
    type { "Admin" }
    email { generate :admin_email }
  end
end
