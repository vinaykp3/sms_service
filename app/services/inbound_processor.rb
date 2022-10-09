class InboundProcessor < Base
  def initialize(params, account)
    super
  end

  def process
    InboundValidator.new(params, account, "to").validate
    set_cache_for_stop
    message("inbound sms ok", "")
  rescue Exceptions::InvalidParams => e
    message("", e.message)
  rescue Exceptions::ParamMissing => e
    message("", e.message)
  rescue Exceptions::InvalidData => e
    message("", e.message)
  rescue => e
    message("", "unknown failure")
  end

  def set_cache_for_stop
    return unless params[:text].gsub(/\s+/m, ' ').strip.split(" ").include?("STOP")
    key = CacheKeys::STOP_SMS_DATA % { :from => params[:from], :to => params[:to] }
    Rails.cache.write(key, params[:text], expires_in: (Time.now + 4.hours).to_i)
  end
end