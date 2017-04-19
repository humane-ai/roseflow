module Roseflow::ActiveGraph
  class Placeholder
    def initialize(args = {}, &block)
      raise ArgumentError, "Invalid arguments" unless args.instance_of?(Hash)
      yield if block_given?
    end

    def self.build_from_input(input)
      new()
    end
  end
end
