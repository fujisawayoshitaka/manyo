FactoryBot.define do
  factory :user do
    name { 'yoshitaka1' }
    email { '1@gmail.com' }
    password { 'yoshitaka1' }
    password_confirmation { 'yoshitaka1' }
    admin {true}
  end
  factory :user2 , class: User do
    name { "yoshitaka2" }
    email { "2@gmail.com" }
    password { "yoshitaka2" }
    password_confirmation { "yoshitaka2" }
    admin {false}
  end

end
