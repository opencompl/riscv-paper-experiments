memref.global constant @A : memref<13x26xf32> = dense<[
  [   0.0, 0.10000000149011612, 0.20000000298023224, 0.30000001192092896,
 0.4000000059604645,    0.5, 0.6000000238418579, 0.699999988079071,
 0.800000011920929, 0.8999999761581421,    1.0, 1.100000023841858,
 1.2000000476837158, 1.2999999523162842, 1.399999976158142,    1.5,
 1.600000023841858, 1.7000000476837158, 1.7999999523162842,
 1.899999976158142,    2.0, 2.0999999046325684, 2.200000047683716,
 2.299999952316284, 2.4000000953674316,    2.5],
  [2.5999999046325684, 2.700000047683716, 2.799999952316284,
 2.9000000953674316,    3.0, 3.0999999046325684, 3.200000047683716,
 3.299999952316284, 3.4000000953674316,    3.5, 3.5999999046325684,
 3.700000047683716, 3.799999952316284, 3.9000000953674316,    4.0,
 4.099999904632568, 4.199999809265137, 4.300000190734863,
 4.400000095367432,    4.5, 4.599999904632568, 4.699999809265137,
 4.800000190734863, 4.900000095367432,    5.0, 5.099999904632568],
  [5.199999809265137, 5.300000190734863, 5.400000095367432,    5.5,
 5.599999904632568, 5.699999809265137, 5.800000190734863,
 5.900000095367432,    6.0, 6.099999904632568, 6.199999809265137,
 6.300000190734863, 6.400000095367432,    6.5, 6.599999904632568,
 6.699999809265137, 6.800000190734863, 6.900000095367432,    7.0,
 7.099999904632568, 7.199999809265137, 7.300000190734863,
 7.400000095367432,    7.5, 7.599999904632568, 7.699999809265137],
  [7.800000190734863, 7.900000095367432,    8.0, 8.100000381469727,
 8.199999809265137, 8.300000190734863, 8.399999618530273,    8.5,
 8.600000381469727, 8.699999809265137, 8.800000190734863,
 8.899999618530273,    9.0, 9.100000381469727, 9.199999809265137,
 9.300000190734863, 9.399999618530273,    9.5, 9.600000381469727,
 9.699999809265137, 9.800000190734863, 9.899999618530273,   10.0,
 10.100000381469727, 10.199999809265137, 10.300000190734863],
  [10.399999618530273,   10.5, 10.600000381469727, 10.699999809265137,
 10.800000190734863, 10.899999618530273,   11.0, 11.100000381469727,
 11.199999809265137, 11.300000190734863, 11.399999618530273,   11.5,
 11.600000381469727, 11.699999809265137, 11.800000190734863,
 11.899999618530273,   12.0, 12.100000381469727, 12.199999809265137,
 12.300000190734863, 12.399999618530273,   12.5, 12.600000381469727,
 12.699999809265137, 12.800000190734863, 12.899999618530273],
  [  13.0, 13.100000381469727, 13.199999809265137, 13.300000190734863,
 13.399999618530273,   13.5, 13.600000381469727, 13.699999809265137,
 13.800000190734863, 13.899999618530273,   14.0, 14.100000381469727,
 14.199999809265137, 14.300000190734863, 14.399999618530273,   14.5,
 14.600000381469727, 14.699999809265137, 14.800000190734863,
 14.899999618530273,   15.0, 15.100000381469727, 15.199999809265137,
 15.300000190734863, 15.399999618530273,   15.5],
  [15.600000381469727, 15.699999809265137, 15.800000190734863,
 15.899999618530273,   16.0, 16.100000381469727, 16.200000762939453,
 16.299999237060547, 16.399999618530273,   16.5, 16.600000381469727,
 16.700000762939453, 16.799999237060547, 16.899999618530273,   17.0,
 17.100000381469727, 17.200000762939453, 17.299999237060547,
 17.399999618530273,   17.5, 17.600000381469727, 17.700000762939453,
 17.799999237060547, 17.899999618530273,   18.0, 18.100000381469727],
  [18.200000762939453, 18.299999237060547, 18.399999618530273,   18.5,
 18.600000381469727, 18.700000762939453, 18.799999237060547,
 18.899999618530273,   19.0, 19.100000381469727, 19.200000762939453,
 19.299999237060547, 19.399999618530273,   19.5, 19.600000381469727,
 19.700000762939453, 19.799999237060547, 19.899999618530273,   20.0,
 20.100000381469727, 20.200000762939453, 20.299999237060547,
 20.399999618530273,   20.5, 20.600000381469727, 20.700000762939453],
  [20.799999237060547, 20.899999618530273,   21.0, 21.100000381469727,
 21.200000762939453, 21.299999237060547, 21.399999618530273,   21.5,
 21.600000381469727, 21.700000762939453, 21.799999237060547,
 21.899999618530273,   22.0, 22.100000381469727, 22.200000762939453,
 22.299999237060547, 22.399999618530273,   22.5, 22.600000381469727,
 22.700000762939453, 22.799999237060547, 22.899999618530273,   23.0,
 23.100000381469727, 23.200000762939453, 23.299999237060547],
  [23.399999618530273,   23.5, 23.600000381469727, 23.700000762939453,
 23.799999237060547, 23.899999618530273,   24.0, 24.100000381469727,
 24.200000762939453, 24.299999237060547, 24.399999618530273,   24.5,
 24.600000381469727, 24.700000762939453, 24.799999237060547,
 24.899999618530273,   25.0, 25.100000381469727, 25.200000762939453,
 25.299999237060547, 25.399999618530273,   25.5, 25.600000381469727,
 25.700000762939453, 25.799999237060547, 25.899999618530273],
  [  26.0, 26.100000381469727, 26.200000762939453, 26.299999237060547,
 26.399999618530273,   26.5, 26.600000381469727, 26.700000762939453,
 26.799999237060547, 26.899999618530273,   27.0, 27.100000381469727,
 27.200000762939453, 27.299999237060547, 27.399999618530273,   27.5,
 27.600000381469727, 27.700000762939453, 27.799999237060547,
 27.899999618530273,   28.0, 28.100000381469727, 28.200000762939453,
 28.299999237060547, 28.399999618530273,   28.5],
  [28.600000381469727, 28.700000762939453, 28.799999237060547,
 28.899999618530273,   29.0, 29.100000381469727, 29.200000762939453,
 29.299999237060547, 29.399999618530273,   29.5, 29.600000381469727,
 29.700000762939453, 29.799999237060547, 29.899999618530273,   30.0,
 30.100000381469727, 30.200000762939453, 30.299999237060547,
 30.399999618530273,   30.5, 30.600000381469727, 30.700000762939453,
 30.799999237060547, 30.899999618530273,   31.0, 31.100000381469727],
  [31.200000762939453, 31.299999237060547, 31.399999618530273,   31.5,
 31.600000381469727, 31.700000762939453, 31.799999237060547,
 31.899999618530273,   32.0, 32.099998474121094, 32.20000076293945,
 32.29999923706055, 32.400001525878906,   32.5, 32.599998474121094,
 32.70000076293945, 32.79999923706055, 32.900001525878906,   33.0,
 33.099998474121094, 33.20000076293945, 33.29999923706055,
 33.400001525878906,   33.5, 33.599998474121094, 33.70000076293945]
]>


