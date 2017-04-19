module Roseflow
  # Graph is a TensorFlow computation, represented as a dataflow graph.
  #
  # A graph contains a set of Operation objects, which represent units of
  # computation; and Tensor objects, which represent the units of data that
  # flow between operations.
  class Graph
    PROTOBUF_CLASS = ::Roseflow::Tensorflow::Protobuf::GraphDef

    attr_reader :definition
    attr_reader :name
    attr_reader :nodes
    attr_reader :variables

    # alias :layers :nodes

    def initialize(*args)
      if args.is_a?(Hash) && args.has_key?(:name)
        @name = args[:name]
      else
        @name = "My Graph"
      end
      @nodes = []
      @variables = []
    end

    def name=(value)
      @name = value
    end

    def run
      session = Session.new
      session.graph = self
      session.run
    end

    # Load a graph definition from JSON and convert to nodes and operations
    def definition_from_json(json)
      @definition = Google::Protobuf.decode_json(PROTOBUF_CLASS, json)
      convert_definition_to_nodes
    end

    # Load a graph definition from a file and convert to nodes and operations
    def definition_from_file(file)
      @definition = Google::Protobuf.decode(PROTOBUF_CLASS, file.read)
      convert_definition_to_nodes
    ensure
      file.close
    end

    def add_variable(variable)
      @variables.push(variable) if variable.is_a?(::Roseflow::Elements::Variable)
    end

    # Converts protobuf definition to nodes and operations
    def convert_definition_to_nodes
      definition.node.each do |node|
        @nodes << Node.from_nodedef(node)
      end
    end

    # Converts current graph into a protobuf definition
    def to_graphdef
      return false unless @description.is_a?(::Roseflow::TensorFlow::Protobuf::GraphDef)
      definition
    end

    def to_proto
      return false unless @description.is_a?(::Roseflow::TensorFlow::Protobuf::GraphDef)
      to_graphdef.to_proto
    end
  end
end
