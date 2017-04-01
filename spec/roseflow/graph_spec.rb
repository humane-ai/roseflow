# encoding: utf-8

require "spec_helper"

RSpec.describe Roseflow::Graph do
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

    describe "Nodes" do
      context "Empty graph" do
        it "returns the nodes of the graph" do
          expect(subject.nodes).to be_a Array
          expect(subject.nodes).to be_empty
        end
      end

      context "Graph with nodes" do
        let(:json) { File.read(fixture_path + "/graph/json/regression.json") }

        before do
          subject.definition_from_json(json)
        end

        it "returns the nodes of the graph" do
          expect(subject.nodes).to be_a Array
          expect(subject.nodes.count).to eq 13
          subject.nodes.each do |node|
            expect(node).to be_a Roseflow::Node
          end
        end

        it "allows to access nodes with alias" do
          expect(subject.layers).to be_a Array
          expect(subject.layers.count).to eq 13
        end
      end
    end

    describe "Variables" do
      context "Graph without variables" do
        let(:graph) { described_class.new }

        context "Adding a new variable" do
          let(:variable) { Roseflow::Elements::Variable.new }

          it "adds a new variable to the graph" do
            expect(graph.variables).to be_empty
            expect(graph.add_variable(variable)).to eq true
            expect(graph.variables).to include variable
          end
        end
      end

      context "Graph with variables" do
        let(:graph) { described_class.new }

        pending
      end
    end
  end

  describe "Inputs" do
    pending
  end

  describe "Outputs" do
    pending
  end

  describe "Running the graph" do
    let(:json) { File.read(fixture_path + "/graph/json/regression.json") }
    let(:graph) { described_class.new }

    before do
      graph.definition_from_json(json)
    end

    it "runs the graph with TensorFlow" do
      p graph.to_graphdef
      p graph.to_proto
      expect(graph.run).to be true
    end
  end

  describe "Loading graph definitions" do
    context "from a protobuf file" do
      context "- Successful" do
        let(:file) { File.open(fixture_path + "/graph/regression_simplified.pb", "r") }
        let(:graph) { described_class.new }

        subject(:subject) { graph.definition_from_file(file) }

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

        subject(:subject) { graph.definition_from_file(file) }

        it "fails to load files that are not protobuf binaries" do
          expect{ subject }.to raise_error(Google::Protobuf::ParseError).with_message(/Invalid wire type/)
        end
      end
    end

    context "from JSON" do
      context "- Successful" do
        let(:json) { File.read(fixture_path + "/graph/json/regression.json") }
        let(:graph) { described_class.new }

        subject(:subject) { graph.definition_from_json(json) }

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

        subject(:string_action) { graph.definition_from_json(string) }
        subject(:json_action) { graph.definition_from_json(json) }

        it "fails with appropriate error when input is not JSON" do
          expect{ string_action }.to raise_error(Google::Protobuf::ParseError)
        end

        it "fails with JSONValidationError when JSON does not contain necessary elements", skip: "Requires implementation of JSON validator" do
          expect{ json_action }.to raise_error(Roseflow::Errors::JSONValidationError)
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

        it "can convert them to protobuffers" do
          expect(subject.to_proto).to be_a String
        end
      end

      context "Graph with nodes" do
        let(:graph) { described_class.new }
        pending
      end

      context "Graph with versions" do
        pending
      end
    end
  end
end
