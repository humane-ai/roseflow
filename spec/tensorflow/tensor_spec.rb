# encoding: utf-8

require "spec_helper"

RSpec.describe Roseflow::Tensor do
  context "Initialization" do
    context "Types" do
      supported_types = {
        float: [1], float64: [2], int32: [3], int64: [4], string: "Five", complex: [6]
      }

      supported_types.each do |type, value|
        describe "with type #{type}" do
          subject(:subject) { described_class.new(value, type) }

          it "initializes a tensor with correct type and type settings" do
            expect(subject).to be_a Roseflow::Tensor
          end

          it "does not raise an error" do
            expect{ subject }.not_to raise_error(ArgumentError).with_message("Data type #{type} is not (yet) supported.")
          end
        end
      end

      describe "Unsupported types" do
        context "nil type" do
          it "fails to initialize a tensor" do
            expect{ described_class.new("Nil", nil) }.to raise_error(ArgumentError).with_message("Data type  is not (yet) supported.")
          end
        end

        context "Unknown type" do
          it "fails to initialize a tensor" do
            expect{ described_class.new("Unknown", :unknown) }.to raise_error(ArgumentError).with_message("Data type unknown is not (yet) supported.")
          end
        end
      end
    end

    context "Processing values" do
      context "Initial processing" do
        let(:value) { [[1,2,3]] }
        let(:tensor) { described_class.new(value, :int32) }

        it "tries to convert input to an NArray" do
          expect(Numo::NArray).to receive(:new).with(1, 3).and_return(Numo::Int32.new(1, 3))
          tensor
        end

        it "sets the shape of the tensor" do
          expect(tensor.shape).to eq [1, 3]
        end

        context "Deeper structures" do
          values = [
            [[1,2,3],[1,2,3]],
            Numo::DFloat.new(2,3,3)
          ]

          values.each do |value|
            let(:tensor) { described_class.new(value, :float) }

            it "sets the shape of the tensor" do
              p value
              if value.is_a?(Array)
                expect(tensor.shape).to eq [2,3]
              end
              if value.is_a?(Numo::NArray)
                expect(tensor.shape).to eq [2,3,3]
              end
            end
          end
        end
      end
    end
  end
end
