module Roseflow::Tensorflow
  module Utility
    def shape_of(value)
      array = Numo::DFloat.cast(value)
      array.shape
    end
  end
end
