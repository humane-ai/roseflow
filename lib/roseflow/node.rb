module Roseflow
  class Node
    PROTOBUF_CLASS = ::Roseflow::Tensorflow::Protobuf::NodeDef

    attr_reader :graph

    def initialize(*args)
      if args.any?
        options = args[0]
        if options.is_a?(::Hash) && options.keys.include?(:definition)
          @definition = options[:definition]
          # process(@definition)
        end
      end
    end

    def method_missing(name, *args)
      if [ :name, :op, :input, :device, :attr ].include?(name.to_sym)
        @definition.send(name, *args)
      else
        super
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
