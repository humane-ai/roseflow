module TensorFlow::LibTensorFlow
  module API
    #
    # Core functions
    #
    core_functions = {
      delete_status: {
        name: "TF_DeleteStatus",
        returns: :void,
        options: [:pointer]
      },
      get_code: {
        name: "TF_GetCode",
        returns: :code,
        options: [:pointer]
      },
      message: {
        name: "TF_Message",
        returns: :string,
        options: [:pointer]
      },
      new_status: {
        name: "TF_NewStatus",
        returns: Status,
        options: []
      },
      set_status: {
        name: "TF_SetStatus",
        returns: :void,
        options: [:pointer, :int, :string]
      },
      version: {
        name: "TF_Version",
        returns: UTF8String,
        options: []
      }
    }

    #
    # Attaching the functions
    #
    [ core_functions ].each do |functions|
      functions.each do |method_name, arguments|
        attach_function method_name.to_sym, arguments[:name].to_sym, arguments[:options], arguments[:returns]
      end
    end
  end
end
