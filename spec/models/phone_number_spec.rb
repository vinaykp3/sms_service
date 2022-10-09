require 'rails_helper'

RSpec.describe PhoneNumber, type: :model do
  
  describe "associations" do
  	it "should belong to account" do
  		assc = described_class.reflect_on_association(:account)
      expect(assc.macro).to eq :belongs_to
  	end
  end

end
