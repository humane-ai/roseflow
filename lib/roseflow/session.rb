require "roseflow/tensorflow"

module Roseflow
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
  end
end
