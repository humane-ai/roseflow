# encoding: utf-8

require "spec_helper"

RSpec.describe "TensorFlow API Operation functions" do
  context "Adding a new operation" do
    it "creates a new operation" do
      graph = TensorFlow::LibTensorFlow::API.new_graph()
      expect(api.new_operation(graph, "Const", "")).to be_a TensorFlow::LibTensorFlow::OperationDescription
    end
  end

  context "Placeholder operation" do
    it "creates a placeholder operation" do
      graph = api.new_graph()
      status = api.new_status()
      expect(api.new_operation(graph, "Placeholder", "")).to be_a TensorFlow::LibTensorFlow::OperationDescription
      expect(status.code).to eq :ok
    end
  end

  context "Converting an operation to node definition" do
    let(:graph) { api.new_graph() }
    let(:graph_def) do
      graph_file = File.read(fixture_path + "/graph/graph.pb")
      pointer = graph_file_to_pointer(graph_file)
      buffer = TensorFlow::LibTensorFlow::Structs::Buffer.new
      buffer[:data] = pointer
      buffer[:length] = pointer.size
      buffer
    end
    let(:options) { api.new_graph_import_options() }

    it "writes a buffer containing a node definition" do
      status = api.new_status()
      api.load_graph_from_graph_definition(graph, graph_def.to_ptr, options, status)
      expect(status.code).to eq :ok
      operation = api.graph_operation_by_name(graph, "a")
      expect(operation).to be_a TensorFlow::LibTensorFlow::Operation
      buffer = api.new_buffer()
      p buffer.read_string
      status = api.new_status()
      expect(api.operation_to_node_def(operation, buffer, status)).to be_nil
      expect(status.code).to eq :ok
      returning = api.get_buffer(buffer)
      expect(returning).to be_a TensorFlow::LibTensorFlow::Buffer
      p string = returning.read_string
      p Google::Protobuf.decode(TensorFlow::LibTensorFlow::Protobuf::NodeDef, string)
    end
  end

  # TODO: WIP.
  context "Operation type", skip: "FIXME" do
    it "returns the type of the operation" do
      graph = TensorFlow::LibTensorFlow::API.new_graph()
      operation = api.new_operation(graph, "Const", "")
      expect(operation).to be_a TensorFlow::LibTensorFlow::OperationDescription
      # tensor = TensorFlow::LibTensorFlow::Protobuf::TensorProto.new(tensor_content: "Hello!", dtype: TensorFlow::LibTensorFlow::Protobuf::DataType::DT_STRING)
      shape = TensorFlow::LibTensorFlow::Protobuf::TensorShapeProto.new
      tensor = TensorFlow::LibTensorFlow::Protobuf::TensorProto.new(float_val: [5.0], dtype: TensorFlow::LibTensorFlow::Protobuf::DataType::DT_FLOAT, tensor_shape: shape)
      attrvalue = TensorFlow::LibTensorFlow::Protobuf::AttrValue.new(tensor: tensor)
      nodedef = TensorFlow::LibTensorFlow::Protobuf::NodeDef.new(name: "a/initial_value", op: "Const")
      nodedef.attr["dtype"] = TensorFlow::LibTensorFlow::Protobuf::AttrValue.new(type: TensorFlow::LibTensorFlow::Protobuf::DataType::DT_FLOAT)
      nodedef.attr["value"] = attrvalue
      p nodedef
      node = TensorFlow::LibTensorFlow::Structs::Operation.new
      struct = TensorFlow::LibTensorFlow::Structs::Node.new
      struct[:data] = FFI::MemoryPointer.new(nodedef.to_proto)
      node[:node] = struct
      output = TensorFlow::LibTensorFlow::Structs::Output.new
      output[:oper] = node
      output[:index] = 0
      # ptr = TensorFlow::LibTensorFlow::Output.new(output)
      status = api.new_status()
      # api.set_attribute_type(operation, "Const", TensorFlow::LibTensorFlow::Protobuf::DataType::DT_FLOAT)
      result = api.add_input(operation, output)
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

  def graph_file_to_pointer(input_file)
    byte_count = input_file.unpack("C*").size
    pointer = FFI::MemoryPointer.new(:char, byte_count)
    pointer.put_bytes(0, input_file, 0, byte_count)
    pointer
  end
end
