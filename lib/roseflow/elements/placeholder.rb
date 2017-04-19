module Roseflow::Elements
  class Placeholder < BaseElement
    def initialize(args = {}, &block)
      super(args)
      yield if block_given?
    end

    def self.build_from_input(input)
      new()
    end
  end
end
