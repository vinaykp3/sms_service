require 'rails_helper'

RSpec.describe Account, type: :model do
  describe "associations" do
  	it "should has_many phonenumbers" do
  		assc = described_class.reflect_on_association(:phone_numbers)
      expect(assc.macro).to eq :has_many
  	end
  end
end
