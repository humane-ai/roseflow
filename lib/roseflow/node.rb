module Roseflow
  class Node
    PROTOBUF_CLASS = ::Roseflow::Tensorflow::Protobuf::NodeDef

    attr_reader :graph
    attr_reader :inputs
    attr_reader :data_type

    def initialize(*args)
      if args.any?
        options = args.fetch(0)
        if options.is_a?(::Hash) && options.keys.include?(:definition)
          @definition = options[:definition]
          # process(@definition)
          @inputs = options[:definition].input
          extract_data_type
        end
      end
    end

    def extract_data_type
      if @definition.attr["dtype"]
        @data_type = Roseflow::Elements::DataType.from_attr(@definition.attr)
      end
    end

    def method_missing(name, *args)
      if [ :name, :op, :input, :device, :attr ].include?(name.to_sym)
        @definition.send(name, *args)
      else
        super(name, *args)
      end
    end

    class << self
      def from_nodedef(definition)
        new(
          definition: definition
        )
      end
    end
  end
end
