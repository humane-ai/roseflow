# encoding: utf-8

require "spec_helper"

RSpec.describe Roseflow::Node do
  describe "Class methods" do
    describe ".from_nodedef(definition)" do
      context "Simple definition" do
        let(:definition) { described_class::PROTOBUF_CLASS.new(name: "Variable/initial_value", op: "Const") }

        subject(:subject) { described_class.from_nodedef(definition) }

        it "instantiates a new Node from node definition" do
          expect(subject).to be_a described_class
          expect(subject.name).to eq definition.name
          expect(subject.op).to eq definition.op
          expect(subject.input).to eq definition.input
          expect(subject.device).to eq definition.device
          expect(subject.attr).to eq definition.attr
        end
      end

      context "Complex definitions" do
        context "definition with inputs" do
          let(:graph_definition) { graph_definition_from_json(Roseflow::Graph::PROTOBUF_CLASS, "regression.json") }
          let(:node_definition) { graph_definition.node.select{ |node| node.op == "Mul" }.first }

          subject(:subject) { described_class.from_nodedef(node_definition) }

          it "instantiates a new Node from node definition" do
            expect(subject).to be_a described_class
            expect(subject.name).to eq node_definition.name
            expect(subject.input).to eq node_definition.input
            expect(subject.inputs).to eq node_definition.input
          end
        end
      end
    end
  end

  def graph_definition_from_json(klass, fixture)
    ::Google::Protobuf.decode_json(klass, File.read(fixture_path + "/graph/json/#{fixture}"))
  end
end
