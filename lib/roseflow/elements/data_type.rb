module Roseflow::Elements
  class DataType
    TYPEMAP = {
      DT_FLOAT: :float,
      DT_DOUBLE: :double,
      DT_INT32: :int32,
      DT_INT64: :int64
    }

    class << self
      def cast(type)
        TYPEMAP[type]
      end

      def from_attr(attr)
        unless attr["dtype"]
          raise ArgumentError, "You did not provide AttrValue to resolve the data type from."
        end
        cast(attr["dtype"].type)
      end
    end
  end
end
