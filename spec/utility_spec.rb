require "spec_helper"

RSpec.describe TensorFlow::LibTensorFlow::Utility do
  context "Determining shape of a value" do
    let(:dummy) { Class.new { extend TensorFlow::LibTensorFlow::Utility } }

    subject(:subject) { dummy.shape_of([[2], [4]]) }

    it "returns the shape of an array" do
      expect(subject).to eq [2,1]
    end
  end
end
