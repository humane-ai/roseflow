class MultilayerConvolutionalNetwork < ActiveGraph::Base
  name "Multi-layer Convolutional Network"
  description "An example of multi-layer convolutional network for MNIST dataset"

  layers do
    layer "First Convolutional Layer", type: :convolutional do
      process :before do
        reshape [-1, 28, 28, 1]
      end

      operation "ReLU", :relu do
        conv2d weight: :fcl_conv2
        add bias: :fcl_bias
      end

      process :after do
        max_pool_2x2
      end
    end

    layer "Second Convolutional Layer", type: :convolutional do
      operation "ReLU", :relu do
        conv2d weight: :scl_conv2
        add bias: :scl_bias
      end

      process :after do
        max_pool_2x2
      end
    end

    layer "Densely Connected Layer", type: :dense do
      process :before do
        reshape [-1, 7*7*64]
      end

      operation "ReLU", :relu do
        matmul weight: :dcl_matmul
        add bias: :dcl_bias
      end
    end

    layer "Dropout", type: :dropout do
      operation "Dropout", :dropout do
        probability :dropout
        noise_shape nil
        seed nil
        name "Custom Dropout Name"
      end
    end

    layer "Readout", type: :readout do
      operation "Matmul", :matmul do
        add bias: :readout_bias
      end
    end
  end

  weights do
    weight :fcl_conv2 do
      shape [5, 5, 1, 32]

      process do
        truncated_normal stddev: 0.1
      end
    end

    weight :scl_conv2 do
      shape [5, 5, 32, 64]

      process do
        truncated_normal stddev: 0.1
      end
    end

    weight :dcl_matmul do
      shape [7 * 7 * 64, 1024]

      process do
        truncated_normal stddev: 0.1
      end
    end
  end

  biases do
    bias :fcl_bias do
      shape [32]

      process do
        constant 0.1, dtype: nil, name: "Const", verify_shape: false
      end
    end

    bias :scl_bias do
      shape [64]

      process do
        constant 0.1, dtype: nil, name: "Const", verify_shape: false
      end
    end

    bias :dcl_bias do
      shape [1024]

      process do
        constant 0.1, dtype: nil, name: "Const", verify_shape: false
      end
    end

    bias :readout_bias do
      shape [10]

      process do
        constant 0.1, dtype: nil, name: "Const", verify_shape: false
      end
    end
  end

  variables do
    # Any custom variables
  end

  placeholders do
    placeholder :dropout do
      dtype :float
    end
  end

  # TBD
  training do
    steps do
      step :cross_entropy do
        reduce_mean
      end
    end
  end
end
