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
      expect(subject[:graph]).to be_a TensorFlow::LibTensorFlow::Structs::Graph
      # expect(subject[:index]).to eq 0
    end

    # it "is empty" do
    #   expect(subject[:oper]).to be_null
    # end
  end
end
