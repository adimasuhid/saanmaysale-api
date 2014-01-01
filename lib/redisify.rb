class Redisify
  REDIS_URL = $config.redis_prod_url #change for development
  def self.recover_cache(key, duration, &block)
    redis = Redis.new(:host => uri.host,
                      :port => uri.port,
                      :password => uri.password)
    if redis[key]
      data = redis[key]
    else
      data = block.call
      redis[key] = data
      redis.expire(key, duration)
    end

    data
  end

  def self.uri
    URI.parse(REDIS_URL)
  end

end
