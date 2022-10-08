FactoryBot.define do
  factory :account do
    auth_id { "12345" }
    username { "blah" }
  end

  factory :phone_number do
    number { "1234589" }
    association :account, factory: :account
  end
end