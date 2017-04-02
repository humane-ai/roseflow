module Roseflow::Elements
  class AttrValue < BaseElement
    PROTOBUF_CLASS = ::Roseflow::Tensorflow::Protobuf::AttrValue

    attr_reader :definition

    def shape
      @shape ||= TensorShape.new(definition: definition.public_send(:shape))
    end

    def tensor
      @tensor ||= Tensor.new(definition: definition.public_send(:tensor))
    end

    def self.definition_from_json(json)
      definition = ::Google::Protobuf.decode_json(PROTOBUF_CLASS, json)
      new(definition: definition)
    end

    private

    def method_missing(name, *args)
      if [ :list, :s, :i, :f, :b, :type, :placeholder ].include?(name)
        definition.public_send(name, *args)
      else
        super
      end
    end
  end
end
