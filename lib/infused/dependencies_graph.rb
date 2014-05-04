module Infused
  class DependenciesGraph
    @dependency_map = {}
    def self.add(id, klass)
      @dependency_map[id] = {class: klass, dependencies:[]}
    end
    
    def self.has?(id)
      @dependency_map.has_key?(id)
    end
    
    def self.get(id)
      @dependency_map[id]
    end
    
    def self.append_dependency(id, class_symbol)
      @dependency_map[id][:dependencies] << (eval class_symbol.to_s)
    end
  end
end
