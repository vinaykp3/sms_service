require 'rails_helper'

RSpec.describe Validator do
	describe "should vaidate and raise the exceptions for invalid data" do
		before :each do
			@account = create(:account)
		end

		context "should raise the exceotion for params missing" do
			it "should raise the exception for from missing" do
				params = { "to"=> "123456", "text"=> "ertre"}
				validator = Validator.new(params, @account, "to")
				expect { validator.validate }.to raise_error(Exceptions::ParamMissing)
			end

			it "should raise the exception for to missing" do
				params = { "from"=> "123456", "text"=> "ertre"}
				validator = Validator.new(params, @account, "to")
				expect { validator.validate }.to raise_error(Exceptions::ParamMissing)
			end

			it "should raise the exception for to missing" do
				params = { "from"=> "123456", "to"=> "8975453"}
				validator = Validator.new(params, @account, "to")
				expect { validator.validate }.to raise_error(Exceptions::ParamMissing)
			end
		end

		context "should raise the exceotion for params invalid" do
			it "should raise the exception for from is invalid" do
				params = { "from"=> "1235", "text"=> "ertre", "to"=> "123478"}
				validator = Validator.new(params, @account, "to")
				expect { validator.validate }.to raise_error(Exceptions::InvalidParams)
			end

			it "should raise the exception for to is invalid" do
				params = { "from"=> "123456", "text"=> "ertre", "to"=>"2345"}
				validator = Validator.new(params, @account, "to")
				expect { validator.validate }.to raise_error(Exceptions::InvalidParams)
			end

			it "should raise the exception for text is invalid" do
				params = { "from"=> "123456", "to"=> "8975453", "text"=>""}
				validator = Validator.new(params, @account, "to")
				expect { validator.validate }.to raise_error(Exceptions::InvalidParams)
			end

			it "should raise the exception for any other than required param is passed" do
				params = { "from"=> "123456", "to"=> "8975453", "text"=>"1234", "check"=>""}
				validator = Validator.new(params, @account, "to")
				expect { validator.validate }.to raise_error(Exceptions::InvalidParams)
			end
		end

		context "should raise exception if data is invalid" do
			it "should raise the exception if from number is not in the account" do
				ph = create(:phone_number, account_id: @account.id)
				params = { "from"=> "123456", "to"=> "8975453", "text"=>"west"}
				validator = Validator.new(params, @account, "to")
				expect { validator.validate }.to raise_error(Exceptions::InvalidData)
			end

			it "should raise the exception if to number is not in the account" do
				ph = create(:phone_number, account_id: @account.id)
				params = { "from"=> "123456", "to"=> "8975453", "text"=>"west"}
				validator = Validator.new(params, @account, "from")
				expect { validator.validate }.to raise_error(Exceptions::InvalidData)
			end
		end

	end
end