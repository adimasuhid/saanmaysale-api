class Redisify
  def self.recover_cache(key, duration, &block)
    redis = Redis.new
    if redis[key]
      data = redis[key]
    else
      data = block.call
      redis[key] = data
      redis.expire(key, duration)
    end

    data
  end
end
