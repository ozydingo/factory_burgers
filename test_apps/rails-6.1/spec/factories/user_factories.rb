FactoryBot.define do
  FIRSTNAMES = %w[Alice Bob Claire Dylan]
  LASTNAME = %w[Doe Smith Johnson]
  sequence :user_firstname do |ii|
    FIRSTNAMES[ii % FIRSTNAMES.length]
  end

  sequence :user_lastname do |ii|
    LASTNAMES[ii % LASTNAMES.length]
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
