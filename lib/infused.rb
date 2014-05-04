require 'infused/container'
require 'infused/exception'

module Infused
  def self.included(klass)
    klass.extend(MacroMethods)
  end
  
  module MacroMethods
    def depends(attributes) 
      define_readers(attributes)
      define_setters(attributes)          
    end
    
    private
    
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
