#define N 1
#define C 1
#define H 6
#define W 6
#define F 1
#define NEW_H 4
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
  235.27099415
};


const double Y[F * C * 3 * 3] = {
224.19144544,
 233.86799375,
 887.49615703,
 363.64059821,
-280.98419885,
 -125.9360924 ,
 395.26239185,
-879.54905674,
 333.53343089
};


const double Z_IN[N * F * NEW_H * NEW_W] = {
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
 -682.06083271
};


const double Z_OUT[N * F * NEW_H * NEW_W] = {
-1058419.25425798,
 1093565.81050608,
  327923.67729844,
   726865.57988159,
  784891.66407336,
  490354.83342021,
   538490.62522267,
  512432.6025775 ,
-1443823.96072443,
   216742.32562533,
-2096968.52224767,
  605586.93859078,
   183129.71694307,
 1450539.08498059,
 -704663.30191902,
  1925738.21309223
};

