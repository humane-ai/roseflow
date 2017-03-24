# encoding: utf-8

require "spec_helper"

RSpec.describe "TensorFlow API Operation functions" do
  context "Adding a new operation" do
    it "creates a new operation" do
      graph = TensorFlow::LibTensorFlow::API.new_graph()
      expect(api.new_operation(graph, "Const", "")).to be_a TensorFlow::LibTensorFlow::OperationDescription
    end
  end

  # TODO: WIP.
  context "Operation type", skip: true do
    it "returns the type of the operation" do
      graph = TensorFlow::LibTensorFlow::API.new_graph()
      operation = api.new_operation(graph, "Const", "hello")
      expect(operation).to be_a TensorFlow::LibTensorFlow::OperationDescription
      # tensor = TensorFlow::LibTensorFlow::Protobuf::TensorProto.new(tensor_content: "Hello!", dtype: TensorFlow::LibTensorFlow::Protobuf::DataType::DT_STRING)

      tensor = TensorFlow::LibTensorFlow::Protobuf::TensorProto.new(string_val: ["Hello!"], dtype: TensorFlow::LibTensorFlow::Protobuf::DataType::DT_STRING)
      status = api.new_status()
      # output = TensorFlow::LibTensorFlow::Protobuf::OpDef.new(name: "Hello")

      # result = api.add_input(operation, tensor)
      # api.set_attribute_type(operation, "dtype", 7)
      p status.code
      p status.message
      status = api.new_status()
      # api.set_attribute_tensor(operation, "value", tensor, status)
      p status.code
      p status.message
      # api.set_attribute_string(operation, "value", "Hello!", "Hello!".length)
      status = api.new_status()
      result = api.finish_operation(operation, status)
      p status.code
      p status.message
      expect(result).to be_a TensorFlow::LibTensorFlow::Operation
    end
  end
end
