REDIS_CLIENT = Redis.new(url: ENV["REDIS_ENDPOINT"] || "redis://localhost:6379" )
# REDIS_CACHE = Redis::Namespace.new('sms_redis_cache', redis: REDIS_CLIENT)