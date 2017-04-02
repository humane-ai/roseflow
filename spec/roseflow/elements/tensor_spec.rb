# encoding: utf-8

require "spec_helper"
require "roseflow/elements/tensor"

RSpec.describe Roseflow::Elements::Tensor do
  describe "Initializing" do
    context "with bogus arguments" do
      it "will create an instance but not parse a definition" do
        tensor = described_class.new({ foo: "bar" })
        expect(tensor).to be_a described_class
        expect(tensor.instance_variable_get(:@definition)).to eq nil
      end

      it "will fail with bogus arguments" do
        expect do
          described_class.new("string")
        end.to raise_error ArgumentError, "Invalid arguments"
      end
    end

    context "definition in protobuf" do
      let(:protobuf) { File.read(fixture_path + "/tensor/singledim.proto") }
      let(:definition) { ::Google::Protobuf.decode(::Roseflow::Tensorflow::Protobuf::TensorProto, protobuf) }
      let(:tensor) { described_class.new(definition: definition) }

      it "instantiates a new tensor from protobuf definition" do
        expect(tensor).to be_a described_class
        expect(tensor.dimensions).to eq [10]
      end
    end

    context "definition in JSON" do
      let(:json) { File.read(fixture_path + "/tensor/json/singledim.json") }
      let(:tensor) { described_class.new(definition: json, json: true) }
      let(:protobuf_tensor) { described_class.new(definition: json, json: false) }

      it "instantiates a new tensor from JSON definition" do
        expect(tensor).to be_a described_class
      end

      it "will not instantiate from JSON but protobuf if JSON flag is false" do
        expect(tensor).not_to receive(:parse_from_json)
        expect(tensor).to be_a described_class
      end
    end
  end

  describe "Dimensions" do
    context "No dimensions specified" do

    end

    context "Single dimension" do
      let(:json) { File.read(fixture_path + "/tensor/json/singledim.json") }
      let(:tensor) { described_class.new(definition: json, json: true) }

      it "parses dimensions from protobuf as JSON" do
        expect(tensor.dimensions).to eq [10]
      end
    end

    context "Multiple dimensions" do
      let(:json) { File.read(fixture_path + "/tensor/json/multidim.json") }
      let(:tensor) { described_class.new(definition: json, json: true) }

      it "parses dimensions from protobuf as JSON" do
        expect(tensor.dimensions).to eq [784, 10]
      end
    end
  end

  describe "Methods" do
    describe "#definition_is_json?(args)" do
      let(:json_args) { { definition: "foo", json: true } }
      let(:non_json_args) { { definition: "bar", json: false } }
      let(:no_json_args) { { definition: "baz" } }
      let(:tensor) { described_class.new }

      it "returns true when JSON flag is set" do
        expect(tensor.definition_is_json?(json_args)).to eq true
      end

      it "returns false when JSON flag is not set" do
        expect(tensor.definition_is_json?(non_json_args)).to eq false
      end

      it "returns false when JSON flag is not present" do
        expect(tensor.definition_is_json?(no_json_args)).to eq false
      end
    end
  end
end
