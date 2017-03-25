# encoding: utf-8

require "spec_helper"

RSpec.describe "TensorFlow API Graph functions" do
  context "Loading a graph from a graph definition" do
    let(:graph_def) do
      graph_file = File.read(fixture_path + "/graph/graph.pb")
      pointer = graph_file_to_pointer(graph_file)
      buffer = TensorFlow::LibTensorFlow::Structs::Buffer.new
      buffer[:data] = pointer
      buffer[:length] = pointer.size
      buffer
    end

    it "loads a graph from graph definition" do
      graph = api.new_graph()
      status = api.new_status()
      opts = api.new_graph_import_options()
      api.load_graph_from_graph_definition(graph, graph_def.to_ptr, opts, status)
      p status.code
      p status.message
    end
  end

  def graph_file_to_pointer(input_file)
    byte_count = input_file.unpack("C*").size
    pointer = FFI::MemoryPointer.new(:char, byte_count)
    pointer.put_bytes(0, input_file, 0, byte_count)
    pointer
  end
end
