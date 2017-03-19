require "spec_helper"

RSpec.describe TensorFlow::LibTensorFlow do
  context "API" do
    context "Low-level bindings" do
      context "Core functions" do
        subject(:api) { described_class::Api }

        it "binds core functions of the C API" do
          [ :delete_status, :get_code, :message, :new_status, :version ].each do |method_name|
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

      context "Tensors" do
        let(:api) { described_class::Api }

        TENSOR_FUNCTIONS = [
          :allocate_tensor,
          :delete_tensor,
          :new_tensor
        ]

        it "binds tensor functions of the C API" do
          TENSOR_FUNCTIONS.each do |method_name|
            expect(api).to respond_to(method_name)
          end
        end

        context "Creating a new tensor" do
          context "with #new_tensor" do
            it "creates a new tensor" do
              pending "Not implemented"
            end
          end

          context "with #allocate_tensor" do
            TF_INT = 6

            it "creates a new tensor" do
              array = [2,1]
              pointer = FFI::MemoryPointer.new :int, array.size
              pointer.put_array_of_int 0, array
              expect(api.allocate_tensor(TF_INT, pointer, 1, pointer.size)).to be_a TensorFlow::LibTensorFlow::Tensor
              p api.allocate_tensor(TF_INT, pointer, 1, pointer.size).dimensions
            end
          end
        end
      end

      context "Code" do
        let(:api) { described_class::Api }

        it "returns the code of the status object" do
          status = api.new_status()
          expect(api.get_code(status)).to be_a Symbol
          expect(api.get_code(status)).to eq :ok
        end
      end

      context "Status" do
        let(:api) { described_class::Api }

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

      context "Utility functions" do
        let(:api) { described_class::Api }

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

        context "String decoding" do
          let(:status) { api.new_status() }

          subject(:subject) { api.decode_string("Hello", 6, "Hello", 5, status) }

          it "decodes a string" do
            expect(subject).to be_truthy
            expect(status.code).to eq :ok
          end
        end
      end
    end
  end
end
