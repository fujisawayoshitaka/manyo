FactoryBot.define do
  factory :user do
    name { "yoshitaka1" }
    email { "1@gmail.com" }
    password_digest { "yoshitaka1" }
  end
  factory :user2 , class: User do
    name { "yoshitaka2" }
    email { "2@gmail.com" }
    password_digest { "yoshitaka2" }
  end

end
