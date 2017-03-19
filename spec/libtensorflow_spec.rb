require "spec_helper"

RSpec.describe TensorFlow::LibTensorFlow do
  context "API" do
    context "Low-level bindings" do
      context "Core functions" do
        CORE_FUNCTIONS = [
          :delete_status,
          :get_code,
          :message,
          :new_status,
          :set_status,
          :version
        ]

        it "binds core functions of the C API" do
          CORE_FUNCTIONS.each do |method_name|
            expect(api).to respond_to(method_name)
          end
        end

        it "returns the size in bytes required to encode a string" do
          expect(api.string_encoded_size(16)).to be_a Integer
        end

        it "returns the version of the TensorFlow library as a string" do
          expect(api.version).to be_a String
        end
      end

      context "Graphs" do
        GRAPH_FUNCTIONS = [
          :delete_graph,
          :new_graph
        ]

        it "binds graph functions of the C API" do
          GRAPH_FUNCTIONS.each do |method_name|
            expect(api).to respond_to(method_name)
          end
        end

        context "Creating a graph" do
          it "creates a new graph" do
            expect(api.new_graph()).to be_a TensorFlow::LibTensorFlow::Graph
          end
        end
      end

      context "Session" do
        SESSION_FUNCTIONS = [
          :close_session,
          :delete_session,
          :new_session,
          :run_session
        ]

        it "binds session functions of the C API" do
          SESSION_FUNCTIONS.each do |method_name|
            expect(api).to respond_to(method_name)
          end
        end
      end

      context "Operations" do
        let(:api) { described_class::API }

        OPERATION_FUNCTIONS = [
          :new_operation
        ]

        it "binds operation functions of the C API" do
          OPERATION_FUNCTIONS.each do |method_name|
            expect(api).to respond_to(method_name)
          end
        end

        context "Creating an operation" do
          it "creates a new operation" do
            graph = TensorFlow::LibTensorFlow::API.new_graph()
            expect(api.new_operation(graph, "foo", "bar")).to be_a TensorFlow::LibTensorFlow::OperationDescription
          end
        end

        context "Finish an operation" do
          it "finishes an operation" do
            graph = TensorFlow::LibTensorFlow::API.new_graph()
            description = api.new_operation(graph, "Placeholder", "tensor1")
            pointer = FFI::MemoryPointer.new :double, [2.to_f,1].size
            pointer.put_array_of_double 0, [2.to_f,1]
            pointer.inspect
            status = api.new_status()
            api.set_attribute_shape(description, "shape", pointer, pointer.size)
            api.set_attribute_type(description, "shape", 2)
            p status.code
            p status.message
            status = api.new_status()
            expect(api.finish_operation(description, status)).to be_a FFI::Pointer
            p status.message
            expect(status.code).to eq :ok
          end
        end
      end

      context "Tensors", skip: true do
        TF_INT = 6

        TENSOR_FUNCTIONS = [
          :allocate_tensor,
          :delete_tensor,
          :new_tensor,
          :number_of_tensor_dimensions,
          :tensor_byte_size,
          :tensor_data,
          :tensor_length_in_dimension,
          :tensor_type
        ]

        it "binds tensor functions of the C API" do
          TENSOR_FUNCTIONS.each do |method_name|
            expect(api).to respond_to(method_name)
          end
        end

        context "Creating a new tensor" do
          context "with #new_tensor" do
            pending "Not implemented"
          end

          context "with #allocate_tensor" do
            it "creates a new tensor" do
              pointer = FFI::MemoryPointer.new :int, [2,1].size
              pointer.put_array_of_int 0, [2,1]
              expect(api.allocate_tensor(TF_INT, pointer, 1, pointer.size)).to be_a TensorFlow::LibTensorFlow::Tensor
            end
          end
        end

        context "Tensor type" do
          it "returns the type of tensor" do
            pointer = FFI::MemoryPointer.new :int, [2,1].size
            pointer.put_array_of_int 0, [2,1]
            tensor = api.allocate_tensor(TF_INT, pointer, 1, pointer.size)
            expect(api.tensor_type(tensor)).to eq :dt_int8
            expect(tensor.type).to eq :dt_int8
          end
        end

        context "Number of dimensions" do
          it "returns the number of dimensions of the tensor" do
            array = [2]
            pointer = FFI::MemoryPointer.new :int, array.size
            pointer.put_array_of_int 0, array
            tensor = api.allocate_tensor(TF_INT, pointer, 4, pointer.size)
            expect(api.number_of_tensor_dimensions(tensor)).to eq 4
            expect(tensor.dimensions).to eq 4
          end
        end

        context "Length in dimension" do
          it "returns the length of the tensor in given dimension" do
            pointer = FFI::MemoryPointer.new :int, [2,4].size
            pointer.put_array_of_int 0, [2,4]
            tensor = api.allocate_tensor(TF_INT, pointer, 4, pointer.size)
            expect(api.tensor_length_in_dimension(tensor, 0)).to eq 17179869186
            expect(tensor.length(0)).to eq 17179869186
          end
        end

        context "Size of underlying data in bytes" do
          it "returns the size of the data in bytes" do
            pointer = FFI::MemoryPointer.new :int, [2,4].size
            pointer.put_array_of_int 0, [2,4]
            tensor = api.allocate_tensor(TF_INT, pointer, 4, pointer.size)
            expect(api.tensor_byte_size(tensor)).to eq 8
            expect(tensor.byte_size).to eq 8
          end
        end

        context "Pointer to data buffer" do
          it "returns a pointer to underlying data buffer" do
            pointer = FFI::MemoryPointer.new :int, [2].size
            pointer.put_array_of_int 0, [2]
            tensor = api.allocate_tensor(TF_INT, pointer, 4, pointer.size)
            expect(api.tensor_data(tensor)).to be_a TensorFlow::LibTensorFlow::TensorData
            expect(tensor.data).to be_a TensorFlow::LibTensorFlow::TensorData
          end
        end
      end

      context "Code" do
        it "returns the code of the status object" do
          status = api.new_status()
          expect(api.get_code(status)).to be_a Symbol
          expect(api.get_code(status)).to eq :ok
        end
      end

      context "Status" do
        context "Creating a new status object" do
          it "creates new status object" do
            expect(api.new_status()).to be_a TensorFlow::LibTensorFlow::Status
          end
        end

        context "Setting/modifying status object" do
          it "can set the status object" do
            status = api.new_status()
            expect(api.set_status(status, 0, "We're OK!")).to eq nil
            expect(status.code).to eq :ok
            expect(status.message).to eq "We're OK!"
          end

          it "can modify the status object" do
            status = api.new_status()
            expect(api.set_status(status, 0, "We're OK!")).to eq nil
            expect(api.set_status(status, 1, "We're cancelled!")).to eq nil
            expect(status.code).to eq :cancelled
            expect(status.message).to eq "We're cancelled!"
          end
        end

        context "Clearing status" do
          let(:status) { api.new_status() }

          before do
            api.set_status(status, 2, "Uh, oh!")
          end

          it "clears the status object state" do
            expect(status.clear).to eq true
            expect(status.code).to eq :ok
            expect(status.message).to eq ""
          end

          it "will return false on failure" do
            expect(api).to receive(:set_status).and_raise("Tensorflow failure!")
            expect(status.clear).to eq false
          end
        end
      end

      context "Buffers" do
        BUFFER_FUNCTIONS = [
          :delete_buffer,
          :get_buffer,
          :new_buffer,
          :new_buffer_from_string
        ]

        it "binds buffer functions of the C API" do
          BUFFER_FUNCTIONS.each do |method_name|
            expect(api).to respond_to(method_name)
          end
        end

        context "Getting a buffer" do
          pending "Not implemented"
        end

        context "Creating a new buffer" do
          context "New buffer" do
            it "creates a new buffer" do
              expect(api.new_buffer).to be_a TensorFlow::LibTensorFlow::Buffer
            end
          end

          context "New buffer from string" do
            it "creates a new buffer from string" do
              expect(api.new_buffer_from_string("Hello", 5)).to be_a TensorFlow::LibTensorFlow::Buffer
            end

            it "requires an appropriate length for the buffer" do
              expect(api.new_buffer_from_string("Yeah", 2)).to be_a TensorFlow::LibTensorFlow::Buffer
            end
          end
        end
      end

      context "Utility functions" do
        UTILITY_FUNCTIONS = [
          :decode_string,
          :encode_string,
          :string_encoded_size
        ]

        it "binds utility function of the C API" do
          UTILITY_FUNCTIONS.each do |method_name|
            expect(api).to respond_to(method_name)
          end
        end

        context "String encoding" do
          let(:status) { api.new_status() }
          subject(:subject) { api.encode_string("Hello", 5, "olleH", 6, status) }

          it "encodes a string" do
            expect(subject).to be_truthy
            expect(status.code).to eq :ok
          end
        end

        context "String decoding", skip: true do
          let(:status) { api.new_status() }
          let(:string) { api.encode_string("Hello", 5, "olleH", 6, status) }

          subject(:subject) { api.decode_string("olleH", 6, "Hello", 5, status) }

          it "decodes a string" do
            expect(subject).to be_truthy
            expect(status.code).to eq :ok
          end
        end
      end
    end
  end
end
