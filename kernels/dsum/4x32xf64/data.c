#define M 4
#define N 32

const double X[M * N] = {
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
-396.85036665
};


const double Y[M * N] = {
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
-936.32214094,
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
-566.2060312 ,
 326.1564062 ,
 -473.35524653,
-958.69800107,
 516.75730767,
-359.96569836,
-233.07221166,
  176.63422711,
 662.09691047,
 257.96368718,
 745.30131089,
-452.91593037,
  596.09366783,
-628.72811139,
 905.58331394,
 374.97655278,
-568.98464577,
  894.74118098,
 461.71161354,
-492.11671481,
-573.37604527,
  36.40142786,
 -948.67456389,
-585.05984912,
-150.6290625 ,
-251.66003933,
 -72.84915127,
 -444.74258741,
 173.56869292,
 727.71121185,
-764.93628808,
  34.75821431,
 -735.86378731,
 433.71936239,
-207.88059439,
 130.84262372,
-633.44032757,
 -710.30448131,
 -23.8874387 ,
-288.7745243 ,
 880.86389051,
 530.65050761,
  497.3272397 ,
 807.43947949,
-833.15512912
};


const double G[M * N] = {
4.17974083e+02,
 1.05339472e+01,
 4.41557610e+02,
-5.26962321e+01,
 -8.81742273e+02,
-1.11647122e+02,
 1.51042439e+01,
 9.65291524e+02,
  1.07597602e+03,
 7.32846774e+01,
 8.87656616e+02,
-7.93732896e+01,
  9.29182314e+02,
 5.86317017e+02,
-9.86198033e+02,
-4.18946906e+01,
 -3.47175227e+02,
 1.07301686e+03,
-2.43232723e+02,
 1.57898952e+03,
  1.38571928e+03,
 1.59601114e+03,
-7.78144666e+02,
 1.29731047e+03,
 -1.43846528e+03,
 5.10961171e+02,
-1.46565346e+03,
 1.58535429e+03,
  6.58334561e+02,
-3.24746428e+01,
-6.56522181e+02,
-3.13198630e+02,
  3.07158211e+02,
 4.39532631e+01,
-5.18309200e+02,
 9.68035646e+02,
  1.17523446e+03,
 9.45474679e+02,
-8.90756746e+01,
 8.35967272e+01,
  1.78996926e+02,
-7.82676738e+02,
 4.37335604e+02,
-1.77087308e+03,
 -2.66473519e+02,
-6.21680672e+02,
 8.16052886e+00,
-1.29429803e+03,
 -6.78439937e+02,
 5.83584129e+02,
 5.49222345e+02,
-1.05911911e+03,
  3.06135989e+02,
-5.52953576e+02,
-4.27789311e+02,
-1.20159532e+03,
  1.17464465e+03,
-2.65484883e+02,
 3.88715176e+00,
-3.31328863e+02,
 -2.21816774e+02,
-1.15535973e+03,
 1.09101303e+02,
-1.30394660e+03,
 -1.23444926e+03,
 6.26195121e+02,
 1.12108805e+03,
-8.24879831e+02,
  1.30719071e+02,
-1.29909022e+03,
 6.89772507e+01,
-1.93864346e+02,
  5.77113940e+02,
 6.02378017e+02,
 2.34030837e+02,
-1.56241706e+03,
 -1.38502862e+03,
-1.62510761e+03,
-4.89340580e+01,
-8.55150873e+02,
 -2.90875219e+02,
 6.21868575e+02,
 1.08972887e+02,
-1.81261792e+02,
  4.59359315e+02,
-9.42576265e+02,
-9.12201894e+02,
-2.95361671e+02,
 -2.08072707e+02,
 6.25520183e+02,
-1.86227868e+02,
 9.96917670e+02,
 -4.78440588e+02,
 1.17795572e+03,
-8.74103744e+02,
-3.75236082e+01,
 -4.55702242e+02,
-5.42015937e+01,
 1.03285661e+03,
-1.55959369e+03,
  1.25037425e+03,
 1.72755992e+00,
-2.17286706e+01,
 3.51001045e+02,
 -4.66092285e+02,
-7.96359895e+02,
-4.00975987e+02,
-6.12525092e+00,
 -8.05496774e+02,
 8.32648872e+02,
-5.50491830e+02,
 8.66386038e+02,
  1.12666976e+03,
-1.17006239e+03,
 6.62353854e+02,
-9.42852306e+02,
  1.19592576e+03,
-4.53348491e+01,
 8.94313347e+02,
-2.48377147e+02,
 -2.59795922e+02,
-2.12386748e+01,
 6.23392745e+02,
 1.16884429e+03,
  3.78360605e+02,
 7.10113668e+02,
-1.54174124e+02,
-1.23000550e+03
};

