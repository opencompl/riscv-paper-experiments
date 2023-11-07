# Sum Pooling layer

Sum pooling is an operation with many parameters. The one that AlexNet uses is
`pooling_nchw_sum`, where nchw stand for "number of elements in batch", "channels",
"height", and "width".

There are two additional parameters to the linalg operation:
    1. `dilations`, which we take to be 1
        - this parameter determines how big the receptive field of the pooling is
        - a 5x5 pool with dilation 1's corner elements for pooling are the same as a 3x3
        pool with dilation 2's corner elements.
        - see <https://datascience.stackexchange.com/questions/28881/what-is-dilated-pooling-and-how-it-works-mathematically>
    2. `strides`, meaning the a sort of stride of where to pool from, which we take to be 2
        - the bigger the stride, the smaller the output shape.
        - see <https://datascience.stackexchange.com/questions/28881/what-is-dilated-pooling-and-how-it-works-mathematically>
