require 'spec_helper'

class ClassToBeRegistered
end

describe Infused::Container do
  
  
  context "when registering with constructors" do
    before do
      @container = Infused::Container.new
    end
        
    context "when constructors are named" do  
      it "registers constuctor with given id" do  
        @container.register(ClassToBeRegistered, id = :class_to_be_registered)
        expect(@container.has?(:class_to_be_registered)).to be_true
      end
    end
  
    context "when constructors are not named" do
      it "registers constructor with class name symbol" do
        @container.register(ClassToBeRegistered)
        expect(@container.has?(:ClassToBeRegistered)).to be_true
      end
    end
  end
  
  context "when registering with implementations" do
    before do
      @container = Infused::Container.new
      @ins = ClassToBeRegistered.new
      @ins_1 = ClassToBeRegistered.new
    end
    
    it "registers implementations under the symbol of class name" do
      @container.add(@ins)
      expect(@container.has?(:ClassToBeRegistered)).to be_true
    end
    
    it "returns the same instance" do
      @container.add(@ins)
      i = @container.get(:ClassToBeRegistered)
      expect(i).to be_equal(@ins)
    end
    
    it "registers implementation under given symbol" do
      @container.add(@ins_1, :ins_1)
      expect(@container.has?(:ins_1)).to be_true
    end
    
    it "returns the same instance with given id" do
      @container.add(@ins_1, :ins_1)
      i = @container.get(:ins_1)
      expect(i).to be_equal(@ins_1)
    end
  end
end
