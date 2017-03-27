module Roseflow::Tensorflow
  module TypeSafety
    def to_native(value, ctx)
      if value.kind_of?(type_class)
        super
      else
        raise TypeError, "expected a kind of #{name}, was #{value.class}"
      end
    end

    def type_class
      self
    end
  end
end
