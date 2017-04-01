module Roseflow::Elements
  class AttrValue
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

    def method_missing(name, *args)
      if [ :list, :s, :i, :f, :b, :type, :tensor, :placeholder ].include?(name.to_sym)
        @definition.send(name, *args)
      else
        super
      end
    end
  end
end
