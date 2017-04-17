# encoding: utf-8

require "spec_helper"

RSpec.describe Roseflow::Elements::BaseProtobufElement do
  describe "Initializing" do
    context "with a definition" do
      let(:json) { File.read(fixture_path + "/tensor/json/multidim.json") }
      let(:definition) { Roseflow::Tensorflow::Protobuf::TensorProto.new }

      it "will assign the definition" do
        stub_const("#{described_class}::PROTOBUF_CLASS", Roseflow::Tensorflow::Protobuf::TensorProto)
        element = described_class.new({ definition: definition })
        expect(element).to be_a described_class
        expect(element.definition).not_to be_nil
        expect(element.definition).to be_a Roseflow::Tensorflow::Protobuf::TensorProto
      end

      it "will assign the definition from JSON" do
        stub_const("#{described_class}::PROTOBUF_CLASS", Roseflow::Tensorflow::Protobuf::TensorProto)
        element = described_class.new({ definition: json, json: true })
        expect(element).to be_a described_class
        expect(element.definition).not_to be_nil
        expect(element.definition).to be_a Roseflow::Tensorflow::Protobuf::TensorProto
      end
    end

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

    describe "#parse_from_json" do
      it "attempts to parse the JSON to protobuf definition with Google::Protobuf" do
        stub_const("#{described_class}::PROTOBUF_CLASS", FalseClass)
        expect(Google::Protobuf).to receive(:decode_json).with(FalseClass, {}.to_json)
        element = described_class.new
        element.parse_from_json({}.to_json)
      end
    end
  end
end
