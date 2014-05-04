require "spec_helper"

# Classes to be tested
class FirstService
  include Infused
end

class SecondService
  include Infused
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
      c.register(:FirstService) do |c|
        FirstService.new
      end
      c.register(:SecondService) do |c|
        SecondService.new
      end
      c.register(:ServiceConsumer) do |c|
        f = c.get(:FirstService)
        f1 = c.get(:FirstService)
        s = c.get(:SecondService)
        sc = ServiceConsumer.new
        sc.first = f
        sc.another_first = f1
        sc.second = s
        sc
      end
      
      sc = c.get(:ServiceConsumer)
      expect(sc.to_s).to eq('FirstService - FirstService - SecondService')
    end
    
    context "when dependencies are recursive" do
      it "recursively builds dependencies" do
        c = Infused::Container.new
        c.register(:First) do |c|
          FirstService.new
        end
        c.register(:ThirdService) do |c|
          f = c.get(:First)
          t = ThirdService.new
          t.first = f
          t
        end
        c.register(:AnotherServiceConsumer) do |c|
          t = c.get(:ThirdService)
          asc = AnotherServiceConsumer.new
          asc.third = t
          asc
        end
        
        sc = c.get(:AnotherServiceConsumer)
        expect(sc).to respond_to(:third)
        expect(sc.third).to respond_to(:first)
      end
    end
  end
end
