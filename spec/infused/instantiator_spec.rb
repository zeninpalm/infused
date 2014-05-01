require 'spec_helper'

describe Infused::Instantiator do
  before do
    class ClassToBeget_instanced; end

    class AnotherClassToBeget_instanced; end

    class CustomClassToBeget_instanced
      def initialize(arg, *args)
        @arg = arg
        @args = args
      end
  
      def arg
        @arg
      end
  
      def args
        @args
      end
    end
    
    @registry = Infused::Registry.new   
    @registry.add(ClassToBeget_instanced, :ClassToBeget_instanced)
    @registry.add(AnotherClassToBeget_instanced, :another_class_to_be_get_instanced)
    @registry.add(CustomClassToBeget_instanced, :CustomClassToBeget_instanced)
    
    @instantiator = Infused::Instantiator.new(@registry)
  end
  
  it "returns an instance of requested class" do
    instance = @instantiator.get_instance(:ClassToBeget_instanced)
    expect(instance.class).to eq(ClassToBeget_instanced)
  end
  it "returns an instance of given identifier" do
    instance = @instantiator.get_instance(:another_class_to_be_get_instanced)
    expect(instance.class).to eq(AnotherClassToBeget_instanced)
  end
  it "allows passing arguments to data constructors" do
    instance = @instantiator.get_instance(:CustomClassToBeget_instanced, 2, 3, 4, 5)
    expect(instance.arg).to eq(2)
    expect(instance.args).to eq([3, 4, 5])
  end
end