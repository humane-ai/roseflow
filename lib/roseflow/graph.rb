require "roseflow/tensorflow"
require "roseflow/tensorflow/protobuf"

module Roseflow
  module Errors
    class JSONValidationError < StandardError
    end
  end

  class Graph
    PROTOBUF_CLASS = ::Roseflow::Tensorflow::Protobuf::GraphDef

    attr_reader :name
    attr_reader :nodes
    attr_reader :definition

    alias :layers :nodes

    def initialize(*args)
      if args && args.is_a?(Hash) && args[:name]
        @name = args[:name]
      else
        @name = "My Graph"
      end
      @nodes = []
    end

    def name=(value)
      @name = value
    end

    def from_json(json)
      @definition = ::Google::Protobuf.decode_json(PROTOBUF_CLASS, json)
      convert_to_nodes
    end

    def from_file(file)
      @definition = ::Google::Protobuf.decode(PROTOBUF_CLASS, file.read)
      convert_to_nodes
    ensure
      file.close
    end

    def convert_to_nodes
      definition.node.each do |node|
        @nodes << Node.from_nodedef(node)
      end
    end

    def to_graphdef
      PROTOBUF_CLASS.new
    end
  end
end
