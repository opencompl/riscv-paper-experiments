memref.global @A : memref<16x8xf32> = dense<[
  [   0.0,    1.0,    2.0,    3.0,    4.0,    5.0,    6.0,    7.0],
  [   8.0,    9.0,   10.0,   11.0,   12.0,   13.0,   14.0,   15.0],
  [  16.0,   17.0,   18.0,   19.0,   20.0,   21.0,   22.0,   23.0],
  [  24.0,   25.0,   26.0,   27.0,   28.0,   29.0,   30.0,   31.0],
  [  32.0,   33.0,   34.0,   35.0,   36.0,   37.0,   38.0,   39.0],
  [  40.0,   41.0,   42.0,   43.0,   44.0,   45.0,   46.0,   47.0],
  [  48.0,   49.0,   50.0,   51.0,   52.0,   53.0,   54.0,   55.0],
  [  56.0,   57.0,   58.0,   59.0,   60.0,   61.0,   62.0,   63.0],
  [  64.0,   65.0,   66.0,   67.0,   68.0,   69.0,   70.0,   71.0],
  [  72.0,   73.0,   74.0,   75.0,   76.0,   77.0,   78.0,   79.0],
  [  80.0,   81.0,   82.0,   83.0,   84.0,   85.0,   86.0,   87.0],
  [  88.0,   89.0,   90.0,   91.0,   92.0,   93.0,   94.0,   95.0],
  [  96.0,   97.0,   98.0,   99.0,  100.0,  101.0,  102.0,  103.0],
  [ 104.0,  105.0,  106.0,  107.0,  108.0,  109.0,  110.0,  111.0],
  [ 112.0,  113.0,  114.0,  115.0,  116.0,  117.0,  118.0,  119.0],
  [ 120.0,  121.0,  122.0,  123.0,  124.0,  125.0,  126.0,  127.0]
]>

memref.global @B : memref<16x8xf32> = dense<[
  [   0.0,    0.5,    1.0,    1.5,    2.0,    2.5,    3.0,    3.5],
  [   4.0,    4.5,    5.0,    5.5,    6.0,    6.5,    7.0,    7.5],
  [   8.0,    8.5,    9.0,    9.5,   10.0,   10.5,   11.0,   11.5],
  [  12.0,   12.5,   13.0,   13.5,   14.0,   14.5,   15.0,   15.5],
  [  16.0,   16.5,   17.0,   17.5,   18.0,   18.5,   19.0,   19.5],
  [  20.0,   20.5,   21.0,   21.5,   22.0,   22.5,   23.0,   23.5],
  [  24.0,   24.5,   25.0,   25.5,   26.0,   26.5,   27.0,   27.5],
  [  28.0,   28.5,   29.0,   29.5,   30.0,   30.5,   31.0,   31.5],
  [  32.0,   32.5,   33.0,   33.5,   34.0,   34.5,   35.0,   35.5],
  [  36.0,   36.5,   37.0,   37.5,   38.0,   38.5,   39.0,   39.5],
  [  40.0,   40.5,   41.0,   41.5,   42.0,   42.5,   43.0,   43.5],
  [  44.0,   44.5,   45.0,   45.5,   46.0,   46.5,   47.0,   47.5],
  [  48.0,   48.5,   49.0,   49.5,   50.0,   50.5,   51.0,   51.5],
  [  52.0,   52.5,   53.0,   53.5,   54.0,   54.5,   55.0,   55.5],
  [  56.0,   56.5,   57.0,   57.5,   58.0,   58.5,   59.0,   59.5],
  [  60.0,   60.5,   61.0,   61.5,   62.0,   62.5,   63.0,   63.5]
]>

memref.global @A_PLUS_B : memref<16x8xf32> = dense<[
  [   0.0,    1.5,    3.0,    4.5,    6.0,    7.5,    9.0,   10.5],
  [  12.0,   13.5,   15.0,   16.5,   18.0,   19.5,   21.0,   22.5],
  [  24.0,   25.5,   27.0,   28.5,   30.0,   31.5,   33.0,   34.5],
  [  36.0,   37.5,   39.0,   40.5,   42.0,   43.5,   45.0,   46.5],
  [  48.0,   49.5,   51.0,   52.5,   54.0,   55.5,   57.0,   58.5],
  [  60.0,   61.5,   63.0,   64.5,   66.0,   67.5,   69.0,   70.5],
  [  72.0,   73.5,   75.0,   76.5,   78.0,   79.5,   81.0,   82.5],
  [  84.0,   85.5,   87.0,   88.5,   90.0,   91.5,   93.0,   94.5],
  [  96.0,   97.5,   99.0,  100.5,  102.0,  103.5,  105.0,  106.5],
  [ 108.0,  109.5,  111.0,  112.5,  114.0,  115.5,  117.0,  118.5],
  [ 120.0,  121.5,  123.0,  124.5,  126.0,  127.5,  129.0,  130.5],
  [ 132.0,  133.5,  135.0,  136.5,  138.0,  139.5,  141.0,  142.5],
  [ 144.0,  145.5,  147.0,  148.5,  150.0,  151.5,  153.0,  154.5],
  [ 156.0,  157.5,  159.0,  160.5,  162.0,  163.5,  165.0,  166.5],
  [ 168.0,  169.5,  171.0,  172.5,  174.0,  175.5,  177.0,  178.5],
  [ 180.0,  181.5,  183.0,  184.5,  186.0,  187.5,  189.0,  190.5]
]>

func.func @get_memref_a() -> (memref<?x?xf32>) {
    %static = memref.get_global @A : memref<16x8xf32>
    %dynamic = memref.cast %static : memref<16x8xf32> to memref<?x?xf32>
    func.return %dynamic : memref<?x?xf32>
}

func.func @get_memref_b() -> (memref<?x?xf32>) {
    %static = memref.get_global @B : memref<16x8xf32>
    %dynamic = memref.cast %static : memref<16x8xf32> to memref<?x?xf32>
    func.return %dynamic : memref<?x?xf32>
}

func.func @get_memref_reference() -> (memref<?x?xf32>) {
    %static = memref.get_global @A_PLUS_B : memref<16x8xf32>
    %dynamic = memref.cast %static : memref<16x8xf32> to memref<?x?xf32>
    func.return %dynamic : memref<?x?xf32>
}