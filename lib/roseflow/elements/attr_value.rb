module Roseflow::Elements
  class AttrValue < BaseProtobufElement
    PROTOBUF_CLASS = ::Roseflow::Tensorflow::Protobuf::AttrValue

    attr_reader :definition

    def type
      @type ||= if definition
        Roseflow::Tensorflow::Protobuf::DataType.const_get(definition.public_send(:type))
      else
        :undefined
      end
    end

    def shape
      @shape ||= TensorShape.new(definition: definition.public_send(:shape))
    end

    def tensor
      @tensor ||= Tensor.new(definition: definition.public_send(:tensor))
    end

    def self.definition_from_json(json)
      definition = Google::Protobuf.decode_json(PROTOBUF_CLASS, json)
      new(definition: definition)
    end

    private

    def method_missing(name, *args)
      if [ :list, :s, :i, :f, :b, :placeholder ].include?(name)
        definition.public_send(name, *args)
      else
        super
      end
    end
  end
end
