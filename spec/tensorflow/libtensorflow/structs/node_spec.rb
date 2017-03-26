# encoding: utf-8

require "spec_helper"

RSpec.describe TensorFlow::LibTensorFlow::Structs::Node do
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
      expect(subject[:data]).to be_a FFI::Pointer
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
      binary = nodedef.to_proto
      byte_count = binary.unpack("C*").size
      pointer = FFI::MemoryPointer.new(:char, byte_count)
      pointer.put_bytes(0, binary, 0, byte_count)
      pointer
    end

    let(:memory) do
      klass = Class.new(FFI::Struct) do
        layout  :data, :pointer
      end

      klass.new.tap do |struct|
        struct[:data] = data
      end
    end

    subject(:subject) { described_class.new(memory.pointer) }

    it "has data" do
      expect(subject[:data]).to be_a FFI::Pointer
    end
  end

  context "Initialize with NodeDef" do
    context "NodeDef as JSON" do
      let(:json) { File.read(fixture_path + "/operation/const_variable.json") }

      subject(:subject) { described_class.new }

      it "is initialized and has data" do
        expect(subject).to be_a described_class
        pointer = subject.from_json(json)
        expect(pointer).to be_a FFI::Pointer
        subject[:data] = pointer
        expect(pointer).to eq subject[:data]
      end
    end

    context "NodeDef as protobuf" do
      let(:json) { File.read(fixture_path + "/operation/const_variable.json") }
      let(:protobuf_class) { ::TensorFlow::LibTensorFlow::Protobuf::NodeDef }
      let(:protobuf) { ::Google::Protobuf.decode_json(protobuf_class, json) }

      subject(:subject) { described_class.new }

      it "is initialized and has data" do
        pointer = subject.from_protobuf(protobuf)
        expect(pointer).to be_a FFI::MemoryPointer
        subject[:data] = pointer
        expect(pointer).to eq subject[:data]
      end
    end
  end
end
