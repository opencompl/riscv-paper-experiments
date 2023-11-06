
func.func public @fill(%X: f64,
                       %Y: memref<16x16xf64>) -> () {
  linalg.fill ins(%X : f64) outs(%Y : memref<16x16xf64>) -> ()
  return
}
