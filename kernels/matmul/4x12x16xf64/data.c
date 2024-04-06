#define M 4
#define K 12
#define N 16

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
-742.14740469
};


const double Y[K * N] = {
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
 173.56869292
};


const double G_IN[M * N] = {
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
 -833.15512912,
 104.38493984,
 168.95213791,
 923.87275709,
-415.70494641,
 -518.34244017,
-799.41211547,
-967.14074082,
 859.05863358,
 339.83309318,
  570.30582405,
-436.53978849,
 172.82033237,
-872.08946776,
 -28.74480813,
  954.99027949,
 753.01049063,
-323.68209633,
 923.14030908,
-536.59674706,
  898.63764483,
 882.75540941,
 598.4051747 ,
 260.89587373,
 748.57593325,
 -413.95943098,
 697.88711063,
 235.75338384,
-973.52628448,
-305.53296414,
 -703.7182781 ,
 963.65877964,
 -43.25938592,
  -5.217269  ,
 278.9450328 ,
 -262.83078774,
-726.19945663,
 644.23546639,
-620.30417619,
  22.63796509,
 -551.36594205,
-804.31103101,
 724.38303484,
 945.83897805,
 921.66931613,
  813.11099844,
 548.0946654 ,
-333.70969594,
-837.79722002,
-185.51765717,
 -535.53171566,
-735.02473048,
-893.14563643,
 451.18872842,
-977.14508275,
  541.16149701,
-706.1067092 ,
-840.95583483,
-820.79393152,
 344.09561471,
 -509.26558029,
-158.92106664,
 114.73758265,
 721.10234766,
 454.08852542,
 -459.34418952,
-737.03440142,
-889.25135916,
-396.80273104,
-475.76370152,
  -87.7188664 ,
 366.5626711 ,
 391.25089128,
-432.96230684,
-240.1460882 ,
 -637.69807653,
 577.09102461,
-886.30384713,
 393.99448345,
 557.39079188,
  554.8151237 ,
-481.15487131,
-252.37372413,
 175.19927039,
-454.35619515,
 -258.29440156,
-605.89143963,
 -80.28823249,
-910.77539749,
 599.59176914,
 -846.08710603,
  37.67029766,
-386.37980091,
 155.08589766,
 918.86668167,
  291.14048891,
-929.27512849,
-139.19512098,
  20.03370464,
  72.35498941,
  362.78502121,
-444.80780454,
-742.27886907,
-214.64864691,
 912.81144559,
 -625.7382165 ,
 807.96790986,
  87.61190015,
 -86.17715671,
 764.08282046,
  -82.79207646,
 448.33527322,
-201.94935659,
 808.0887858 ,
 380.05004038,
  399.2441085 ,
-344.55919689,
 513.55728547,
 272.12211089,
-519.95945324,
 -678.92235503,
 592.78294903,
 918.33320607,
 -83.72234548,
 181.96833065,
  715.44528839,
 -85.55309329,
 903.74895367,
 151.50232409,
 641.5342414 ,
  817.68743683,
 631.04763754,
-681.1710731 ,
 257.79687812,
-203.13148276,
 -874.57409595,
-151.93549622,
-482.63186622,
 698.07661686,
-933.39074691,
  917.96544373,
-289.26230306,
-286.58621919,
-967.34299463,
-629.53534953,
 -197.48099839,
 858.58283461,
-800.77013956,
 890.60306696,
 738.97706109,
  -91.67520618,
-346.59823646,
-534.51174144,
 228.92941295,
-933.85081705,
 -968.78787111,
-142.408555  ,
-863.85185205,
-496.11802351,
-557.67816931,
 -493.61761255,
-737.88953757,
-975.9275542 ,
-769.03140572,
 236.96051903,
  948.51242564,
 980.69000312,
-181.89180925,
-674.09114791,
 277.52351473,
  -19.3893069 ,
 978.81955457,
-869.3915857 ,
 566.46887663,
-423.20300534,
 -517.16275985,
 325.00914307
};


const double G_OUT[M * N] = {
-225151.3790047 ,
  656612.7221991 ,
 1452005.99560603,
 -1136188.14920533,
  555352.35729997,
 -182259.77583301,
  -586861.70307324,
 -681316.56844304,
 1530787.45882604,
  -293208.60299376,
  410010.79363591,
 -540304.80211218,
    37580.60900053,
 -830716.42683067,
 -210542.23521479,
  -661356.86169328,
 -964136.64987654,
 2744876.95869463,
  1021667.61925375,
 -285341.64672839,
 -465160.29880299,
   877893.81654906,
-2031932.37234382,
-1200134.85810068,
  1423630.74021698,
 -968353.88148884,
 -922800.38734061,
 -2247384.4210385 ,
  908887.58610366,
-3863790.9870966 ,
  1118167.91382078,
-1321199.93755898,
  139397.77510766,
 -1289573.21321096,
 1060663.41769879,
 -774636.63891002,
    23097.36057492,
  779287.59013259,
 1572715.09316152,
   782267.26871428,
  269602.80782245,
 -527926.4430359 ,
   625825.96274646,
-1534727.34446838,
 -806595.32403899,
  -479595.48665672,
  641258.48436566,
  864319.4342378 ,
  -635641.46859112,
 -756843.5279685 ,
-1811972.12443327,
   -39929.09845668,
-1427568.75013204,
-1332568.45396413,
  1324700.71275198,
 -238298.66300017,
 -230282.87827965,
  2434559.84622266,
 -515075.34594094,
  584562.45334428,
  -529441.06663733,
  437607.84611438,
  -94218.54075811,
 -1192359.94637439
};

