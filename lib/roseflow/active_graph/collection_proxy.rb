module Roseflow::ActiveGraph
  class CollectionProxy
    attr_reader :klass

    def initialize(klass, collection, owner = nil)
      @klass = klass
      @collection = []
      @owner = owner
    end

    def build(attributes = {}, &block)
      object = @klass.build(attributes, @owner, &block)
      @collection.push(object)
      object
    end

    def add(description = nil, name, data, options, &block)
      attributes = { name: name, data: data, graph: @owner, description: description }.merge(options)
      build(attributes, &block)
    end

    def create_from_input(input, &block)
      object = @klass.build_from_input(input, &block)
      @collection.push(object)
    end

    def empty?
      @collection.size == 0
    end

    def count
      @collection.size
    end

    def first
      @collection.first
    end

    def last
      @collection.last
    end

    alias_method :new, :build
  end
end
