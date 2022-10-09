class OutboundValidator < Validator
  def initialize(params, account, to)
    super
  end

  def validate
    super
    is_stopped_number?
    invalid_hit?
  end

  private

  def is_stopped_number?
    message = "sms from #{params[:from]} to #{params[:to]} blocked by STOP request"
    raise Exceptions::InvalidData.new(message) if stopped_number
  end

  def stopped_number
    key = CacheKeys::STOP_SMS_DATA % { :from => params[:from], :to => params[:to] }
    CacheKeys.fetch(key)
  end

  def invalid_hit?
    message = "limit reached for from #{params[:from]}"
    raise Exceptions::InvalidData.new(message) if number_of_outbounds == 50
  end

  def number_of_outbounds
    key = CacheKeys::SMS_OUTBOUND_COUNT % { :date => Date.today, :from => params[:from] }
    CacheKeys.fetch(key)
  end

end