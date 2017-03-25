# encoding: utf-8

require "spec_helper"

RSpec.describe TensorFlow::Graph do
  context "Initializing a graph" do

  end

  describe "Attributes" do
    subject(:subject) { described_class.new }

    describe "name" do
      it "has a name" do
        expect(subject.name).to eq "My Graph"
      end

      it "can have a custom name" do
        subject.name = "Awesome Graph"
        expect(subject.name).to eq "Awesome Graph"
      end
    end
  end

  describe "Graph definitions" do
    context "Converting graph to a graph definition" do
      context "Empty graph" do
        let(:graph) { described_class.new }

        subject(:subject) { graph.to_graphdef }

        it "returns GraphDef of the graph" do
          expect(subject).to be_a TensorFlow::LibTensorFlow::Protobuf::GraphDef
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
