# `redis-wrap`

Every web application needs Redis. The problem is that Redis does not have a schema, which forces the developer to establish conventions across the code base. The goal of `redis-wrap` is to have one key declaration per object to avoid spaghetti code.

### Examples

Here's how it works. Set up Redis in initialization code.

```ruby
require 'redis'
require 'redis-wrap'

Redis.current = Redis.new()
```

State the key once and then access methods.

```ruby
redis = Redis.current

counter = redis['counter']
# => #<Redis::Wrap @key="counter">

counter.incr
# => 1

counter.incr
# => 2

counter.del
counter.incr
# => 1
```

Wraps may be used interchangably as keys.

```ruby
class User
  def interests
    Redis::Wrap.new("users:#{id}:interests")
  end
end

jack.interests.sadd(%w(music cooking gardening dancing))
jean.interests.sadd(%w(movies music dancing))

jack.interests.sinter(jean.interests)
# => [ "music", "dancing" ]
```

The wrap is simply a ruby object so you can extend functionality.

```ruby
require 'marshal'

class CachedFind < Redis::Wrap
  def initialize(klass, id)
    @klass = klass
    @id = id
  end

  def key
    "#{@klass.underscore}:#{@id}")
  end

  def fetch
    binary = get
    if binary.present?
      Marshal.load(binary)
    else
      klass.find(id).tap do |model|
        set(Marshal.dump(model))
      end
    end
  end
end

CachedFind.new(User, params[:id]).fetch
```

### Install

**TODO.**
