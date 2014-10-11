require 'redis'

class Redis::Key
  attr_reader :redis_key

  def initialize(redis_key)
    @redis_key = redis_key
  end

  def redis
    Redis.current
  end
end
