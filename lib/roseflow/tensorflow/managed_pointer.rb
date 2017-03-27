require "roseflow/tensorflow/data_converters/type_safety"

module Roseflow::Tensorflow
  class ManagedPointer < FFI::AutoPointer
    extend TypeSafety

    class << self
      def type
        name.split('::')[-1].downcase
      end

      def size
        FFI.type_size(:pointer)
      end

      def release(pointer)
        unless pointer.null?
          freeable = type_class.new(pointer)
          freeable.autorelease = false

          Roseflow::Tensorflow::API.public_send(:"delete_#{type}", pointer)
        end
      end

      def retain(pointer)
        unless pointer.null?
          Roseflow::Tensorflow::API.public_send(:"#{type}_add_ref", pointer)
        end
      end

      def to_native(value, ctx)
        if value.nil? || value.null?
          raise TypeError, "#{name} pointers cannot be null, was #{value.inspect}"
        else
          super
        end
      end

      # Casts all null pointers to nil.
      def from_native(pointer, ctx)
        value = super
        value unless value.null?
      end

      def retaining_class
        if defined?(self::Retaining)
          self::Retaining
        else
          subclass = Class.new(self) do
            class << self
              def type
                superclass.type
              end

              protected

              def type_class
                superclass
              end
            end

            alias_method :super_initialize, :initialize

            def initialize(*args, &block)
              super_initialize(*args, &block)
              self.class.retain(self)
            end
          end

          const_set("Retaining", subclass)
        end
      end
    end

    def type
      self.class.type
    end

    def free
      unless null?
        self.autorelease = false
        Roseflow::Tensorflow::API.public_send(:"delete_#{type}", self)
      end
    end

    def inspect
      "#<#{self.class} address=0x%x>" % address
    end

    alias_method :to_s, :inspect
  end
end
