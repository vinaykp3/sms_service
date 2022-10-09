class OutboundProcessor < Base
  def initialize(params, account)
    super
  end

  def process
    OutboundValidator.new(params, account, "from").validate
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
end