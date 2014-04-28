module Infused
  class Registry
    def initialize
      @map = {}
    end
    
    def add(klass, id)
      @map[id] = klass
    end
    
    def has?(id)
      @map.has_key?(id)
    end
    
    def get(id)
      if not has?(id)
        raise ConstructorNotRegisteredError.new
      end
      @map[id]
    end
    
    def entries_count
      @map.count
    end
    
    def remove(id)
      @map.delete(id)
    end
  end
end
