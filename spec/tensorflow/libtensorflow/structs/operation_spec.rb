# encoding: utf-8

require "spec_helper"

RSpec.describe TensorFlow::LibTensorFlow::Structs::Operation do
  context "with null pointer" do
    subject(:subject) { described_class.new(FFI::Pointer::NULL) }

    it "creates a struct" do
      expect(subject).to be_a described_class
    end

    it "is null" do
      expect(subject).to be_null
    end
  end

  context "with an empty pointer" do
    let(:memory) do
      pointer = FFI::MemoryPointer.new(:int64)
      pointer.write_int64(0)
      pointer
    end

    subject(:subject) do
      pointer = FFI::Pointer.new(memory.address)
      described_class.new(pointer)
    end

    specify do
      expect(subject[:node]).to be_a TensorFlow::LibTensorFlow::Structs::Node
    end
  end

  context "with a filled struct pointer" do
    let(:nodedef) do
      shape = TensorFlow::LibTensorFlow::Protobuf::TensorShapeProto.new
      tensor = TensorFlow::LibTensorFlow::Protobuf::TensorProto.new(float_val: [5.0], dtype: TensorFlow::LibTensorFlow::Protobuf::DataType::DT_FLOAT, tensor_shape: shape)
      attrvalue = TensorFlow::LibTensorFlow::Protobuf::AttrValue.new(tensor: tensor)
      nodedef = TensorFlow::LibTensorFlow::Protobuf::NodeDef.new(name: "a/initial_value", op: "Const")
      nodedef.attr["dtype"] = TensorFlow::LibTensorFlow::Protobuf::AttrValue.new(type: TensorFlow::LibTensorFlow::Protobuf::DataType::DT_FLOAT)
      nodedef.attr["value"] = attrvalue
      nodedef
    end

    let(:data) do
      pointer = FFI::MemoryPointer.new(:int64)
      pointer.write_string(nodedef.to_proto)
    end

    let(:memory) do
      klass = Class.new(FFI::Struct) do
        layout  :node, :pointer
      end

      klass.new.tap do |struct|
        struct[:node] = FFI::MemoryPointer.new(nodedef.to_proto)
      end
    end

    subject(:subject) { described_class.new(memory.pointer) }

    it "has data" do
      expect(subject[:node]).to be_a TensorFlow::LibTensorFlow::Structs::Node
    end
  end
end
