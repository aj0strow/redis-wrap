class Redis
  def [](key)
    Wrap.new(key)
  end

  class Wrap
    attr_reader :key

    def initialize(key)
      @key = key.to_s
    end

    def method_missing(command, *arguments, &block)
      redis.send(command, key, *arguments, &block)
    end

    def redis
      Redis.current
    end

    alias_method :to_s, :key
  end
end
