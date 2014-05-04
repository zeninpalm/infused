decribe Infused::DependenciesGraph do
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
    expect(Infused::DependenciesGraph[:First][:class]).to be_eql(First)
  end
  
  it "returns corresponding class for :Second"
    expect(Infused::DependenciesGraph[:First][:class]).to be_eql(First)
  end
  
  it "returns corresponding class for :Final"
    expect(Infused::DependenciesGraph[:First][:class]).to be_eql(First)
  end
  
  it "records dependecy relationships" do
    expect(Infused::DependenciesGraph[:First][:dependencies]).to  be_eql([])
    expect(Infused::DependenciesGraph[:Second].[:dependencies]).to be_eql([First])
    expect(Infused::DependenciesGraph[:Final].[:dependencies]).to be_eql([Second])
  end
      
end