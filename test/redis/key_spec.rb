require 'redis/key'

describe Redis::Key do
  let(:key) { Redis::Key.new('redis:key') }

  describe '#redis_key' do
    it 'should pass the key back' do
      assert_equal(key.redis_key, 'redis:key')
    end
  end

  describe '#redis' do
    it 'should pick up redis current' do
      assert_equal(key.redis.ping, 'PONG')
    end
  end
end
