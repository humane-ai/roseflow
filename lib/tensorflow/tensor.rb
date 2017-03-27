module TensorFlow
  class Tensor
    TYPEMAP = {
      float:    [ TensorFlow::LibTensorFlow::API::enum_value(:dt_float), 8, Float, Numo::DFloat ],
      float64:  [ TensorFlow::LibTensorFlow::API::enum_value(:dt_double), 8, Float, Numo::DFloat ],
      int32:    [ TensorFlow::LibTensorFlow::API::enum_value(:dt_int32), 4, Integer, Numo::Int32 ],
      int64:    [ TensorFlow::LibTensorFlow::API::enum_value(:dt_int64), 4, Integer, Numo::Int64 ],
      string:   [ TensorFlow::LibTensorFlow::API::enum_value(:dt_string), 8, String ],
      complex:  [ TensorFlow::LibTensorFlow::API::enum_value(:dt_complex128), 16, Complex, Numo::SComplex ]
    }

    attr_reader :shape

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
        array = narray_class(type).new(value.size, value.first.size)
        @shape = array.shape
      else
        @shape = []
      end
    end

    def supported_type?(type)
      TYPEMAP.keys.include?(type)
    end

    def narray_class(type)
      TYPEMAP[type].last
    end
  end
end
