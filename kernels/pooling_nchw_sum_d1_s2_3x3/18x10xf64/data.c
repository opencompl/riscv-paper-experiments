#define N 1
#define C 1
#define H 18
#define W 10
#define NEW_H 8
#define NEW_W 4

const double X[N * C * H * W] = {
97.62700785,
 430.37873274,
 205.52675214,
  89.76636599,
-152.69040132,
  291.78822613,
-124.82557747,
 783.54600156,
 927.325521  ,
-233.11696235,
  583.45007617,
  57.78983951,
 136.08912219,
 851.19327659,
-857.9278836 ,
 -825.7414006 ,
-959.56320512,
 665.2396911 ,
 556.3135019 ,
 740.02429649,
  957.23668447,
 598.31712843,
 -77.04127549,
 561.05835257,
-763.45114826,
  279.84204266,
-713.29342518,
 889.3378341 ,
  43.6966435 ,
-170.67612002,
 -470.88877579,
 548.46737887,
 -87.69933557,
 136.86789774,
-962.42039913,
  235.27099415,
 224.19144544,
 233.86799375,
 887.49615703,
 363.64059821,
 -280.98419885,
-125.9360924 ,
 395.26239185,
-879.54905674,
 333.53343089,
  341.27573924,
-579.23487785,
-742.14740469,
-369.14329815,
-272.57845811,
  140.39354084,
-122.79697308,
 976.74767612,
-795.9103785 ,
-582.24648781,
 -677.38096423,
 306.21665093,
-493.41679492,
 -67.37845429,
-511.148816  ,
 -682.06083271,
-779.24971767,
 312.65917893,
-723.6340973 ,
-606.83527664,
 -262.54965868,
 641.9864597 ,
-805.79744841,
 675.889815  ,
-807.80318421,
  952.91893003,
 -62.6975967 ,
 953.52217638,
 209.69103949,
 478.5271588 ,
 -921.62441549,
-434.38607485,
-759.60687757,
-407.71960496,
-762.54456209,
 -364.03364121,
-171.47401097,
-871.7050073 ,
 384.94423874,
 133.20290841,
 -469.22101812,
  46.49610693,
-812.11897848,
 151.89299111,
 858.59239515,
 -362.8620951 ,
 334.82075993,
-736.40427519,
 432.65440824,
-421.18781411,
 -633.61727599,
 173.02586962,
-959.78490763,
 657.88005843,
-990.60904761,
  355.63307359,
-459.98405362,
 470.38804425,
 924.37709023,
-502.49371296,
  152.31466884,
 184.08386254,
 144.50381158,
-553.83673472,
 905.49802303,
 -105.74924276,
 692.81734494,
 398.95855064,
-405.12609829,
 627.5956394 ,
 -206.98851831,
 762.20639422,
 162.54574527,
 763.47072371,
 385.06318016,
  450.50855964,
   2.64876385,
 912.16726945,
 287.98039846,
-152.28990288,
  212.78642826,
-961.61360338,
-396.85036665,
 320.34707499,
-419.84478558,
  236.030858  ,
-142.46259811,
-729.05187156,
-403.43534809,
 139.9298214 ,
  181.7455225 ,
 148.6504977 ,
 306.40163971,
 304.20654   ,
-137.16312913,
  793.0931917 ,
-264.8762599 ,
-128.27014947,
 783.84671003,
 612.38797809,
  407.77716708,
-799.54622538,
 838.96522749,
 428.4825991 ,
 997.69401314,
 -701.10339068,
 736.25211474,
-675.01413065,
 231.11912857,
-752.3600343 ,
  696.01645864,
 614.63791745,
 138.20147723,
-185.63340555,
-861.66600909,
  394.85754629,
 -92.91463464,
 444.11119894,
 732.76465186,
 951.04301001,
  711.60668479,
-976.57183163,
-280.04387104,
 459.98112485,
-656.74064548,
   42.07321241,
-891.32402332,
-600.00695021,
-962.95641108,
 587.39540671,
 -552.15062388,
-309.29663861,
 856.16258693,
 408.82880385,
-936.32214094
};


const double Y_IN[NEW_H * NEW_W] = {
-670.611687  ,
 242.956803  ,
 154.45717721,
-524.21435725,
 868.42799585,
  227.93191193,
  71.26560605,
 179.81995271,
 460.24405903,
-376.11000904,
 -203.55787557,
-580.31250205,
-627.61398824,
 888.74477997,
 479.1015901 ,
  -19.08238276,
-545.17074405,
-491.28703646,
-883.94167935,
-131.16674888,
 -376.40823601,
 392.68697763,
-244.49632142,
-640.79264488,
-950.64254322,
 -865.50073707,
 358.785547  ,
 -92.60631089,
  73.15842222,
 793.34258608,
  980.67789479,
-566.2060312
};


const double Y_OUT[NEW_H * NEW_W] = {
2989.37406801,
   -7.4768392 ,
-3825.86277277,
 2067.77698539,
  1456.73390552,
-1343.43914214,
-1604.28619804,
 -125.22893205,
  -165.96502697,
-1569.9726192 ,
-1085.23498446,
-1433.02535269,
  -712.12052123,
  270.37231951,
-1394.40380994,
-1703.36361153,
 -1805.62120562,
 -186.22411969,
-1337.39640483,
 -967.8579206 ,
  2717.38830997,
 2561.55727829,
  115.60125573,
  424.85690756,
  1129.7877636 ,
 1323.26490544,
 -210.17231661,
  189.04338358,
   506.13548632,
 2199.62836308,
 1464.99112475,
  238.47301252
};

