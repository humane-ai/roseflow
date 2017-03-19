module TensorFlow::LibTensorFlow
  module Utility
    def shape_of(value)
      if value.is_a?(Array)
        if value.any? { |elem| elem.is_a?(Array) }
          dimensions = value.group_by { |elem| elem.is_a?(Array) && shape_of(elem) }.keys
          [value.size] + dimensions.first if dimensions.size == 1 && dimensions.first
        else
          [value.size]
        end
      else
        []
      end
    end
  end
end
