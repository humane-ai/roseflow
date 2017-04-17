# encoding: utf-8

require "spec_helper"

RSpec.describe Roseflow::Elements::BaseElement do
  describe "Initializing" do
    context "with bogus arguments" do
      it "will create an instance but not parse a definition" do
        tensor = described_class.new({ foo: "bar" })
        expect(tensor).to be_a described_class
        expect(tensor.instance_variable_get(:@definition)).to eq nil
      end

      it "will fail with bogus arguments" do
        expect do
          described_class.new("string")
        end.to raise_error ArgumentError, "Invalid arguments"
      end
    end
  end

  describe "Methods" do
  end
end
