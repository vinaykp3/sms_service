require 'rails_helper'

RSpec.describe "Sms", type: :request do

  before :each do
    @account = create(:account, id: 123)
    @headers = { 'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials(@account.username, @account.auth_id) }
  end

  describe "GET /inbound" do
    it "returns error on no params passed" do
      post "/inbound/sms", headers: @headers 
      data = JSON.parse(response.body)
      expect(data["error"]).to eq("from is missing")
    end

    it "returns error on to param is not passed" do
      post "/inbound/sms", headers: @headers, params: {from: "123456677", text: "test"}
      data = JSON.parse(response.body)
      expect(data["error"]).to eq("to is missing")
    end

    it "returns error on text param is not passed" do
      post "/inbound/sms", headers: @headers, params: {from: "123456677", to: "32478887"}
      data = JSON.parse(response.body)
      expect(data["error"]).to eq("text is missing")
    end

    it "returns error if to param is passed is not in the account phone numbers" do
      post "/inbound/sms", headers: @headers, params: {from: "123456677", to: "7866778877", text: "send this" }
      data = JSON.parse(response.body)
      expect(data["error"]).to eq("to parameter not found")
    end

    it "returns error if invalid param is passed" do
      post "/inbound/sms", headers: @headers, params: {from: "123456677", to: "7866778877", text: "send this", text2: "test" }
      data = JSON.parse(response.body)
      expect(data["error"]).to eq("text2 is invalid")
    end

    it "returns error if from value is invalid lenth" do
      post "/inbound/sms", headers: @headers, params: {from: "12345", to: "7866778877", text: "send this" }
      data = JSON.parse(response.body)
      expect(data["error"]).to eq("from is invalid")
    end

    it "returns error if to value is invalid lenth" do
      post "/inbound/sms", headers: @headers, params: {from: "123456", to: "78667788772345679887566", text: "send this" }
      data = JSON.parse(response.body)
      expect(data["error"]).to eq("to is invalid")
    end

    it "returns error if text value is invalid lenth" do
      post "/inbound/sms", headers: @headers, params: {from: "123456", to: "78667788", text: "" }
      data = JSON.parse(response.body)
      expect(data["error"]).to eq("text is invalid")
    end

    it "should be passed with all the valid parameters" do
      ph = create(:phone_number, account_id: @account.id)
      post "/inbound/sms", headers: @headers, params: {from: "123456677", to: ph.number, text: "send this" }
      data = JSON.parse(response.body)
      expect(data["error"]).to eq("")
      expect(data["message"]).to eq("inbound sms ok")
    end

  end

  describe "GET /outbound" do
    it "returns error on no params passed" do
      post "/outbound/sms", headers: @headers 
      data = JSON.parse(response.body)
      expect(data["error"]).to eq("from is missing")
    end

    it "returns error on to param is not passed" do
      post "/outbound/sms", headers: @headers, params: {from: "123456677", text: "test"}
      data = JSON.parse(response.body)
      expect(data["error"]).to eq("to is missing")
    end

    it "returns error on text param is not passed" do
      post "/outbound/sms", headers: @headers, params: {from: "123456677", to: "32478887"}
      data = JSON.parse(response.body)
      expect(data["error"]).to eq("text is missing")
    end

    it "returns error if from param is passed is not in the account phone numbers" do
      post "/outbound/sms", headers: @headers, params: {from: "123456677", to: "7866778877", text: "send this" }
      data = JSON.parse(response.body)
      expect(data["error"]).to eq("from parameter not found")
    end

    it "returns error if invalid param is passed" do
      post "/outbound/sms", headers: @headers, params: {from: "123456677", to: "7866778877", text: "send this", text2: "test" }
      data = JSON.parse(response.body)
      expect(data["error"]).to eq("text2 is invalid")
    end

    it "returns error if from value is invalid lenth" do
      post "/outbound/sms", headers: @headers, params: {from: "12345", to: "7866778877", text: "send this" }
      data = JSON.parse(response.body)
      expect(data["error"]).to eq("from is invalid")
    end

    it "returns error if to value is invalid lenth" do
      post "/outbound/sms", headers: @headers, params: {from: "123456", to: "78667788772345679887566", text: "send this" }
      data = JSON.parse(response.body)
      expect(data["error"]).to eq("to is invalid")
    end

    it "returns error if text value is invalid lenth" do
      post "/outbound/sms", headers: @headers, params: { from: "123456", to: "78667788", text: "" }
      data = JSON.parse(response.body)
      expect(data["error"]).to eq("text is invalid")
    end

    it "returns error if from to to is STOPPED" do
      ph = create(:phone_number, account_id: @account.id)
      allow_any_instance_of(OutboundValidator).to receive(:stopped_number).and_return(true)
      post "/outbound/sms", headers: @headers, params: { from: ph.number, to: "78667788", text: "check" }
      data = JSON.parse(response.body)
      expect(data["error"]).to eq("sms from #{ph.number} to 78667788 blocked by STOP request")
    end

    it "returns error if from to outbound is reached 50" do
      ph = create(:phone_number, account_id: @account.id)
      allow_any_instance_of(OutboundValidator).to receive(:number_of_outbounds).and_return(50)
      post "/outbound/sms", headers: @headers, params: { from: ph.number, to: "78667788", text: "check" }
      data = JSON.parse(response.body)
      expect(data["error"]).to eq("limit reached for from #{ph.number}")
    end

    it "returns unknown failure error" do
      ph = create(:phone_number, account_id: @account.id)
      allow(Rails).to receive(:cache).and_raise("test")
      post "/outbound/sms", headers: @headers, params: { from: ph.number, to: "78667788", text: "check" }
      data = JSON.parse(response.body)
      expect(data["error"]).to eq("unknown failure")
    end

    it "should be passed with all the valid parameters" do
      ph = create(:phone_number, account_id: @account.id)
      post "/outbound/sms", headers: @headers, params: {to: "123456677", from: ph.number, text: "send this" }
      data = JSON.parse(response.body)
      expect(data["error"]).to eq("")
      expect(data["message"]).to eq("outbound sms ok")
    end
  end

end
