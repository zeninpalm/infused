require 'infused/container'
require 'infused/exception'
require 'infused/dependencies_graph'
require 'infused/instantiator'

module Infused
  def self.included(klass)
    register_dependencies(klass)
    klass.extend(MacroMethods)
  end
  
  def self.register_dependencies(klass)
    DependenciesGraph.add(klass.name.to_sym, klass) 
  end
  
  module MacroMethods
    def depends_on(attributes)
      define_accessors(attributes)
      append_dependencies(attributes)          
    end
    
    private
    
    def append_dependencies(attributes)
      klass = self.name.to_sym
      
      attributes.keys.each do |k|
        DependenciesGraph.append_dependency(klass, k, attributes[k])
      end
    end

    def define_accessors(attributes)
      attributes.keys.each do |as|
        self.send(:attr_accessor, as.to_sym)
      end
    end
    
    def parameters(*keys)
      keys[0].map { |k| "#{k.to_s}" }.join(",")
    end
    
    def ivars(*keys)
      keys[0].map { |k| "@#{k.to_s}"}.join(",")
    end
  end
end
