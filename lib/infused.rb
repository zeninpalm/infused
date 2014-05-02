require 'infused/container'
require 'infused/registry'
require 'infused/exception'
require 'infused/instantiator'

module Infused
  def self.included(klass)
    Registry.add(klass, klass.name.to_sym)
    klass.extend(MacroMethods)
  end
  
  module MacroMethods
    def depends(attribute, as: attribute.name.to_sym, with: [])
      old_initialize = instance_method(:initialize)
      
      define_method "initialize" do
        it = Instantiator.new(Registry)
        instance_variable_set("@#{as.to_s}", it.get_instance(attribute, *with))
        old_initialize.bind(self).call
      end
      
      define_method "#{as.to_s}" do
        instance_variable_get "@#{as.to_s}"
      end
      
      define_method "#{as.to_s}=" do |value|
        instance_variable_set("@#{as.to_s}", value)
      end      
    end
  end
end