memref.global constant @B : memref<13x26xf32> = dense<[
  [   0.0, 0.05000000074505806, 0.10000000149011612, 0.15000000596046448,
 0.20000000298023224,   0.25, 0.30000001192092896, 0.3499999940395355,
 0.4000000059604645, 0.44999998807907104,    0.5, 0.550000011920929,
 0.6000000238418579, 0.6499999761581421, 0.699999988079071,   0.75,
 0.800000011920929, 0.8500000238418579, 0.8999999761581421,
 0.949999988079071,    1.0, 1.0499999523162842, 1.100000023841858,
 1.149999976158142, 1.2000000476837158,   1.25],
  [1.2999999523162842, 1.350000023841858, 1.399999976158142,
 1.4500000476837158,    1.5, 1.5499999523162842, 1.600000023841858,
 1.649999976158142, 1.7000000476837158,   1.75, 1.7999999523162842,
 1.850000023841858, 1.899999976158142, 1.9500000476837158,    2.0,
 2.049999952316284, 2.0999999046325684, 2.1500000953674316,
 2.200000047683716,   2.25, 2.299999952316284, 2.3499999046325684,
 2.4000000953674316, 2.450000047683716,    2.5, 2.549999952316284],
  [2.5999999046325684, 2.6500000953674316, 2.700000047683716,   2.75,
 2.799999952316284, 2.8499999046325684, 2.9000000953674316,
 2.950000047683716,    3.0, 3.049999952316284, 3.0999999046325684,
 3.1500000953674316, 3.200000047683716,   3.25, 3.299999952316284,
 3.3499999046325684, 3.4000000953674316, 3.450000047683716,    3.5,
 3.549999952316284, 3.5999999046325684, 3.6500000953674316,
 3.700000047683716,   3.75, 3.799999952316284, 3.8499999046325684],
  [3.9000000953674316, 3.950000047683716,    4.0, 4.050000190734863,
 4.099999904632568, 4.150000095367432, 4.199999809265137,   4.25,
 4.300000190734863, 4.349999904632568, 4.400000095367432,
 4.449999809265137,    4.5, 4.550000190734863, 4.599999904632568,
 4.650000095367432, 4.699999809265137,   4.75, 4.800000190734863,
 4.849999904632568, 4.900000095367432, 4.949999809265137,    5.0,
 5.050000190734863, 5.099999904632568, 5.150000095367432],
  [5.199999809265137,   5.25, 5.300000190734863, 5.349999904632568,
 5.400000095367432, 5.449999809265137,    5.5, 5.550000190734863,
 5.599999904632568, 5.650000095367432, 5.699999809265137,   5.75,
 5.800000190734863, 5.849999904632568, 5.900000095367432,
 5.949999809265137,    6.0, 6.050000190734863, 6.099999904632568,
 6.150000095367432, 6.199999809265137,   6.25, 6.300000190734863,
 6.349999904632568, 6.400000095367432, 6.449999809265137],
  [   6.5, 6.550000190734863, 6.599999904632568, 6.650000095367432,
 6.699999809265137,   6.75, 6.800000190734863, 6.849999904632568,
 6.900000095367432, 6.949999809265137,    7.0, 7.050000190734863,
 7.099999904632568, 7.150000095367432, 7.199999809265137,   7.25,
 7.300000190734863, 7.349999904632568, 7.400000095367432,
 7.449999809265137,    7.5, 7.550000190734863, 7.599999904632568,
 7.650000095367432, 7.699999809265137,   7.75],
  [7.800000190734863, 7.849999904632568, 7.900000095367432,
 7.949999809265137,    8.0, 8.050000190734863, 8.100000381469727,
 8.149999618530273, 8.199999809265137,   8.25, 8.300000190734863,
 8.350000381469727, 8.399999618530273, 8.449999809265137,    8.5,
 8.550000190734863, 8.600000381469727, 8.649999618530273,
 8.699999809265137,   8.75, 8.800000190734863, 8.850000381469727,
 8.899999618530273, 8.949999809265137,    9.0, 9.050000190734863],
  [9.100000381469727, 9.149999618530273, 9.199999809265137,   9.25,
 9.300000190734863, 9.350000381469727, 9.399999618530273,
 9.449999809265137,    9.5, 9.550000190734863, 9.600000381469727,
 9.649999618530273, 9.699999809265137,   9.75, 9.800000190734863,
 9.850000381469727, 9.899999618530273, 9.949999809265137,   10.0,
 10.050000190734863, 10.100000381469727, 10.149999618530273,
 10.199999809265137,  10.25, 10.300000190734863, 10.350000381469727],
  [10.399999618530273, 10.449999809265137,   10.5, 10.550000190734863,
 10.600000381469727, 10.649999618530273, 10.699999809265137,  10.75,
 10.800000190734863, 10.850000381469727, 10.899999618530273,
 10.949999809265137,   11.0, 11.050000190734863, 11.100000381469727,
 11.149999618530273, 11.199999809265137,  11.25, 11.300000190734863,
 11.350000381469727, 11.399999618530273, 11.449999809265137,   11.5,
 11.550000190734863, 11.600000381469727, 11.649999618530273],
  [11.699999809265137,  11.75, 11.800000190734863, 11.850000381469727,
 11.899999618530273, 11.949999809265137,   12.0, 12.050000190734863,
 12.100000381469727, 12.149999618530273, 12.199999809265137,  12.25,
 12.300000190734863, 12.350000381469727, 12.399999618530273,
 12.449999809265137,   12.5, 12.550000190734863, 12.600000381469727,
 12.649999618530273, 12.699999809265137,  12.75, 12.800000190734863,
 12.850000381469727, 12.899999618530273, 12.949999809265137],
  [  13.0, 13.050000190734863, 13.100000381469727, 13.149999618530273,
 13.199999809265137,  13.25, 13.300000190734863, 13.350000381469727,
 13.399999618530273, 13.449999809265137,   13.5, 13.550000190734863,
 13.600000381469727, 13.649999618530273, 13.699999809265137,  13.75,
 13.800000190734863, 13.850000381469727, 13.899999618530273,
 13.949999809265137,   14.0, 14.050000190734863, 14.100000381469727,
 14.149999618530273, 14.199999809265137,  14.25],
  [14.300000190734863, 14.350000381469727, 14.399999618530273,
 14.449999809265137,   14.5, 14.550000190734863, 14.600000381469727,
 14.649999618530273, 14.699999809265137,  14.75, 14.800000190734863,
 14.850000381469727, 14.899999618530273, 14.949999809265137,   15.0,
 15.050000190734863, 15.100000381469727, 15.149999618530273,
 15.199999809265137,  15.25, 15.300000190734863, 15.350000381469727,
 15.399999618530273, 15.449999809265137,   15.5, 15.550000190734863],
  [15.600000381469727, 15.649999618530273, 15.699999809265137,  15.75,
 15.800000190734863, 15.850000381469727, 15.899999618530273,
 15.949999809265137,   16.0, 16.049999237060547, 16.100000381469727,
 16.149999618530273, 16.200000762939453,  16.25, 16.299999237060547,
 16.350000381469727, 16.399999618530273, 16.450000762939453,   16.5,
 16.549999237060547, 16.600000381469727, 16.649999618530273,
 16.700000762939453,  16.75, 16.799999237060547, 16.850000381469727]
]>


