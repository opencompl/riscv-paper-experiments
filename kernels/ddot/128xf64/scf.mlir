
func.func public @ddot(%X: memref<128xf64>, %Y: memref<128xf64>, %Z: memref<f64>) -> memref<f64> {
    %c0 = arith.constant 0 : index
    %c128 = arith.constant 128 : index
    %c1 = arith.constant 1 : index
    %init = memref.load %Z[] : memref<f64>
    %res = scf.for %i = %c0 to %c128 step %c1 iter_args(%acc_in = %init) -> (f64) {
        %x = memref.load %X[%i] : memref<128xf64>
        %y = memref.load %Y[%i] : memref<128xf64>
        %xy = arith.mulf %x, %y : f64
        %acc_out = arith.addf %acc_in, %xy : f64
        scf.yield %acc_out : f64
    }
    memref.store %res, %Z[] : memref<f64>
    return %Z : memref<f64>
}
