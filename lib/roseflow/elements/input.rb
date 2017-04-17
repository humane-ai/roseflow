module Roseflow::Elements
  class Input < BaseElement
    attr_reader :name

    def initialize(args = {}, &block)
      super(args)
      @name = args[:name]
      extract_options(args)
      create_placeholder if args.has_key?(:placeholder) && args.fetch(:placeholder)
      yield if block_given?
    end

    def create_placeholder
      unless @graph.instance_of?(Roseflow::Graph)
        raise Roseflow::UnknownGraphError, "You must specify associated graph to create a placeholder"
      end
      graph.placeholders.create_from_input(self)
    end

    def extract_options(args)
      [ :data, :type, :shape, :graph, :description ].each do |option|
        if args.has_key?(option)
          instance_variable_set("@#{option}", args.fetch(option))
          class_eval do
            attr_reader option
          end
        end
      end
    end

    def self.build(attributes = {}, &block)
      new(attributes, &block)
    end
  end
end
