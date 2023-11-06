
func.func public @conv_2d_nchw_fchw_d1_s1_3x3(
  %X: memref<1x1x8x8xf64>,
  %Y: memref<1x1x3x3xf64>,
  %Z: memref<1x1x6x6xf64>) -> () {
  linalg.conv_2d_nchw_fchw {
    dilations = dense<1> : vector<2xi64>,
    strides = dense<1> : vector<2xi64>
  } ins(%X, %Y : memref<1x1x8x8xf64>, memref<1x1x3x3xf64>)
    outs(%Z : memref<1x1x6x6xf64>) -> ()
  return
}
