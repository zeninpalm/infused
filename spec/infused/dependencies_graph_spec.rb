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
  
  it "records dependecy relationships" do
    Infused::DependenciesGraph[:First] = []
    Infused::DependenciesGraph[:Second] = [First]
    Infused::DependenciesGraph[:Final] = [Second]
  end
      
end