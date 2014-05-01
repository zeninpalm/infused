module Infused
  class Instantiator
    def initialize(registry)
      @registry = registry.clone
    end
    
    def get_instance(id, *args)
      @instance = @registry.get(id).new(*args)
    end
  end
end
