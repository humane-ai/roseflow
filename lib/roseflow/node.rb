module Roseflow
  class Node
    PROTOBUF_CLASS = ::Roseflow::Tensorflow::Protobuf::NodeDef

    def initialize(*args)
      if args && args.is_a?(Hash)
        if args.keys.include?(:definition)
          @definition = args[:definition]
        end
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
