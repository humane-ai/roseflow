module Roseflow::ActiveGraph
  class Input
    attr_accessor :name

    def initialize(args = {}, owner = nil, &block)
      raise ArgumentError, "Invalid arguments" unless args.instance_of?(Hash)
      @name = args[:name]
      @owner = owner
      @graph = @owner.graph if owner
      extract_options(args)
      create_placeholder if args.has_key?(:placeholder) && args.fetch(:placeholder)
      yield if block_given?
    end

    def create_placeholder
      unless @graph.instance_of?(Roseflow::Graph)
        raise Roseflow::UnknownGraphError, "You must specify associated graph to create a placeholder"
      end
      @owner.placeholders.create_from_input(self)
    end

    def extract_options(args)
      [ :data, :type, :shape, :graph, :description ].each do |option|
        if args.has_key?(option)
          instance_variable_set("@#{option}", args.fetch(option))
        end
        class_eval do
          attr_accessor option
        end
      end
    end

    def self.build(attributes = {}, owner = nil, &block)
      new(attributes, owner, &block)
    end
  end
end
