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

class ServiceConsumer
  include Infused
  depends first: :FirstService, another_first: :FirstService, second: :SecondService
  
  def to_s
    "#{@first.class} - #{@another_first.class} - #{@second.class}"
  end          
end

class ThirdService
  include Infused
  
  depends first: :FirstService
end

class AnotherServiceConsumer
  include Infused
  depends third: :ThirdService
end
# End

describe Infused do

  describe "when being included" do
    
    it "injects adds setters and getters automatically" do
      c = ServiceConsumer.new
      expect(c).to respond_to(:first)
      expect(c).to respond_to(:first=) 
      expect(c).to respond_to(:another_first)
      expect(c).to respond_to(:another_first=)     
      expect(c).to respond_to(:second)
      expect(c).to respond_to(:second=)
    end
    
    it "instantiates instances with dependencies automatically" do
      c = Infused::Container.new
      sc = c.get(:ServiceConsumer)
      expect(sc.to_s).to eq('FirstService - FirstService - SecondService')
    end
    
    context "when dependencies are recursive" do
      it "recursively builds dependencies" do
        c = Infused::Container.new
        sc = c.get(:AnotherServiceConsumer)
        expect(sc).to respond_to(:third)
        expect(sc.third).to respond_to(:first)
      end
    end
  end
end
