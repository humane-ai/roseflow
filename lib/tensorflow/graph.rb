require "tensorflow/libtensorflow"
require "tensorflow/libtensorflow/protobuf"

module TensorFlow
  module Errors
    class JSONValidationError < StandardError
    end
  end

  class Graph
    PROTOBUF_CLASS = ::TensorFlow::LibTensorFlow::Protobuf::GraphDef
    attr_reader :name
    attr_reader :nodes
    attr_reader :definition

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
    end

    def from_file(file)
      @definition = ::Google::Protobuf.decode(PROTOBUF_CLASS, file.read)
    ensure
      file.close
    end

    def to_graphdef
      PROTOBUF_CLASS.new
    end
  end
end
