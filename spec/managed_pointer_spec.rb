# encoding: utf-8
require "spec_helper"

RSpec.describe TensorFlow::LibTensorFlow::ManagedPointer do
  let(:null) { FFI::Pointer::NULL }
  let(:pointer) { FFI::Pointer.new(1) }
  let(:klass) { TensorFlow::LibTensorFlow::Status }
  let(:retaining_klass) { klass.retaining_class }

  it "adds a ref if it is a retaining class" do
    expect(api).to receive(:status_add_ref)
    ptr = retaining_klass.new(FFI::Pointer.new(1))
    ptr.autorelease = false
  end

  it "does not add or release when the pointer is null" do
    expect(api).not_to receive(:status_add_ref)
    expect(api).not_to receive(:status_release)

    ptr = retaining_klass.new(FFI::Pointer::NULL)
    ptr.free
  end

  describe "#release" do
    it "wraps the release pointer properly to avoid type-failures" do
      expect(api).to receive(:delete_status) do |pointer|
        expect(pointer).to be_instance_of(klass)
        expect(pointer).not_to be_autorelease
      end

      ptr = klass.new(FFI::Pointer.new(1))
      ptr.free
    end
  end

  describe ".to_native" do
    it "does not accept null pointers" do
      expect { klass.to_native(nil, nil) }.to raise_error(TypeError, /cannot be null/)
      expect { klass.to_native(TensorFlow::LibTensorFlow::Status.new(null), nil) }.to raise_error(TypeError, /cannot be null/)
    end

    it "does not accept pointers of another type" do
      expect { klass.to_native(pointer, nil) }.to raise_error(TypeError, /expected a kind of TensorFlow::LibTensorFlow::Status/)
      expect { klass.to_native(TensorFlow::LibTensorFlow::Session.new(pointer), nil) }.to raise_error(TypeError, /expected a kind of TensorFlow::LibTensorFlow::Status/)
    end

    it "accepts pointers of the same kind, or a subkind" do
      allow(api).to receive(:status_add_ref)

      retaining = retaining_klass.new(pointer)
      retaining.autorelease = false

      regular = klass.new(pointer)
      regular.autorelease = false

      expect { klass.to_native(retaining, nil) }.to_not raise_error
      expect { klass.to_native(regular, nil) }.to_not raise_error
      expect { retaining_klass.to_native(retaining, nil) }.to_not raise_error
      expect { retaining_klass.to_native(regular, nil) }.to_not raise_error
    end
  end

  describe ".from_native" do
    it "returns nil if pointer is null" do
      native = FFI::Pointer::NULL
      expect(klass.from_native(native, nil)).to be_nil
    end
  end

  describe ".size" do
    it "returns the size of a pointer" do
      expect(TensorFlow::LibTensorFlow::ManagedPointer.size).to eq FFI.type_size(:pointer)
    end
  end
end
