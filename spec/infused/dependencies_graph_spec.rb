describe Infused::DependenciesGraph do
  before do
    class First
      include Infused
    end
    
    class Second
      include Infused
      depends_on first: :First
    end
    
    class Final
      include Infused
      depends_on second: :Second
    end
    
    class Other
      include Infused
      depends_on second: :Second, first: :First, third: :First
    end
  end
  
  it "registers :First" do
    expect(Infused::DependenciesGraph.has?(:First)).to be_true
  end
  
  it "registers :Second" do
    expect(Infused::DependenciesGraph.has?(:Second)).to be_true
  end
  
  it "registers :Final" do
    expect(Infused::DependenciesGraph.has?(:Final)).to be_true
  end
  
  it "returns corresponding class for :First" do
    expect(Infused::DependenciesGraph.get(:First)[:class]).to be_eql(First)
  end
  
  it "returns corresponding class for :Second" do
    expect(Infused::DependenciesGraph.get(:Second)[:class]).to be_eql(Second)
  end
  
  it "returns corresponding class for :Final" do
    expect(Infused::DependenciesGraph.get(:Final)[:class]).to be_eql(Final)
  end
  
  it "records dependecy relationships" do
    expect(Infused::DependenciesGraph.get(:First)[:dependencies]).to  be_eql([])
    expect(Infused::DependenciesGraph.get(:Second)[:dependencies]).to be_eql([{first: First}])
    expect(Infused::DependenciesGraph.get(:Final)[:dependencies]).to be_eql([{second: Second}])
    expect(Infused::DependenciesGraph.get(:Other)[:dependencies]).to be_eql([{second: Second}, {first: First}, {third: First}])    
  end     
end