# encoding: utf-8

require "spec_helper"

RSpec.describe "TensorFlow API Operation functions" do
  context "Adding a new operation" do
    context "Const operation" do
      let(:json) { File.read(fixture_path + "/operation/const_variable.json") }
      let(:protobuf_class) { ::Roseflow::Tensorflow::Protobuf::NodeDef }
      let(:nodedef) { ::Google::Protobuf.decode_json(protobuf_class, json) }
      let(:dtype) { nodedef.attr["dtype"] }
      let(:value) { nodedef.attr["value"] }

      # TODO: Validate that data type and tensor shape are correct
      it "creates a new operation" do
        graph = Roseflow::Tensorflow::API.new_graph()
        description = api.new_operation(graph, "Const", "Variable/initial_variable")
        expect(description).to be_a Roseflow::Tensorflow::OperationDescription
        status = api.new_status()
        expect(api.set_attribute_value_proto(description, "dtype", pointer_to(dtype, :float), dtype.to_proto.length, status)).to be_nil
        expect(status.code).to eq :ok
        status = api.new_status()
        expect(api.set_attribute_value_proto(description, "value", pointer_to(value, :float), value.to_proto.length, status)).to be_nil
        expect(status.code).to eq :ok
        status = api.new_status()
        operation = api.finish_operation(description, status)
        expect(operation).to be_a Roseflow::Tensorflow::Operation
        expect(status.code).to eq :ok
        expect(api.operation_name(operation)).to eq "Variable/initial_variable"
        expect(api.operation_type(operation)).to eq "Const"
        expect(api.operation_number_of_inputs(operation)).to eq 0
      end
    end

    context "Placeholder operation" do
      let(:json) { File.read(fixture_path + "/operation/placeholder.json") }
      let(:protobuf_class) { ::Roseflow::Tensorflow::Protobuf::NodeDef }
      let(:nodedef) { ::Google::Protobuf.decode_json(protobuf_class, json) }
      let(:dtype) { nodedef.attr["dtype"] }
      let(:shape) { nodedef.attr["shape"] }

      # TODO: Validate tensor shape by getting it from the API and checking the shape
      it "creates a placeholder operation" do
        graph = api.new_graph()
        description = api.new_operation(graph, "Placeholder", "MyPlaceholder")
        status = api.new_status()
        expect(api.set_attribute_value_proto(description, "dtype", pointer_to(dtype, :float), dtype.to_proto.length, status)).to be_nil
        expect(status.code).to eq :ok
        expect(api.set_attribute_value_proto(description, "shape", pointer_to(shape, :float), shape.to_proto.length, status)).to be_nil
        expect(status.code).to eq :ok
        operation = api.finish_operation(description, status)
        expect(operation).to be_a Roseflow::Tensorflow::Operation
        expect(status.code).to eq :ok
        expect(api.operation_name(operation)).to eq "MyPlaceholder"
        expect(api.operation_type(operation)).to eq "Placeholder"
        expect(api.graph_operation_by_name(graph, "MyPlaceholder")).to be_a Roseflow::Tensorflow::Operation
        # buffer = api.new_buffer()
        # api.operation_get_attribute_tensor_shape_proto(operation, "shape", buffer, status)
        # expect(status.code).to eq :ok
        # p ::Google::Protobuf.decode(Roseflow::Tensorflow::Protobuf::TensorShapeProto, buffer.read_string)
      end
    end
  end

  context "Placeholder operation" do
    it "creates a placeholder operation" do
      graph = api.new_graph()
      status = api.new_status()
      expect(api.new_operation(graph, "Placeholder", "")).to be_a Roseflow::Tensorflow::OperationDescription
      expect(status.code).to eq :ok
    end
  end

  context "Converting an operation to node definition", skip: "FIXME" do
    let(:graph) { api.new_graph() }
    let(:graph_def) do
      graph_file = File.read(fixture_path + "/graph/graph.pb")
      pointer = graph_file_to_pointer(graph_file)
      buffer = Roseflow::Tensorflow::Structs::Buffer.new
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
      expect(operation).to be_a Roseflow::Tensorflow::Operation
      buffer = api.new_buffer()
      p buffer.read_string
      status = api.new_status()
      expect(api.operation_to_node_def(operation, buffer, status)).to be_nil
      expect(status.code).to eq :ok
      returning = api.get_buffer(buffer)
      expect(returning).to be_a Roseflow::Tensorflow::Buffer
      p string = returning.read_string
      p Google::Protobuf.decode(Roseflow::Tensorflow::Protobuf::NodeDef, string)
    end
  end

  # TODO: WIP.
  context "Operation type", skip: "FIXME" do
    it "returns the type of the operation" do
      graph = Roseflow::Tensorflow::API.new_graph()
      operation = api.new_operation(graph, "Const", "")
      expect(operation).to be_a Roseflow::Tensorflow::OperationDescription
      # tensor = Roseflow::Tensorflow::Protobuf::TensorProto.new(tensor_content: "Hello!", dtype: Roseflow::Tensorflow::Protobuf::DataType::DT_STRING)
      shape = Roseflow::Tensorflow::Protobuf::TensorShapeProto.new
      tensor = Roseflow::Tensorflow::Protobuf::TensorProto.new(float_val: [5.0], dtype: Roseflow::Tensorflow::Protobuf::DataType::DT_FLOAT, tensor_shape: shape)
      attrvalue = Roseflow::Tensorflow::Protobuf::AttrValue.new(tensor: tensor)
      nodedef = Roseflow::Tensorflow::Protobuf::NodeDef.new(name: "a/initial_value", op: "Const")
      nodedef.attr["dtype"] = Roseflow::Tensorflow::Protobuf::AttrValue.new(type: Roseflow::Tensorflow::Protobuf::DataType::DT_FLOAT)
      nodedef.attr["value"] = attrvalue
      p nodedef
      node = Roseflow::Tensorflow::Structs::Operation.new
      struct = Roseflow::Tensorflow::Structs::Node.new
      struct[:data] = FFI::MemoryPointer.new(nodedef.to_proto)
      node[:node] = struct
      output = Roseflow::Tensorflow::Structs::Output.new
      output[:oper] = node
      output[:index] = 0
      # ptr = Roseflow::Tensorflow::Output.new(output)
      status = api.new_status()
      # api.set_attribute_type(operation, "Const", Roseflow::Tensorflow::Protobuf::DataType::DT_FLOAT)
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
      expect(result).to be_a Roseflow::Tensorflow::Operation
    end
  end

  def pointer_to(attr_value, type)
    byte_count = attr_value.to_proto.unpack("C*").size
    pointer = FFI::MemoryPointer.new(type, byte_count)
    pointer.put_bytes(0, attr_value.to_proto, 0, byte_count)
    pointer
  end

  def graph_file_to_pointer(input_file)
    byte_count = input_file.unpack("C*").size
    pointer = FFI::MemoryPointer.new(:char, byte_count)
    pointer.put_bytes(0, input_file, 0, byte_count)
    pointer
  end
end
