module CacheKeys
  STOP_SMS_DATA = "STOPSMS:%{from}:%{to}".freeze
  SMS_OUTBOUND_COUNT = "OUTBOUND_COUNT:%{date}:%{from}".freeze
  class << self
    def fetch(key)
      Rails.cache.read(key)
    end
  end
end