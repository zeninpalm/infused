describe Infused::Instantiator do
  before do
    class First
      include Infused
    end
    
    class Second
      include Infused
      depends_on first: :First
    end
    
    class Third
      include Infused
      depends_on first: :First, second: :Second
    end
    
  end
  
  it "produces instance for class First" do
    f = Infused::Instantiator.make(Infused::DependenciesGraph, :First)
    expect(f.class.name.to_sym).to be_eql(:First)
  end
  
  it "produces instance for class Second" do
    s = Infused::Instantiator.make(Infused::DependenciesGraph, :Second)
    expect(s.class.name.to_sym).to be_eql(:Second)
    expect(s).to respond_to(:first)
    expect(s).to respond_to(:first=)
  end
  
  it "produces instance for class Third" do
    t = Infused::Instantiator.make(Infused::DependenciesGraph, :Third)
    expect(t.class.name.to_sym).to be_eql(:Third)
    expect(t).to respond_to(:first)
    expect(t).to respond_to(:first=)
    expect(t).to respond_to(:second)
    expect(t).to respond_to(:second=)
    expect(t.second).to respond_to(:first)
    expect(t.second).to respond_to(:first=)
  end
end