module Roseflow::Elements
  class BaseProtobufElement < BaseElement
    attr_reader :definition

    def initialize(args = {}, &block)
      super(args, &block)
      assign_definition(args) if args.has_key?(:definition)
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

    def parse_from_json(json)
      @definition = Google::Protobuf.decode_json(self.class::PROTOBUF_CLASS, json)
    end
  end
end
