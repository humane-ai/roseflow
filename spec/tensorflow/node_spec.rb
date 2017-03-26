# encoding: utf-8

require "spec_helper"

RSpec.describe TensorFlow::Node do
  describe "Class methods" do
    describe ".from_nodedef(definition)" do
      let(:definition) { described_class::PROTOBUF_CLASS.new }

      subject(:subject) { described_class.from_nodedef(definition) }

      it "instantiates a new Node from node definition" do
        expect(subject).to be_a described_class
      end
    end
  end
end
