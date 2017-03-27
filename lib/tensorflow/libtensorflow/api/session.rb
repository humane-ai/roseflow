module TensorFlow::LibTensorFlow
  module API
    typedef Session, :session
    typedef SessionOptions, :session_options

    #
    # Session functions
    #
    session_functions = {
      close_session: {
        name: "TF_CloseSession",
        returns: :void,
        options: [ :session, Status ]
      },
      delete_library_handle: {
        name: "TF_DeleteLibraryHandle",
        returns: :void,
        options: [ Library ]
      },
      delete_session: {
        name: "TF_DeleteSession",
        returns: :void,
        options: [ :session, Status ]
      },
      delete_session_options: {
        name: "TF_DeleteSessionOptions",
        returns: :void,
        options: [ :session_options ]
      },
      get_all_ops_list: {
        name: "TF_GetAllOpList",
        returns: :buffer,
        options: []
      },
      get_ops_list: {
        name: "TF_GetOpList",
        returns: :buffer,
        options: [ Library ]
      },
      load_library: {
        name: "TF_LoadLibrary",
        returns: Library,
        options: [ :string, Status ]
      },
      new_session: {
        name: "TF_NewSession",
        returns: Session,
        options: [ Graph, :session_options, Status ]
      },
      new_session_options: {
        name: "TF_NewSessionOptions",
        returns: :session_options,
        options: []
      },
      run_session: {
        name: "TF_SessionRun",
        returns: :void,
        options: [ :session, :buffer, Structs::Output.by_ref, Tensor, :int, Structs::Output.by_ref, Tensor, :int, :pointer, :int, :buffer, Status ]
      },
      set_config: {
        name: "TF_SetConfig",
        returns: :void,
        options: [ :session_options, SessionConfig, :size_t, Status ]
      },
      set_target: {
        name: "TF_SetTarget",
        returns: :void,
        options: [ :session_options, :string ]
      }
    }

    session_functions.each do |method_name, arguments|
      attach_function method_name.to_sym, arguments[:name].to_sym, arguments[:options], arguments[:returns]
    end
  end
end
