module Infused
  class Container
    def initialize
      @ctors_map = {}
      @instantiated_map = {}
    end
    
    def register(id, &block)
      @ctors_map[id] = { block: block, shared: false }
    end
    
    def share(id, &block)
      @ctors_map[id] = { block: block, shared: true }
    end

    def get(id)
      if not @ctors_map.has_key? id
        raise ConstructorNotRegisteredError.new "id:#{id} is not registered"
      end
      
      if @ctors_map[id][:shared] == false
        @ctors_map[id][:block].call(self)
      else
        if @instantiated_map[id] == nil
          @instantiated_map[id] = @ctors_map[id][:block].call(self)
        end
        @instantiated_map[id]
      end
    end
    
    def has?(id)
      @ctors_map.has_key?(id)
    end
  end
end
