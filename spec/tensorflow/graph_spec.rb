# encoding: utf-8

require "spec_helper"

RSpec.describe TensorFlow::Graph do
  context "Initializing a graph" do

  end

  describe "Attributes" do
    subject(:subject) { described_class.new }

    describe "#name" do
      it "has a name" do
        expect(subject.name).to eq "My Graph"
      end

      it "can have a custom name" do
        subject.name = "Awesome Graph"
        expect(subject.name).to eq "Awesome Graph"
      end
    end

    describe "#description" do

    end

    describe "#definition" do

    end

    describe "#nodes" do
      it "returns the nodes of the graph" do
        expect(subject.nodes).to be_a Array
        expect(subject.nodes).to be_empty
      end
    end
  end

  describe "Inputs" do

  end

  describe "Outputs" do

  end

  describe "Loading graph definitions" do
    context "from a protobuf file" do
      context "- Successful" do
        let(:file) { File.open(fixture_path + "/graph/regression_simplified.pb", "r") }
        let(:graph) { described_class.new }

        subject(:subject) { graph.from_file(file) }

        it "loads graph definition from protobuf file" do
          expect(subject).to be_truthy
          expect(graph.definition).to be_a described_class::PROTOBUF_CLASS
          expect(graph.definition.node.count).to eq 13
          expect(graph.definition.node.first.name).to eq "Variable/initial_value"
        end
      end

      context "- Failure" do
        let(:file) { File.open(fixture_path + "/graph/graph_multi_dim.pbtxt", "r") }
        let(:graph) { described_class.new }

        subject(:subject) { graph.from_file(file) }

        it "fails to load files that are not protobuf binaries" do
          expect{ subject }.to raise_error(Google::Protobuf::ParseError).with_message(/Invalid wire type/)
        end
      end
    end

    context "from JSON" do
      context "- Successful" do
        let(:json) { File.read(fixture_path + "/graph/json/regression.json") }
        let(:graph) { described_class.new }

        subject(:subject) { graph.from_json(json) }

        it "loads graph definition from JSON" do
          expect(subject).to be_truthy
          expect(graph.definition).to be_a described_class::PROTOBUF_CLASS
          expect(graph.definition.node.count).to eq 13
          expect(graph.definition.node.first.name).to eq "Variable/initial_value"
        end
      end

      context "- Failure" do
        let(:string) { "Pure string" }
        let(:json) { { "foo": "bar" } }
        let(:graph) { described_class.new }

        subject(:string_action) { graph.from_json(string) }
        subject(:json_action) { graph.from_json(json) }

        it "fails with appropriate error when input is not JSON" do
          expect{ string_action }.to raise_error(Google::Protobuf::ParseError)
        end

        it "fails with JSONValidationError when JSON does not contain necessary elements", skip: "Requires implementation of JSON validator" do
          expect{ json_action }.to raise_error(TensorFlow::Errors::JSONValidationError)
        end
      end
    end
  end

  describe "Graph definitions" do
    context "Converting graph to a graph definition" do
      context "Empty graph" do
        let(:graph) { described_class.new }

        subject(:subject) { graph.to_graphdef }

        it "returns GraphDef of the graph" do
          expect(subject).to be_a described_class::PROTOBUF_CLASS
          expect(subject.node).to be_empty
          expect(subject.library).to be_nil
          expect(subject.version).to eq 0
          expect(subject.versions).to be_nil
        end
      end

      context "Graph with nodes" do

      end

      context "Graph with versions" do

      end
    end
  end
end
