module Roseflow::Elements
  class AttrValue
    PROTOBUF_CLASS = ::Roseflow::Tensorflow::Protobuf::AttrValue

    def initialize(attr, *args)
      @definition = attr
      if args.any?
        options = args[0]
        if options.is_a?(::Hash) && options.keys.include?(:definition)
          extract_data_type
        end
      end
    end

    def shape
      @shape ||= TensorShape.new(definition: @definition.send(:shape))
    end

    def tensor
      @tensor ||= Tensor.new(definition: @definition.send(:tensor))
    end

    def method_missing(name, *args)
      if [ :list, :s, :i, :f, :b, :type, :placeholder ].include?(name.to_sym)
        @definition.send(name, *args)
      else
        super
      end
    end

    def self.definition_from_json(json)
      definition = ::Google::Protobuf.decode_json(PROTOBUF_CLASS, json)
      new(definition)
    end
  end
end
