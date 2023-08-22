#add_accesses = [
  affine_map<(m, n) -> (m, n)>,
  affine_map<(m, n) -> (m, n)>
]

#add_attributes = {
  indexing_maps = #add_accesses,
  iterator_types = ["parallel", "parallel"]
}

func.func public @addf(%A: memref<13x26xf32>,
                       %B: memref<13x26xf32>) -> () {
  linalg.generic #add_attributes
  ins(%B: memref<13x26xf32>)
  outs(%A: memref<13x26xf32>) {
  ^bb0(%b: f32, %a: f32):
    %res = arith.addf %a, %b : f32
    linalg.yield %res : f32    
  }
  return
}
