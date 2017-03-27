# encoding: utf-8

require "spec_helper"

RSpec.describe "TensorFlow API Session functions" do
  context "Creating a session" do
    let(:options) { api.new_session_options() }
    let(:graph) { api.new_graph() }

    it "creates a new session" do
      status = api.new_status()
      expect(api.new_session(graph, options, status)).to be_a Roseflow::Tensorflow::Session
      expect(status.code).to eq :ok
    end
  end

  context "Closing a session" do
    let(:options) { api.new_session_options() }
    let(:graph) { api.new_graph() }

    it "closes the session" do
      status = api.new_status()
      session = api.new_session(graph, options, status)
      status = api.new_status()
      expect(api.close_session(session, status)).to be_nil
      expect(status.code).to eq :ok
    end
  end

  context "Deleting a session" do
    let(:options) { api.new_session_options() }
    let(:graph) { api.new_graph() }

    it "deletes a session" do
      session = api.new_session(graph, options, api.new_status())
      status = api.new_status()
      expect(api.delete_session(session, status)).to be_nil
      expect(status.code).to be :ok
    end
  end

  context "Running a session" do
    # extern void TF_SessionRun(TF_Session* session,
    #                       // RunOptions
    #                       const TF_Buffer* run_options,
    #                       // Input tensors
    #                       const TF_Output* inputs,
    #                       TF_Tensor* const* input_values, int ninputs,
    #                       // Output tensors
    #                       const TF_Output* outputs, TF_Tensor** output_values,
    #                       int noutputs,
    #                       // Target operations
    #                       const TF_Operation* const* target_opers, int ntargets,
    #                       // RunMetadata
    #                       TF_Buffer* run_metadata,
    #                       // Output status
    #                       TF_Status*);
    let(:options) { api.new_session_options() }
    let(:graph) { api.new_graph() }
    let(:graph_def) do
      graph_file = File.read(fixture_path + "/graph/regression_simplified.pb")
      pointer = graph_file_to_pointer(graph_file)
      buffer = Roseflow::Tensorflow::Structs::Buffer.new
      buffer[:data] = pointer
      buffer[:length] = pointer.size
      buffer
    end
    let(:graph_options) { api.new_graph_import_options() }

    it "runs a session" do
      session = api.new_session(graph, options, api.new_status())
      status = api.new_status()
      api.load_graph_from_graph_definition(graph, graph_def.to_ptr, graph_options, status)
      expect(status.code).to eq :ok
      status = api.new_status()
      run_options = api.new_buffer()
      # inputs = Roseflow::Tensorflow::Structs::Output.new
      # input_values = Roseflow::Tensorflow::Structs::Tensor.new
      # outputs = Roseflow::Tensorflow::Structs::Output.new
      # output_values = Roseflow::Tensorflow::Structs::Tensor.new
      inputs = FFI::Pointer::NULL
      input_values = FFI::Pointer::NULL
      outputs = FFI::Pointer::NULL
      output_values = FFI::Pointer::NULL
      operations = FFI::Pointer::NULL
      targets = []
      run_metadata = api.new_buffer()
      api.run_session(session, run_options, inputs, input_values, 1, outputs, output_values, 1, operations, targets.count, run_metadata, status)
      expect(status.code).to eq :ok
    end
  end

  context "Session options" do
    context "Creating session options" do
      it "can create new session options" do
        expect(api.new_session_options()).to be_a Roseflow::Tensorflow::SessionOptions
      end
    end

    context "Deleting session options" do
      it "can delete session options" do
        options = api.new_session_options
        expect(api.delete_session_options(options)).to be_nil
      end
    end
  end

  def graph_file_to_pointer(input_file)
    byte_count = input_file.unpack("C*").size
    pointer = FFI::MemoryPointer.new(:char, byte_count)
    pointer.put_bytes(0, input_file, 0, byte_count)
    pointer
  end
end
