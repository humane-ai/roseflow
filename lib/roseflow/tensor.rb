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
      process(value, type)
    end

    def validate_type(type)
      raise ArgumentError, "Data type #{type} is not (yet) supported." unless supported_type?(type)
      assign_type_settings(TYPEMAP[:type])
    end

    private

    def assign_type_settings(typemap)

    end

    def process(value, type)
      if value.is_a?(Numo::NArray)
        @shape = value.shape
      elsif value.is_a?(Array)
        shape = self.class.shape_of(value)
        @shape = narray_class(type).new(*shape).shape
      else
        @shape = []
      end

      @rank = @shape.size
    end

    def supported_type?(type)
      TYPEMAP.keys.include?(type)
    end

    def narray_class(type)
      TYPEMAP[type].last
    end

    def self.shape_of(value)
      if value.is_a?(Array)
        if value.any? { |ele| ele.is_a?(Array) }
          dim = value.group_by { |ele| ele.is_a?(Array) && shape_of(ele) }.keys
          [value.size] + dim.first if dim.size == 1 && dim.first
        else
          [value.size]
        end
      else
        []
      end
    end
  end
end
