# encoding: utf-8

require "spec_helper"

RSpec.describe Roseflow::Session do
  describe "Initialization" do
    subject(:subject) { described_class.new }

    it "can initialize the object" do
      expect(subject).to be_a described_class
    end

    it "does not have a session reference by default" do
      expect(subject).not_to be_connected
    end
  end

  describe "Opening a session" do
    subject(:subject) { described_class.new }

    context "Opening a new active session to TensorFlow" do
      it "opens a new active session to TensorFlow" do
        expect(subject.connect).to eq true
        expect(subject).to be_connected
        expect(subject.session).to be_a Roseflow::Tensorflow::Session
      end
    end
  end

  describe "Deleting a session" do
    subject(:subject) { described_class.new }

    before do
      subject.connect
    end

    context "Deleting a session and all its references" do
      it "deletes the session" do
        expect(subject.disconnect).to be true
        expect(subject).not_to be_connected
        expect(subject.session).to be_nil
        expect(subject.session_options).to be_nil
      end
    end
  end

  describe "Closing a session" do
    subject(:subject) { described_class.new }

    before do
      subject.connect
    end

    context "Close a session" do
      it "closes the session" do
        expect(subject.close).to be true
      end
    end
  end
end
