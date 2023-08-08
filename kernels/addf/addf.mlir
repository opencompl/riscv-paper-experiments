
#add_accesses = [
  affine_map<(m, n) -> (m, n)>,
  affine_map<(m, n) -> (m, n)>
]

#add_attributes = {
  indexing_maps = #add_accesses,
  iterator_types = ["parallel", "parallel"]
}

func.func @addf(%A: memref<?x?xf32>,
                %B: memref<?x?xf32>) {
  linalg.generic #add_attributes
  ins(%B: memref<?x?xf32>)
  outs(%A: memref<?x?xf32>) {
  ^bb0(%b: f32, %a: f32):
    %res = arith.addf %a, %b : f32
    linalg.yield %res : f32    
  }
  return
}
