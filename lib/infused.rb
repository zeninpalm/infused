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
      define_readers(attributes)
      define_setters(attributes)
      append_dependencies(attributes)          
    end
    
    private
    
    def append_dependencies(attributes)
      klass = self.name.to_sym
      
      attributes.keys.each do |k|
        DependenciesGraph.append_dependency(klass, k, attributes[k])
      end
    end
    
    def define_readers(attributes)
      attributes.keys.each do |as|
        define_method "#{as.to_s}" do
          instance_variable_get "@#{as.to_s}"
        end
      end
    end
    
    def define_setters(attributes)
      attributes.keys.each do |as|
        define_method "#{as.to_s}=" do |value|
          instance_variable_set("@#{as.to_s}", value)
        end
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
