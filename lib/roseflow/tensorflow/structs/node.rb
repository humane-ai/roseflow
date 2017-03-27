module Roseflow::Tensorflow
  module Structs
    class Node < FFI::Struct
      layout :data, :pointer
      # layout  :rank, :int32,
      #         :visited, :bool,
      #         :data, :pointer,
      #         :in, :pointer,
      #         :out, :pointer

      def from_json(json)
        definition = ::Google::Protobuf.decode_json(::Roseflow::Tensorflow::Protobuf::NodeDef, json)
        from_protobuf(definition)
      end

      def from_protobuf(nodedef)
        binary = nodedef.to_proto
        byte_count = binary.unpack("C*").size
        pointer = FFI::MemoryPointer.new(:char, byte_count)
        pointer.put_bytes(0, binary, 0, byte_count)
        pointer
      end
    end
  end
end
