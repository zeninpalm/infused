require "spec_helper"

# Classes to be tested
class FirstService
  include Infused
end

class SecondService
  include Infused
  
  def initialize(a, b, *args)
  end
end

class ThirdService
  include Infused
  
  depends :FirstService, as: :first
end

class ServiceConsumer
  include Infused
  depends :FirstService, as: :first
  depends :SecondService, as: :second, with: [1, 2, other=[3, 4]]
  
  def to_s
    "#{@first.class} - #{@second.class}"
  end          
end

class SecondServiceConsumer
  include Infused
  depends :SecondService, as: :second, with: [2, 3]
  depends :ThirdService, as: :third
end
# End

describe Infused do

  describe "when being included" do
    
    it "injects adds setters and getters automatically" do
      c = ServiceConsumer.new
      expect(c).to respond_to(:first)
      expect(c).to respond_to(:first=)      
      expect(c).to respond_to(:second)
      expect(c).to respond_to(:second=)
    end
    
    it "instantiates instances with dependencies automatically" do
      c = ServiceConsumer.new
      expect(c.to_s).to eq('FirstService - SecondService')
    end
    
    context "when dependencies are recursive" do
      it "recursively builds dependencies" do
        c = SecondServiceConsumer.new
        expect(c).to respond_to(:second)
        expect(c.third).to respond_to(:first)
      end
    end
  end
  
  describe "container" do
    
  end
  
end
