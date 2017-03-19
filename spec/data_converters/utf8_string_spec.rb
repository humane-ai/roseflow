require "spec_helper"

RSpec.describe TensorFlow::LibTensorFlow::UTF8String do
  module C
    extend FFI::Library
    ffi_lib [FFI::CURRENT_PROCESS, 'c']

    attach_function :strncpy, [ :pointer, TensorFlow::LibTensorFlow::UTF8String, :size_t ], TensorFlow::LibTensorFlow::UTF8String
  end

  let(:char) do
    char = "\xC4"
    char.force_encoding(Encoding::ISO_8859_1)
    char
  end

  it "should convert any strings to UTF-8 before reading and writing" do
    dest   = FFI::MemoryPointer.new(:char, 3) # two bytes for the ä, one for the NULL
    result = C.strncpy(dest, char, 3)

    expect(result.encoding).to eq Encoding::UTF_8
    expect(result).to eq "Ä"
    expect(result.bytesize).to eq 2
  end
end
