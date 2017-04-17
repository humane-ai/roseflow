module Roseflow::Elements
  class BaseElement

    def initialize(args = {})
      raise ArgumentError, "Invalid arguments" unless args.instance_of?(Hash)
    end
  end
end
