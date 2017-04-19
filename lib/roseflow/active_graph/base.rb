module Roseflow::ActiveGraph
  class Base
    attr_reader :graph

    def initialize
      @graph = Roseflow::Graph.new
    end

    def inputs
      @inputs ||= ::Roseflow::ActiveGraph::CollectionProxy.new(::Roseflow::ActiveGraph::Input, :inputs, self)
    end

    def placeholders
      @placeholders ||= ::Roseflow::ActiveGraph::CollectionProxy.new(::Roseflow::ActiveGraph::Placeholder, :placeholders, self)
    end

    def weights
      @weights ||= ::Roseflow::ActiveGraph::CollectionProxy.new(::Roseflow::ActiveGraph::Weight, :weights, self)
    end

    def biases
      @biases ||= ::Roseflow::ActiveGraph::CollectionProxy.new(::Roseflow::ActiveGraph::Bias, :biases, self)
    end
  end
end
