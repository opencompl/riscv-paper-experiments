# Max Pooling layer

Equivalent of a Keras `Y = MaxPooling2D((3,3),strides = 2,name = 'max0')(X)` layer

``` python
import numpy as np

# Assuming X is a 4D NumPy array with the shape (batch_size, height, width, num_channels)
X = ...

# Define the pooling parameters
pool_size = (3, 3)
stride = 2

# Perform the max pooling operation
max0_output = np.zeros((X.shape[0],
                       (X.shape[1] - pool_size[0]) // stride + 1,
                       (X.shape[2] - pool_size[1]) // stride + 1,
                       X.shape[3]))

for h in range(0, X.shape[1] - pool_size[0] + 1, stride):
    for w in range(0, X.shape[2] - pool_size[1] + 1, stride):
        pooling_region = X[:, h:h + pool_size[0], w:w + pool_size[1], :]
        max0_output[:, h // stride, w // stride, :] = np.max(pooling_region, axis=(1, 2))
```
