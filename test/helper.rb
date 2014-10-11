require 'redis'
require 'minitest/autorun'

Redis.current = Redis.new(db: 0)

class Minitest::Spec
  after(:each) do
    Redis.current.flushdb
  end
end

