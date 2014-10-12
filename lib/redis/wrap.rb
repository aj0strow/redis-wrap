class Redis
  def [](key)
    Wrap.new(key)
  end

  class Wrap
    attr_reader :key

    def initialize(key)
      @key = key
    end

    def method_missing(command, *arguments, &block)
      arguments = arguments.map do |argument|
        if argument.is_a?(Redis::Wrap)
          argument.key
        else
          argument
        end
      end

      redis.send(command, key, *arguments, &block)
    end

    def redis
      Redis.current
    end
  end
end
