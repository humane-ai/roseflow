# encoding: utf-8

require "spec_helper"

RSpec.describe Roseflow::Elements::Input do
  describe "Creating an input" do
    context "Empty input" do
      it "creates a new empty input if not attributes are given" do
        input = described_class.new
        expect(input).to be_a described_class
      end

      it "creates a new empty input if an empty arguments hash is given" do
        input = described_class.new({})
        expect(input).to be_a described_class
      end
    end

    context "Calling superclass first" do
      it "calls initialize of the superclass" do
        # expect(Roseflow::Elements::BaseElement).to receive(:new).with(nil)
        expect { described_class.new(nil) }.to raise_error ArgumentError
      end
    end

    context "Blocks" do
      specify { expect { |block| described_class.new({}, &block) }.to yield_control }
    end

    let(:input_attr) do
      {
        name: :input_1,
        description: "New Input",
        data: [1,2,3],
        placeholder: false,
        type: :float32,
        shape: [nil, 784]
      }
    end

    it "creates a new input with given attributes" do
      input = described_class.new(input_attr)
      expect(input).to be_a described_class
      expect(input.name).to eq :input_1
      expect(input.description).to eq "New Input"
      expect(input.data).to eq [1,2,3]
    end

    context "Placeholder" do
      let(:graph) { Roseflow::Graph.new }
      let(:with_placeholder) { input_attr.merge(placeholder: true, graph: graph) }
      let(:without_graph) { input_attr.merge(placeholder: true) }

      it "creates a new input and a placeholder" do
        input = described_class.new(with_placeholder)
        expect(input).to be_a described_class
        expect(graph.placeholders.count).to eq 1
      end

      it "creates a new input and a placeholder" do
        expect(graph.placeholders).to receive(:create_from_input).with(instance_of(described_class))
        input = described_class.new(with_placeholder)
      end

      it "will not create a placeholder if no associated graph specified" do
        expect { described_class.new(without_graph) }
          .to raise_error(::Roseflow::UnknownGraphError)
          .with_message(/you must specify associated graph/i)

        expect { described_class.new(without_graph.merge(graph: "foo")) }
          .to raise_error(::Roseflow::UnknownGraphError)
          .with_message(/you must specify associated graph/i)
      end
    end
  end

  describe "Methods" do
    describe "#extract_options" do
      context "Valid options" do
        let(:valid_options) do
          {
            name: :my_input,
            data: [1,2,3],
            description: "My Input",
            shape: [nil, 784],
            type: :float32,
            graph: :my_graph
          }
        end

        it "extracts valid options and sets them as instance variables" do
          input = described_class.new()
          expect(input).to receive(:instance_variable_set).with("@data", [1,2,3])
          expect(input).to receive(:instance_variable_set).with("@description", "My Input")
          expect(input).to receive(:instance_variable_set).with("@shape", [nil, 784])
          expect(input).to receive(:instance_variable_set).with("@type", :float32)
          expect(input).to receive(:instance_variable_set).with("@graph", :my_graph)
          expect(input.extract_options(valid_options)).to be_truthy
        end

        it "sets the accessors only for given class" do
          input = described_class.new(valid_options)
          input2 = described_class.new
          expect(input2.instance_variable_defined?("@description")).to be_falsey
        end
      end

      context "Bogus options" do
        let(:bogus_options) do
          {
            foo: "bar"
          }
        end

        it "will discard bogus options" do
          input = described_class.new
          expect(input).not_to receive(:instance_variable_set).with("@foo", "bar")
          input.extract_options(bogus_options)
        end
      end
    end
  end

  describe "Class Methods" do
    describe ".build" do
      let(:arguments) { { name: :my_input, description: "My Input"} }

      it "creates a new instance of the class with given arguments" do
        expect(described_class).to receive(:new).with(arguments)
        described_class.build(arguments)
      end

      it "creates a new instance if no arguments are given" do
        expect(described_class).to receive(:new).with({})
        described_class.build
      end

      specify { expect { |block| described_class.build({}, &block) }.to yield_control }
    end
  end
end
