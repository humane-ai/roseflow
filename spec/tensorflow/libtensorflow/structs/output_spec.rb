# encoding: utf-8

require "spec_helper"

RSpec.describe Roseflow::Tensorflow::Structs::Output do
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
      expect(subject[:oper]).to be_a Roseflow::Tensorflow::Structs::Operation
    end
  end

  context "with a filled struct pointer" do
    let(:data) do
      pointer = FFI::MemoryPointer.new(:int64)
      pointer.write_int64(8192)
      pointer
    end

    let(:memory) do
      klass = Class.new(FFI::Struct) do
        layout  :oper, :pointer,
                :index, :int
      end

      klass.new.tap do |struct|
        struct[:oper] = data
        struct[:index] = 0
      end
    end

    subject(:subject) { described_class.new(memory.pointer) }

    it "has data" do
      expect(subject[:oper]).to be_a Roseflow::Tensorflow::Structs::Operation
      expect(subject[:index]).to eq 0
    end
  end
end
