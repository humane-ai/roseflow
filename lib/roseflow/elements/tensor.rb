module Roseflow::Elements
  class Tensor
    PROTOBUF_CLASS = ::Roseflow::Tensorflow::Protobuf::TensorProto

    attr_reader :definition

    def initialize(args = {})
      raise ArgumentError, "Invalid arguments" unless args.instance_of?(Hash)
      assign_definition(args) if args.has_key?(:definition)
    end

    def dimensions
      @dimensions ||= parse_dimensions_from_definition
    end

    def assign_definition(args)
      if definition_is_json?(args)
        parse_from_json(args.fetch(:definition))
      else
        @definition = args.fetch(:definition)
      end
    end

    def definition_is_json?(args)
      args.has_key?(:json) && args.fetch(:json)
    end

    def parse_dimensions_from_definition
      extract_shape
    end

    def parse_from_json(json)
      @definition = Google::Protobuf.decode_json(PROTOBUF_CLASS, json)
    end

    def extract_shape
      definition.tensor_shape.dim.map do |dim|
        dim.size
      end
    end
  end
end
