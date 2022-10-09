FactoryBot.define do
  factory :account do
    # id {1}
    auth_id { "12345" }
    username { "blah" }
  end

  factory :phone_number do
    # id {1}
    number { "1234589" }
    association :account, factory: :account
  end
end