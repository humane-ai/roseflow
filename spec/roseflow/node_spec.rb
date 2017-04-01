# encoding: utf-8

require "spec_helper"

RSpec.describe Roseflow::Node do
  describe "Class methods" do
    describe ".from_nodedef(definition)" do
      context "Simple definition" do
        let(:definition) { described_class::PROTOBUF_CLASS.new(name: "Variable/initial_value", op: "Const") }
        let(:node) { described_class.from_nodedef(definition) }

        it "instantiates a new Node from node definition" do
          expect(node).to be_a described_class
          expect(node.name).to eq definition.name
          expect(node.op).to eq definition.op
          expect(node.input).to eq definition.input
          expect(node.device).to eq definition.device
          expect(node.attr).to eq definition.attr
        end
      end

      context "Complex definitions" do
        let(:graph_definition) { graph_definition_from_json(Roseflow::Graph::PROTOBUF_CLASS, "regression.json") }

        context "definition with inputs" do
          let(:node_definition) { graph_definition.node.select{ |node| node.op == "Mul" }.first }

          let(:node) { described_class.from_nodedef(node_definition) }

          it "instantiates a new Node from node definition" do
            expect(node).to be_a described_class
            expect(node.name).to eq node_definition.name
            expect(node.input).to eq node_definition.input
            expect(node.inputs).to eq node_definition.input
          end
        end

        context "Data types" do
          let(:node_definition) { graph_definition.node.select{ |node| node.op == "Placeholder" }.first }
          let(:node) { described_class.from_nodedef(node_definition) }

          it "can have a data type" do
            expect(node.data_type).to eq :float
          end
        end
      end
    end
  end

  def graph_definition_from_json(klass, fixture)
    ::Google::Protobuf.decode_json(klass, File.read(fixture_path + "/graph/json/#{fixture}"))
  end
end
