module Infused
  class Container
    def register(constructor, id = nil)
      if id.nil?
        @ctors_map[constructor.class.to_s.to_sym] = constructor
      else
        @ctors_map[id] = constructor
      end
    end

    def instantiate(id, *args, **kwargs)
      if @ctors_map.has_key?(id)
        return @ctors_map[id].new(*args, **kwargs)
      else
        raise ContructorNotRegisteredError.new
      end
    end
  end
end
