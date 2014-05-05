require 'spec_helper'

class ClassToBeRegistered
end

describe Infused::Container do
  
  context "when registering with 'register'" do
    before do
      @container = Infused::Container.new
    end
    
    it "registers direct factory methods" do
      @container.register(:first) do |c|
        3
      end
      expect(@container.has?(:first)).to be_true
    end
    
    it "returns the value of given block" do
      @container.register(:second) do |c|
        4
      end
      expect(@container.get(:second)).to be_equal(4)
    end
    
    it "calls blocks recursively" do
      @container.register(:first) do |c|
        3
      end
      @container.register(:second) do |c|
        4
      end
      @container.register(:third) do |c|
        c.get(:first) + c.get(:second)
      end
      expect(@container.get(:third)).to be_equal(7)
    end
  end
  
  context "when registering with 'share'" do
    before do
      @container = Infused::Container.new
    end
    
    it "registers blocks given in share block" do
      @container.share(:first) do |c|
        3
      end
      expect(@container.has?(:first)).to be_true
    end
    
    it "returns the value of given block" do
      @container.share(:second) do |c|
        4
      end
      expect(@container.get(:second)).to be_equal(4)
    end
    
    it "calls blocks recursively" do
      @container.share(:first) do |c|
        3
      end
      @container.share(:second) do |c|
        4
      end
      @container.share(:third) do |c|
        c.get(:first) + c.get(:second)
      end
      expect(@container.get(:third)).to be_equal(7)
    end
    
    it "calls blocks lazilly" do
      class Dummy; end
      
      @container.share(:Dummy) do |c|
        Dummy.new
      end
      
      obj_1 = @container.get(:Dummy)
      obj_2 = @container.get(:Dummy)
      
      expect(obj_1).to be_equal(obj_2)
    end
  end
  
  context "when not registered with container, but registered with DependenciesGraph" do
    before do
      class A
        include Infused
      end
      
      class B
        include Infused
        depends_on a: :A
      end
    end
    
    it "returns intance of B automatically" do
      @container = Infused::Container.new
      b = @container.get(:B)
      expect(b.class.name.to_sym).to be_equal(:B)
      expect(b).to respond_to(:a)
      expect(b).to respond_to(:a=)
    end
  end
end