memref.global constant @A_PLUS_B : memref<13x26xf32> = dense<[
  [   0.0, 0.15000000596046448, 0.30000001192092896, 0.45000001788139343,
 0.6000000238418579,   0.75, 0.9000000357627869, 1.0499999523162842,
 1.2000000476837158, 1.3499999046325684,    1.5, 1.6500000953674316,
 1.8000000715255737, 1.9499999284744263, 2.0999999046325684,   2.25,
 2.4000000953674316, 2.5500001907348633, 2.6999998092651367,
 2.8499999046325684,    3.0, 3.1499998569488525, 3.3000001907348633,
 3.4499998092651367, 3.6000001430511475,   3.75],
  [3.8999998569488525, 4.050000190734863, 4.199999809265137,
 4.350000381469727,    4.5, 4.649999618530273, 4.800000190734863,
 4.949999809265137, 5.100000381469727,   5.25, 5.399999618530273,
 5.550000190734863, 5.699999809265137, 5.850000381469727,    6.0,
 6.149999618530273, 6.299999713897705, 6.450000286102295,
 6.600000381469727,   6.75, 6.899999618530273, 7.049999713897705,
 7.200000286102295, 7.350000381469727,    7.5, 7.649999618530273],
  [7.799999713897705, 7.950000286102295, 8.100000381469727,   8.25,
 8.399999618530273, 8.549999237060547, 8.700000762939453,
 8.850000381469727,    9.0, 9.149999618530273, 9.299999237060547,
 9.450000762939453, 9.600000381469727,   9.75, 9.899999618530273,
 10.049999237060547, 10.200000762939453, 10.350000381469727,   10.5,
 10.649999618530273, 10.799999237060547, 10.950000762939453,
 11.100000381469727,  11.25, 11.399999618530273, 11.549999237060547],
  [11.700000762939453, 11.850000381469727,   12.0, 12.15000057220459,
 12.299999237060547, 12.450000762939453, 12.59999942779541,  12.75,
 12.90000057220459, 13.049999237060547, 13.200000762939453,
 13.34999942779541,   13.5, 13.65000057220459, 13.799999237060547,
 13.950000762939453, 14.09999942779541,  14.25, 14.40000057220459,
 14.549999237060547, 14.700000762939453, 14.84999942779541,   15.0,
 15.15000057220459, 15.299999237060547, 15.450000762939453],
  [15.59999942779541,  15.75, 15.90000057220459, 16.049999237060547,
 16.200000762939453, 16.349998474121094,   16.5, 16.650001525878906,
 16.799999237060547, 16.950000762939453, 17.099998474121094,  17.25,
 17.400001525878906, 17.549999237060547, 17.700000762939453,
 17.849998474121094,   18.0, 18.150001525878906, 18.299999237060547,
 18.450000762939453, 18.599998474121094,  18.75, 18.900001525878906,
 19.049999237060547, 19.200000762939453, 19.349998474121094],
  [  19.5, 19.650001525878906, 19.799999237060547, 19.950000762939453,
 20.099998474121094,  20.25, 20.400001525878906, 20.549999237060547,
 20.700000762939453, 20.849998474121094,   21.0, 21.150001525878906,
 21.299999237060547, 21.450000762939453, 21.599998474121094,  21.75,
 21.900001525878906, 22.049999237060547, 22.200000762939453,
 22.349998474121094,   22.5, 22.650001525878906, 22.799999237060547,
 22.950000762939453, 23.099998474121094,  23.25],
  [23.400001525878906, 23.549999237060547, 23.700000762939453,
 23.849998474121094,   24.0, 24.150001525878906, 24.30000114440918,
 24.44999885559082, 24.599998474121094,  24.75, 24.900001525878906,
 25.05000114440918, 25.19999885559082, 25.349998474121094,   25.5,
 25.650001525878906, 25.80000114440918, 25.94999885559082,
 26.099998474121094,  26.25, 26.400001525878906, 26.55000114440918,
 26.69999885559082, 26.849998474121094,   27.0, 27.150001525878906],
  [27.30000114440918, 27.44999885559082, 27.599998474121094,  27.75,
 27.900001525878906, 28.05000114440918, 28.19999885559082,
 28.349998474121094,   28.5, 28.650001525878906, 28.80000114440918,
 28.94999885559082, 29.099998474121094,  29.25, 29.400001525878906,
 29.55000114440918, 29.69999885559082, 29.849998474121094,   30.0,
 30.150001525878906, 30.30000114440918, 30.44999885559082,
 30.599998474121094,  30.75, 30.900001525878906, 31.05000114440918],
  [31.19999885559082, 31.349998474121094,   31.5, 31.650001525878906,
 31.80000114440918, 31.94999885559082, 32.099998474121094,  32.25,
 32.400001525878906, 32.55000305175781, 32.69999694824219,
 32.849998474121094,   33.0, 33.150001525878906, 33.30000305175781,
 33.44999694824219, 33.599998474121094,  33.75, 33.900001525878906,
 34.05000305175781, 34.19999694824219, 34.349998474121094,   34.5,
 34.650001525878906, 34.80000305175781, 34.94999694824219],
  [35.099998474121094,  35.25, 35.400001525878906, 35.55000305175781,
 35.69999694824219, 35.849998474121094,   36.0, 36.150001525878906,
 36.30000305175781, 36.44999694824219, 36.599998474121094,  36.75,
 36.900001525878906, 37.05000305175781, 37.19999694824219,
 37.349998474121094,   37.5, 37.650001525878906, 37.80000305175781,
 37.94999694824219, 38.099998474121094,  38.25, 38.400001525878906,
 38.55000305175781, 38.69999694824219, 38.849998474121094],
  [  39.0, 39.150001525878906, 39.30000305175781, 39.44999694824219,
 39.599998474121094,  39.75, 39.900001525878906, 40.05000305175781,
 40.19999694824219, 40.349998474121094,   40.5, 40.650001525878906,
 40.80000305175781, 40.94999694824219, 41.099998474121094,  41.25,
 41.400001525878906, 41.55000305175781, 41.69999694824219,
 41.849998474121094,   42.0, 42.150001525878906, 42.30000305175781,
 42.44999694824219, 42.599998474121094,  42.75],
  [42.900001525878906, 43.05000305175781, 43.19999694824219,
 43.349998474121094,   43.5, 43.650001525878906, 43.80000305175781,
 43.94999694824219, 44.099998474121094,  44.25, 44.400001525878906,
 44.55000305175781, 44.69999694824219, 44.849998474121094,   45.0,
 45.150001525878906, 45.30000305175781, 45.44999694824219,
 45.599998474121094,  45.75, 45.900001525878906, 46.05000305175781,
 46.19999694824219, 46.349998474121094,   46.5, 46.650001525878906],
  [46.80000305175781, 46.94999694824219, 47.099998474121094,  47.25,
 47.400001525878906, 47.55000305175781, 47.69999694824219,
 47.849998474121094,   48.0, 48.14999771118164, 48.30000305175781,
 48.44999694824219, 48.60000228881836,  48.75, 48.89999771118164,
 49.05000305175781, 49.19999694824219, 49.35000228881836,   49.5,
 49.64999771118164, 49.80000305175781, 49.94999694824219,
 50.10000228881836,  50.25, 50.39999771118164, 50.55000305175781]
]>
