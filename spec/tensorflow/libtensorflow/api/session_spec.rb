# encoding: utf-8

require "spec_helper"

RSpec.describe "TensorFlow API Session functions" do
  context "Creating a session" do
    let(:options) { api.new_session_options() }
    let(:graph) { api.new_graph() }

    it "creates a new session" do
      status = api.new_status()
      expect(api.new_session(graph, options, status)).to be_a TensorFlow::LibTensorFlow::Session
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

  context "Session options" do
    context "Creating session options" do
      it "can create new session options" do
        expect(api.new_session_options()).to be_a TensorFlow::LibTensorFlow::SessionOptions
      end
    end

    context "Deleting session options" do
      it "can delete session options" do
        options = api.new_session_options
        expect(api.delete_session_options(options)).to be_nil
      end
    end
  end
end
