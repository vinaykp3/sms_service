class PhoneNumber < ApplicationRecord
  self.table_name = 'phone_number'

  belongs_to :account,  class_name: "Account", foreign_key: "account_id"
end
