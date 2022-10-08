class Account < ApplicationRecord
	self.table_name = 'account'

	has_many :phone_numbers, class_name: "PhoneNumber", foreign_key: "account_id" 
end
