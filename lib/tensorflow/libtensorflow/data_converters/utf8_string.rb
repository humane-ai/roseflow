module TensorFlow::LibTensorFlow
  module UTF8String
    extend FFI::DataConverter
    native_type FFI::Type::STRING

    class << self
      def to_native(value, ctx)
        value && value.encode(Encoding::UTF_8)
      end

      def from_native(value, ctx)
        value && value.force_encoding(Encoding::UTF_8)
      end
    end
  end
end
