module Roseflow
  # Tensor is an n-dimensional array or list which represents one of the outputs
  # of an Operation.
  #
  # A Tensor is a symbolic handle to one of the outputs of an Operation. It does
  # not hold the values of that operation's output, but instead provides a means
  # of computing those values in a TensorFlow session.
  #
  # This class has two primary purposes:
  #
  # - A Tensor can be passed as an input to another Operation. This builds a
  #   dataflow connection between operations, which enables TensorFlow to execute
  #   an entire Graph that represents a large, multi-step computation.
  # - After the graph has been launched in a session, the value of the Tensor can
  #   be computed by passing it to Session.
  class Tensor
    TYPEMAP = {
      float:    [ Roseflow::Tensorflow::API::enum_value(:dt_float), 8, Float, Numo::DFloat ],
      float64:  [ Roseflow::Tensorflow::API::enum_value(:dt_double), 8, Float, Numo::DFloat ],
      int32:    [ Roseflow::Tensorflow::API::enum_value(:dt_int32), 4, Integer, Numo::Int32 ],
      int64:    [ Roseflow::Tensorflow::API::enum_value(:dt_int64), 4, Integer, Numo::Int64 ],
      string:   [ Roseflow::Tensorflow::API::enum_value(:dt_string), 8, String ],
      complex:  [ Roseflow::Tensorflow::API::enum_value(:dt_complex128), 16, Complex, Numo::SComplex ]
    }

    attr_reader :shape
    attr_reader :rank

    def initialize(value, type = nil)
      validate_type(type)
      assign_type_settings(type)
      process(value, type)
    end

    def number_of_elements
      count = 1
      return count if shape.empty?
      shape.map{ |i| count *= i }.last
    end

    def self.supported_type?(type)
      TYPEMAP.keys.include?(type)
    end

    private

    def assign_type_settings(typemap)

    end

    def validate_type(type)
      raise ArgumentError, "Data type #{type} is not (yet) supported." unless self.class.supported_type?(type)
    end

    def process(value, type)
      if value.is_a?(Numo::NArray)
        @shape = value.shape
      elsif value.instance_of?(Array)
        shape = self.class.shape_of(value)
        @shape = narray_class(type).new(*shape).shape
      else
        @shape = []
      end

      @rank = @shape.size
    end

    def narray_class(type)
      TYPEMAP.fetch(type).last
    end

    def self.shape_of(value)
      if value.instance_of?(Array)
        if value.any? { |ele| ele.instance_of?(Array) }
          dim = value.group_by { |ele| ele.instance_of?(Array) && shape_of(ele) }.keys
          [value.size] + dim.first if dim.size.eql?(1)
        else
          [value.size]
        end
      else
        []
      end
    end
  end
end
