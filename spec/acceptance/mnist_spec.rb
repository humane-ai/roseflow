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

      it "defines model, trains the model, runs with test data" do
        graph = Roseflow::Graph.new
        graph.inputs.add "Images", training_data, placeholder: true, type: :float32, shape: [nil, 784]
        expect(graph.inputs.count).to eq 1
        expect(graph.placeholders.count).to eq 1
        graph.weights.new "MatMul Weights", :matmul_weights, Numo::DFloat.zeros(784, 10)
        expect(graph.weights.count).to eq 1
        graph.biases.new "MatMul Biases", :matmul_biases, Numo::DFloat.zeros(10)
        expect(graph.biases.count).to eq 1
        layer = graph.layers.new "Softmax"
        expect(graph.layers.count).to eq 1
        layer.operations.new "Matrix Multiplication", :matmul, :images, :matmul_weights
        layer.operations.new "Add Biases", :add, :matmul_biases
        expect(layer.operations.count).to eq 2
      end
    end
  end
end
