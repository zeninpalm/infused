Infused
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
  inclue Infused
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

More to come
____________