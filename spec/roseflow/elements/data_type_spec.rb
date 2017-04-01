# encoding: utf-8

require "spec_helper"

RSpec.describe Roseflow::Elements::DataType do
  describe "Resolving type" do
    context "from AttrValue 'dtype'" do
      it "resolves correct type from AttrValue protobuf definition" do
        value = { "dtype": Roseflow::Tensorflow::Protobuf::AttrValue.new(type: Roseflow::Tensorflow::Protobuf::DataType::DT_FLOAT) }.with_indifferent_access
        expect(described_class.from_attr(value)).to eq :float
      end
    end
  end
end
