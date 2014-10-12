require 'redis/wrap'

describe Redis do
  describe '#[]' do
    it 'should return a wrap' do
      assert_equal(redis['test'].class, Redis::Wrap)
    end

    it 'should pass itself' do
      assert_equal(redis['test'].redis, redis)
    end
  end
end

describe Redis::Wrap do
  describe 'string' do
    let(:string) { redis['string'] }

    it 'should set and get' do
      string.set('hello')
      assert_equal(string.get, 'hello')
    end
  end

  describe 'counter' do
    let(:counter) { redis['counter'] }

    it 'should increment' do
      assert_equal(counter.incr, 1)
    end

    it 'should decrement' do
      counter.incr
      assert_equal(counter.decr, 0)
    end
  end

  describe 'set' do
    it 'should intersect' do
      s1 = redis['set:1']
      s2 = redis['set:2']
      s3 = redis['set:3']

      s1.sadd(%w(1 2 3))
      s2.sadd(%w(2 3 4))
      s3.sadd(%w(3 4 5))

      assert_equal(s1.sinter(s2, s3), %w(3))
    end
  end

  describe 'leaderboard' do
    let(:leaderboard) { redis['leaderboard'] }

    it 'should get top scores' do
      leaderboard.zadd([ [ 7, 'abc' ], [ 23, 'xyz' ] ])
      leaders = leaderboard.zrevrange(0, -1)
      assert_equal(leaders, %w(xyz abc))
    end
  end
end
