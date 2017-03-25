# encoding: utf-8

require "spec_helper"

RSpec.describe "TensorFlow API Graph functions" do
  let(:graph_def) do
    graph_file = File.read(fixture_path + "/graph/graph.pb")
    pointer = graph_file_to_pointer(graph_file)
    buffer = TensorFlow::LibTensorFlow::Structs::Buffer.new
    buffer[:data] = pointer
    buffer[:length] = pointer.size
    buffer
  end

  context "Loading a graph from a graph definition" do
    let(:options) { api.new_graph_import_options() }
    let(:graph) { api.new_graph() }
    let(:status) { api.new_status() }

    it "loads a graph from graph definition" do
      api.load_graph_from_graph_definition(graph, graph_def.to_ptr, options, status)
      expect(status.code).to eq :ok
    end
  end

  context "Finding operations by name" do
    let(:options) { api.new_graph_import_options() }
    let(:graph) { api.new_graph() }
    let(:status) { api.new_status() }

    it "finds operations by name" do
      api.load_graph_from_graph_definition(graph, graph_def.to_ptr, options, status)
      expect(status.code).to eq :ok
      operation = api.graph_operation_by_name(graph, "a")
      expect(operation).to be_a TensorFlow::LibTensorFlow::Operation
    end

    it "does not return an operation if there's no operation with given name" do
      api.load_graph_from_graph_definition(graph, graph_def.to_ptr, options, api.new_status)
      expect(api.graph_operation_by_name(graph, "foobar")).to eq nil

      empty = api.new_graph()
      expect(api.graph_operation_by_name(empty, "foobar")).to eq nil
    end
  end

  def graph_file_to_pointer(input_file)
    byte_count = input_file.unpack("C*").size
    pointer = FFI::MemoryPointer.new(:char, byte_count)
    pointer.put_bytes(0, input_file, 0, byte_count)
    pointer
  end
end
