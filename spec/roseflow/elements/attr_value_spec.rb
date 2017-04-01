# encoding: utf-8

require "spec_helper"
require "roseflow/elements/attr_value"
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

      end

      context "with a list" do

      end

      context "with a function" do

      end

      context "with a placeholder" do

      end
    end
  end
end
