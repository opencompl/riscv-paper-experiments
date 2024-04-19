#define M 8
#define K 4
#define N 28

const double X[M * K] = {
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
 548.46737887
};


const double Y[K * N] = {
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
 783.84671003
};


const double G_IN[M * N] = {
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


const double G_OUT[M * N] = {
-2.02467729e+05,
-1.30955655e+05,
 3.45597619e+04,
-1.85087577e+05,
 -3.50192120e+05,
-1.00413169e+03,
 3.58257491e+05,
-4.15671288e+05,
  2.85347889e+05,
-5.38116485e+05,
 4.97595719e+05,
-3.52071930e+05,
  5.44786040e+05,
-8.66267614e+03,
 2.67263904e+05,
-2.91905307e+05,
 -3.91709122e+05,
-3.58439851e+05,
-1.11372496e+05,
-2.94157229e+05,
 -1.61799834e+05,
 6.21075132e+04,
-4.26433062e+05,
 2.29621000e+05,
  2.40412463e+05,
-3.57154783e+05,
 1.30906327e+05,
-3.71599274e+05,
  3.92637168e+05,
-2.28086530e+05,
 8.81691528e+05,
 1.28489883e+04,
  2.33616999e+05,
-1.64249205e+05,
 8.19111975e+05,
 1.40908951e+04,
  9.91960817e+04,
 7.00554347e+04,
-6.17891001e+05,
-7.12928937e+04,
  4.33913757e+05,
-2.62474081e+05,
 3.54296773e+05,
-3.82612272e+05,
 -5.78905715e+05,
-5.15147150e+05,
-5.37414488e+04,
-7.93834003e+04,
 -6.97532317e+04,
 1.98544244e+05,
 8.61102205e+04,
 2.17968213e+04,
  5.63735465e+05,
-2.18545795e+05,
-1.54990491e+05,
 4.81098179e+05,
  2.10343880e+05,
 8.18916713e+05,
-1.13295422e+06,
 6.04468117e+05,
 -5.42582678e+04,
 5.30661857e+05,
 4.80311841e+05,
 1.72016554e+05,
 -3.25974051e+05,
-4.76160812e+05,
 4.72664012e+05,
-1.40191726e+06,
  3.13018819e+05,
-2.50493294e+04,
-3.60603957e+05,
 5.77290485e+04,
 -5.76365025e+05,
-1.01381717e+04,
 3.40727135e+05,
 1.58703109e+05,
  6.76079868e+05,
-1.52074714e+05,
-3.80842161e+05,
-3.21591990e+05,
  5.31515783e+05,
-5.99852617e+05,
 2.85437221e+05,
-3.60151724e+05,
 -1.35219913e+06,
-1.51549700e+06,
-1.83961432e+05,
-1.18914933e+06,
 -2.26245898e+05,
-5.65027089e+05,
 2.75367622e+05,
-3.30601250e+05,
  5.14382333e+05,
-5.70155003e+04,
 1.09453962e+06,
 1.00450207e+06,
  2.87390565e+05,
 9.66247886e+05,
-2.69967936e+05,
-1.56089031e+06,
  6.13128787e+05,
-4.81208962e+05,
-6.01418678e+05,
-9.39832788e+05,
  1.75466854e+05,
-1.28413279e+06,
-9.81697565e+05,
-2.45648277e+05,
 -8.42113373e+05,
 9.97418356e+04,
-4.02106127e+05,
-1.23050547e+06,
  2.78970490e+05,
-5.17868973e+04,
 1.49461830e+06,
-2.35926094e+05,
 -6.95101135e+05,
-1.56417937e+05,
 1.61796912e+04,
-1.02436194e+06,
  7.02809229e+05,
-7.93013276e+05,
-9.09896241e+04,
-4.24941196e+04,
  7.49182489e+05,
-7.54571522e+05,
 1.31049952e+06,
 5.07853873e+05,
 -7.53814667e+05,
-4.57581639e+05,
-1.99987934e+05,
-1.74557928e+05,
 -1.37752263e+06,
 1.38014043e+06,
 1.45100035e+05,
 1.18998963e+06,
  6.03631890e+05,
-2.60071830e+05,
 3.49801842e+05,
 4.15140920e+05,
 -7.60974660e+04,
-3.10172886e+05,
-2.77887785e+05,
-1.75047537e+04,
  1.61019451e+05,
 3.49329287e+04,
 1.77788329e+06,
 7.63561962e+04,
  3.66544146e+04,
-4.10544473e+05,
 3.58302116e+05,
-1.02578810e+06,
  1.04211406e+06,
 2.52023732e+05,
-1.71966089e+05,
-1.41297942e+06,
 -9.83586021e+05,
-9.53493193e+05,
-4.52290362e+04,
-4.82952155e+05,
  8.43241036e+05,
-7.62321973e+05,
-9.00079058e+05,
-5.48427228e+05,
  7.87054677e+05,
-8.70459236e+05,
-1.56995518e+05,
-5.19464690e+05,
  4.45599574e+05,
-7.90429016e+05,
 1.76006669e+06,
-2.78495347e+05,
  5.84949395e+05,
-5.58273120e+05,
 6.13750204e+05,
 2.04949065e+05,
  1.44804708e+05,
 7.43936047e+05,
-1.35955763e+06,
 1.00760819e+06,
  4.34251534e+04,
-2.47147237e+05,
 4.50516023e+05,
-4.77365450e+05,
 -1.29684562e+05,
-4.71904974e+05,
-2.28141622e+05,
-6.10829872e+04,
 -3.20322439e+05,
 1.86261839e+05,
 5.46549665e+05,
 8.70443985e+03,
  2.24247590e+05,
 2.98801153e+05,
-4.97283616e+05,
 1.00772020e+06,
  4.59099969e+05,
-1.76170497e+05,
 4.94188478e+05,
 1.87318868e+05,
  7.07222461e+05,
-1.47249141e+05,
 6.27835451e+05,
 6.09731373e+05,
 -2.92638301e+05,
 7.01028083e+05,
-9.82570894e+05,
 2.21074842e+05,
 -1.39932876e+05,
-3.45464899e+04,
-1.99029003e+05,
-3.88544955e+05,
 -1.05233513e+05,
-1.75258405e+05,
 6.57866444e+04,
 1.56418599e+05,
  4.47137895e+05,
-2.63849645e+05,
 3.39980506e+05,
-4.96769477e+05,
  2.37766725e+05,
 1.04017509e+05,
-3.76759722e+05,
 6.43656749e+05
};

