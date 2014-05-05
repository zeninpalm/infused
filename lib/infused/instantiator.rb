module Infused
  class Instantiator
    def self.make(graph, id)
      relation = graph.get(id)
      dependencies = relation[:dependencies]
      instance = relation[:class].new
      keys = dependencies.keys
      keys.each do |k|
        t = self.make(graph, dependencies[k].name.to_sym)
        eval "instance.#{k.to_s} = t"
      end
      instance
    end
  end
end
