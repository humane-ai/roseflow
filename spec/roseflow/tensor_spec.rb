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

        it "sets the rank of the tensor" do
          expect(tensor.rank).to eq 2
        end

        context "Deeper structures" do
          let(:first) { [[1,2,3],[1,2,3]] }
          let(:second) { Numo::DFloat.new(2,3,3) }
          let(:third) { [[[2,3,4],[2,3,4],[2,3,4]],[[2,3,4],[2,3,4],[2,3,4]]] }

          let(:first_tensor) { described_class.new(first, :float) }
          let(:second_tensor) { described_class.new(second, :float) }
          let(:third_tensor) { described_class.new(third, :float) }

          it "sets the shape of the tensor" do
            expect(first_tensor.shape).to eq [2,3]
            expect(second_tensor.shape).to eq [2,3,3]
            expect(third_tensor.shape).to eq [2,3,3]
          end

          it "sets the rank of the tensor" do
            expect(first_tensor.rank).to eq 2
            expect(second_tensor.rank).to eq 3
            expect(third_tensor.rank).to eq 3
          end
        end
      end
    end
  end

  describe "Methods" do
    describe "#shape_of(value)" do
      context "Strings" do
        subject(:subject) { described_class.shape_of("String") }

        it "returns an empty array" do
          expect(subject).to eq []
        end
      end

      context "1-D arrays" do
        subject(:subject) { described_class.shape_of([1,2,3]) }

        it "returns correct shape" do
          expect(subject).to eq [3]
        end
      end

      context "2-D arrays" do
        subject(:subject) { described_class.shape_of([[1,2],[1,2]]) }

        it "returns correct shape" do
          expect(subject).to eq [2,2]
        end
      end

      context "n-D arrays" do
        subject(:subject) { described_class.shape_of([[[2,3,4],[2,3,4],[2,3,4]],[[2,3,4],[2,3,4],[2,3,4]]]) }

        it "returns correct shape" do
          expect(subject).to eq [2,3,3]
        end
      end
    end
  end
end
