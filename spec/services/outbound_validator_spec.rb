require 'rails_helper'

RSpec.describe OutboundValidator do
	describe "should vaidate and raise the exceptions for invalid data" do
		before :each do
			@account = create(:account)
		end

		describe "validate the outbound messages" do
			it "should raise exception if the number is blocked" do
				allow(CacheKeys).to receive(:fetch).and_return(true)
				ph = create(:phone_number, account_id: @account.id)
				params = {"from"=>ph.number, "to"=>ph.number, "text"=>"sent"}
				validator = OutboundValidator.new(params, @account, "from")
				expect { validator.validate }.to raise_error(Exceptions::InvalidData)
			end

			it "should raise exception if outbound count is reached 50" do
				allow(CacheKeys).to receive(:fetch).and_return(true)
				ph = create(:phone_number, account_id: @account.id)
				params = {"from"=>ph.number, "to"=>ph.number, "text"=>"sent"}
				validator = OutboundValidator.new(params, @account, "from")
				expect { validator.validate }.to raise_error(Exceptions::InvalidData)
			end
		end
	end
end