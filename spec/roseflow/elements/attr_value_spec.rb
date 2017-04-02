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
        let(:attr_value) { described_class.new(attr_value_def) }

        it "parses the shape" do
          expect(attr_value).to be_a described_class
          expect(attr_value.shape).to be_a Roseflow::Elements::TensorShape
          expect(attr_value.shape.dimensions).to eq []
        end
      end

      context "with a tensor" do
        let(:json) { File.read(fixture_path + "/attr_value/json/tensor.json") }
        let(:attr_value) { described_class.definition_from_json(json) }

        it "parses the tensor" do
          expect(attr_value).to be_a described_class
          expect(attr_value.tensor).to be_a Roseflow::Elements::Tensor
          expect(attr_value.tensor.dimensions).to eq [784, 10]
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
end
