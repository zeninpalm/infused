Infused 1.0
=============

Infused is a lightweight yet flexible dependency container and dependency injection framework for Ruby.
This framework adapts some best practices in Pimple and Injectable, and the users of the them will find
Infused somewhat familiar. Even though you've never used any DI before, you'll have no any difficulty in
learning this framework. I hope you enjoy Infused as much as I do!

Usage
_____

The simplest scenario

```ruby
class FirstService
  include Infused
end

class SecondService
  include Infused
  depends_on first: :FirstService
end

class ServiceConsumer
  include Infused
  depends_on first: :FirstService, second: :SecondService
end
```

Now `ServiceConsumer` will get two setters and two getters, namely `first`,`second`,`first=` and `second=`.
The constructor is not affected in anyway. And client may get instances of ServiceConsumer as below

```ruby
container = Infused::Container.new
sc = container.get(:ServiceConsumer)
```

A more complex scenario

```ruby
class FirstService
  include Infused
end

class SecondService
  include Infused
  depends_on first: :FirstService
  
  def initialize(other_parameters)
    @value = other_parameter
  end
end
```

Now `SecondService` cannot be instantiated automatically since we don't know what value 
`other_parameters` should be assigned to. So, we may use container like the below:

```ruby
container = Infused::Container.new
container.register(:SecondService) do |c|
  f = c.get(:FirstService)
  s = SecondService.new
  s.first = f
  s
end
service_object = container.get(:SecondService)
```

If you want container to always return the same instance, in order to avoid extra initialization costs,
you may use container like this

```ruby
class DBService
  include Infused
end

class DBConsumer
  include Infused
  depends_on db: :DBService
end

container = Infused::Container.new
container.share(:db_service) do |c|
  DBService.new
end
container.register(:consumer) do |c|
  consumer = DBConsumer.new
  consumer.db = c.get(:db_service)
  consumer
end

c = container.get(:consumer)
```
More to come
____________
