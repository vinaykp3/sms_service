module CacheKeys
  STOP_SMS_DATA = "STOPSMS:%{from}:%{to}".freeze
  SMS_OUTBOUND_COUNT = "OUTBOUND_COUNT:%{date}:%{from}".freeze
  class << self
    def cacher
      REDIS_CLIENT
    end

    def get_from_cache(key)
      cacher.get(key)
    end

    def cache(key, value, expiry)
      cacher.setex(key, expiry, value.to_json)
    rescue StandardError
      cacher.setex(key, 2, value)
    end

    def delete_from_cache(key)
      cacher.del(key)
      true
    end

    def fetch(key)
      cache_data = begin
                     get_from_cache(key)
                   rescue StandardError
                     ""
                   end
      JSON.load(cache_data)
    end
  end
end