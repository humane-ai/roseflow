module Roseflow::Elements
  class TensorShape
    def initialize(*args)
      if args.any?
        assign_definition(args) if has_definition?(args)
      end
    end

    def dimensions
      @dimensions ||= if @definition
        @definition.dim
      else
        []
      end
    end

    def assign_definition(args)
      @definition = args.select{|arg| arg.is_a?(Hash) }.first[:definition]
    end

    def has_definition?(args)
      hashie = args.select{ |arg| arg.is_a?(Hash) }
      if hashie.any?
        hashie.first.has_key?(:definition)
      end
    end
  end
end
