# encoding: utf-8

require "spec_helper"
require "roseflow/elements/attr_value"
require "roseflow/elements/tensor"
require "roseflow/elements/tensor_shape"

RSpec.describe Roseflow::Elements::AttrValue do
  describe "Initializing" do
    context "from a protobuf definition" do
      context "with a shape" do
        let(:shape_proto) { Roseflow::Tensorflow::Protobuf::TensorShapeProto.new }
        let(:attr_value_def) { Roseflow::Tensorflow::Protobuf::AttrValue.new(shape: shape_proto) }
        let(:attr_value) { described_class.new(definition: attr_value_def) }

        it "parses the shape" do
          expect(attr_value).to be_a described_class
          expect(attr_value.shape).to be_a Roseflow::Elements::TensorShape
          expect(attr_value.shape.dimensions).to eq []
        end

        it "builds a tensor shape element object" do
          expect(Roseflow::Elements::TensorShape).to receive(:new).with({ definition: shape_proto })
          attr_value.shape
        end
      end

      context "with a tensor" do
        let(:json) { File.read(fixture_path + "/attr_value/json/tensor.json") }
        let(:tensor_json) { File.read(fixture_path + "/tensor/json/multidim.json") }
        let(:definition) { Google::Protobuf.decode_json(Roseflow::Tensorflow::Protobuf::TensorProto, tensor_json) }
        let(:attr_value) { described_class.definition_from_json(json) }

        it "parses the tensor" do
          expect(attr_value).to be_a described_class
          expect(attr_value.tensor).to be_a Roseflow::Elements::Tensor
          expect(attr_value.tensor.dimensions).to eq [784, 10]
        end

        it "builds a tensor element object" do
          expect(Roseflow::Elements::Tensor).to receive(:new).with({ definition: definition })
          attr_value.tensor
        end
      end

      context "with a list" do

      end

      context "with a function" do

      end

      context "with a placeholder" do

      end
    end

    context "protobuf definition from JSON" do
      let(:json) { File.read(fixture_path + "/attr_value/json/tensor.json") }

      it "returns an instance of AttrValue from a protobuf definition in JSON" do
        expect(described_class.definition_from_json(json)).to be_a described_class
      end
    end
  end

  describe "Type" do
    context "No definition present" do
      let(:attr_value) { described_class.new }

      it "returns undefined type" do
        expect(attr_value.type).to eq :undefined
      end
    end

    context "Definition present" do
      let(:json) { File.read(fixture_path + "/attr_value/json/tensor.json") }
      let(:definition) { Google::Protobuf.decode_json(described_class::PROTOBUF_CLASS, json) }
      let(:attr_value) { described_class.new(definition: definition) }

      it "returns the type" do
        expect(attr_value.type).to eq 0
      end
    end
  end

  describe "Method missing" do
    context "methods for protobuf definition" do
      let(:json) { File.read(fixture_path + "/attr_value/json/tensor.json") }
      let(:attr_value_def) { Google::Protobuf.decode_json(described_class::PROTOBUF_CLASS, json) }
      let(:attr_value) { described_class.new(definition: attr_value_def) }

      forwarded_methods = [ :list, :s, :i, :f, :b, :placeholder ]

      forwarded_methods.each do |method|
        it "forwards the method '#{method}' to protobuf definition" do
          expect(attr_value_def).to receive(method)
          attr_value.send(method)
        end

        it "passes arguments along" do
          expect(attr_value_def).to receive(method).with("foo")
          attr_value.send(method, "foo")
        end
      end
    end

    context "calls to super" do
      let(:json) { File.read(fixture_path + "/attr_value/json/tensor.json") }
      let(:attr_value_def) { Google::Protobuf.decode_json(described_class::PROTOBUF_CLASS, json) }
      let(:attr_value) { described_class.new(definition: attr_value_def) }

      it "does not send undefined methods to protobuf definition" do
        expect(attr_value_def).not_to receive(:undefined)
        expect do
          attr_value.undefined
        end.to raise_error NoMethodError
      end

      it "forwards undefined methods the regular way" do
        expect do
          attr_value.undefined
        end.to raise_error NoMethodError
      end
    end
  end
end
