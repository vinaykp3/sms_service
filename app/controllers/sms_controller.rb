class SmsController < ApplicationController
  def inbound
  	render json: InboundProcessor.new(sms_params, @current_account).process
  end

  def outbound
  	render json: OutboundProcessor.new(sms_params, @current_account).process
  end

  private

  	def sms_params
  		params.except("controller", "action", "sm")
  	end
end
