require "spec_helper"

RSpec.describe Roseflow::Tensorflow::Utility do
  context "Determining shape of a value" do
    let(:dummy) { Class.new { extend Roseflow::Tensorflow::Utility } }

    subject(:multi_dimensional) { dummy.shape_of([[2], [4]]) }
    subject(:single_dimensional) { dummy.shape_of([1, 2]) }
    subject(:string) { dummy.shape_of("String") }

    it "returns the shape of a multi-dimensional array" do
      expect(multi_dimensional).to eq [2,1]
    end

    it "returns the shape of a single-dimensional array" do
      expect(single_dimensional).to eq [2]
    end

    it "raises an error when it cannot compute the shape" do
      expect{ string }.to raise_error(Numo::NArray::CastError)
    end
  end
end
