module TensorFlow::LibTensorFlow
  module API
    #
    # Session functions
    #
    session_functions = {
      close_session: {
        name: "TF_CloseSession",
        returns: :void,
        options: [ Session, Status ]
      },
      delete_session: {
        name: "TF_DeleteSession",
        returns: :void,
        options: [ Session, Status ]
      },
      new_session: {
        name: "TF_NewSession",
        returns: Session,
        options: [ Graph, SessionOptions, Status ]
      },
      run_session: {
        name: "TF_SessionRun",
        returns: :void,
        options: [ Session, Buffer, OperationOutput, Tensor, :int, OperationOutput, Tensor, :int, Operation, :int, Buffer, Status ]
      }
    }

    session_functions.each do |method_name, arguments|
      attach_function method_name.to_sym, arguments[:name].to_sym, arguments[:options], arguments[:returns]
    end
  end
end
