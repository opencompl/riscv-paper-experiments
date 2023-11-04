
func.func public @fill(%X: f64,
                       %Y: tensor<16x16xf64>) -> () {
  %res = linalg.fill ins(%X : f64) outs(%Y : tensor<16x16xf64>) -> tensor<16x16xf64>
  return
}
