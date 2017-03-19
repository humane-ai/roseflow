require "spec_helper"

RSpec.describe TensorFlow::LibTensorFlow do
  context "API" do
    context "Low-level bindings" do
      context "Core functions" do
        subject(:api) { described_class::Api }

        it "binds core functions of the C API" do
          [ :Version ].each do |sym|
            expect(api).to respond_to("TF_#{sym}")
          end
        end

        it "returns the version of the TensorFlow library as a string" do
          expect(api.TF_Version).to be_a String
        end
      end
    end
  end
end
