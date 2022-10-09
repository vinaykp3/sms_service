class OutboundProcessor < Base
  def initialize(params, account)
    super
  end

  def process
    OutboundValidator.new(params, account, "from").validate
    set_outbound_count
    message("outbound sms ok", "")
  rescue Exceptions::InvalidParams => e
    message("", e.message)
  rescue Exceptions::ParamMissing => e
    message("", e.message)
  rescue Exceptions::InvalidData => e
    message("", e.message)
  rescue => e
    message("", "unknown failure")
  end

  def set_outbound_count
    key = CacheKeys::SMS_OUTBOUND_COUNT % { :date => Date.today, :from => params[:from] }
    value = CacheKeys.fetch(key).to_i
    value += 1
    Rails.cache.write(key, value, expires_in: (Date.current.end_of_day - Time.now).to_i)
  end
end