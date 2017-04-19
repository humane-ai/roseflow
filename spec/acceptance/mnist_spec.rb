# encoding: utf-8

require "spec_helper"

RSpec.describe "MNIST Handwriting Recognition" do
  describe "Simple version" do
    context "model from existing graph definition" do

    end

    context "model from ActiveGraph" do

    end

    context "constructing model by hand" do
      let(:training_data) { [] }

      class MnistGraph < Roseflow::ActiveGraph::Base
      end

      context "Inputs" do
        it "can have inputs" do
          graph = MnistGraph.new
          input = graph.inputs.new
          expect(input).to be_a Roseflow::ActiveGraph::Input
          input.description = "Images"
        end
      end

      it "defines model, trains the model, runs with test data", skip: true do
        graph = MnistGraph.new
        graph.inputs.add "Images", :images, training_data, placeholder: true, type: :float32, shape: [nil, 784]
        expect(graph.inputs.count).to eq 1
        expect(graph.placeholders.count).to eq 1
        graph.weights.new description: "MatMul Weights", name: :matmul_weights, data: Numo::DFloat.zeros(784, 10)
        expect(graph.weights.count).to eq 1
        graph.biases.new description: "MatMul Biases", name: :matmul_biases, data: Numo::DFloat.zeros(10)
        expect(graph.biases.count).to eq 1
        layer = graph.layers.new description: "Softmax", name: :softmax
        expect(graph.layers.count).to eq 1
        layer.operations.new description: "Matrix Multiplication", type: :matmul, input: :images, weights: :matmul_weights
        layer.operations.new description: "Add Biases", type: :add, biases: :matmul_biases
        expect(layer.operations.count).to eq 2
      end
    end
  end
end
