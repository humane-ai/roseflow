require "roseflow/tensorflow"

module Roseflow
  # Session is a class for running TensorFlow operations.

  # A Session object encapsulates the environment in which Operation objects are
  # executed, and Tensor objects are evaluated.
  class Session
    attr_reader :session
    attr_reader :session_options

    def initialize(*args)
      @session = nil
    end

    def connected?
      @session.is_a?(Roseflow::Tensorflow::Session)
    end

    def connect
      status = api.new_status()
      @session = api.new_session(graph, options, status)
      status.code == :ok
    end

    def disconnect
      status = api.new_status()
      api.delete_session(@session, status)
      if status.code == :ok
        finalize_disconnect
      else
        false
      end
    end

    def close
      status = api.new_status()
      api.close_session(@session, status)
      status.code == :ok
    end

    def graph
      @graph ||= api.new_graph()
    end

    def graph=(input_graph)
      proto = input_graph.to_proto
      pointer = graphdef_proto_to_pointer(proto)
      graphdef = graphdef_pointer_to_buffer(pointer)
      status = api.new_status()
      api.load_graph_from_graph_definition(@graph, graphdef, @options, status)
      status.code
    end

    def options
      @options ||= begin
        options = api.new_session_options()
        @session_options = options
        options
      end
    end

    def finalize_disconnect
      @session = nil
      delete_session_options
      true
    end

    def delete_session_options
      api.delete_session_options(options)
      @session_options = nil
    end

    def api
      Roseflow::Tensorflow::API
    end

    private

    def graphdef_proto_to_pointer(proto)
      byte_count = proto.unpack("C*").size
      pointer = FFI::MemoryPointer.new(:char, byte_count)
      pointer.put_bytes(0, proto, 0, byte_count)
      pointer
    end

    def graphdef_pointer_to_buffer(pointer)
      buffer = Roseflow::Tensorflow::Structs::Buffer.new
      buffer[:data] = pointer
      buffer[:length] = pointer.size
      buffer
    end
  end
end
