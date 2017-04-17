# encoding: utf-8

require "spec_helper"

RSpec.describe Roseflow::ActiveGraph::CollectionProxy do
  describe "New proxy" do
    FakeKlass = Struct.new(:owner, :klass, :collection) do

    end

    it "creates a new collection proxy" do
      proxy = described_class.new(FakeKlass, [])
      expect(proxy.klass).to eq FakeKlass
      expect(proxy).to be_empty
    end
  end
end
