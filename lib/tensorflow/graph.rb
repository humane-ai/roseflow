module TensorFlow
  class Graph
    attr_reader :name

    def initialize(*args)
      if args && args.is_a?(Hash) && args[:name]
        @name = args[:name]
      else
        @name = "My Graph"
      end
    end

    def name=(value)
      @name = value
    end

    def to_graphdef
      TensorFlow::LibTensorFlow::Protobuf::GraphDef.new
    end
  end
end
