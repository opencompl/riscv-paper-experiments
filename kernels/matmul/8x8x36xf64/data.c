#define M 8
#define K 8
#define N 36

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
-723.6340973
};


const double Y[K * N] = {
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
-929.27512849
};


const double G_IN[M * N] = {
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
 325.00914307,
 -507.87363002,
 331.71823512,
  34.6170344 ,
-151.82202313,
 109.37561732,
 -425.89696016,
 413.14941255,
-170.28626133,
-278.90887903,
 657.31382911,
  849.93382391,
-907.98537823,
-534.74601434,
-302.96126101,
 629.93295874,
  970.98285529,
 937.94340934,
 809.8966911 ,
-406.88746987,
 984.02248683,
 -501.15991789,
-788.18769024,
 901.90522211,
-533.15948906,
 379.53653016,
 -883.28728204,
 461.41819825,
 763.44042467,
-455.12620907,
-241.88620785,
 -251.40763336,
 497.57651508,
-524.38551492,
-656.2938019 ,
-101.41670262,
 -391.06318525,
 678.37824452,
-524.51634797,
   4.77891498,
 885.1671994 ,
  267.99539549,
 734.57881092,
 880.41937871,
 501.52972377,
 399.15012045,
  935.93113321,
 988.8015793 ,
 -96.35663466,
-858.26044363,
-414.41193712,
 -695.29058862,
-165.02725041,
-737.42134305,
 208.23560804,
-234.38388168,
  790.77176858,
 935.5893436 ,
  93.76980334,
-450.35286026,
 184.46083752,
  793.52231645,
-186.53330833,
 104.15655338,
-456.69446479,
 -89.1117011 ,
 -196.57292924,
-503.17306983,
  11.73276765,
-379.23834804,
-253.93027224,
   49.94088451,
 501.19004586,
-332.98506842,
 848.31753324,
 724.63709367,
 -902.61940805,
-492.71495149,
-107.72897468,
-790.74422252,
-303.04802193,
  480.19505124,
 361.02896229,
 244.76885713,
 421.05680544,
-590.15262608,
 -316.60377027,
 352.48496455,
 758.46952606,
  87.35610766,
-434.60069811,
 -939.52948399,
 420.67365795,
-984.23179298,
-254.64186036,
  61.07442913,
  844.22292353,
-821.01090993,
-188.11535606,
-951.37360058,
-314.77803132,
  244.46211768,
-441.86410354,
-580.50010069,
-768.59353335,
 154.28048804,
  390.54001181,
 343.91428119,
 897.72204144,
-994.59357221,
 294.39330779,
  200.7844742 ,
 177.47921994,
 925.54063968,
-966.25665326,
 392.9648614 ,
  627.3572994 ,
  19.61439324,
-332.07026081,
 581.68032645,
-805.51414874,
 -115.92872454,
  39.90474914,
 387.91282187,
-818.22853594,
-544.48099692,
 -179.39687462,
 246.58934604,
 773.92156243,
 237.65233648,
-733.07705813,
  961.16026557,
 743.57146951,
   5.44152229,
 844.69596359,
  82.76158751,
  846.61213578,
 659.79473721,
 936.57282059,
 839.56562156,
-927.93236514,
 -650.45599168,
-221.7306458 ,
 904.28539459,
-399.94216105,
-679.06471222,
  772.60933217,
-107.21116903,
 815.75118871,
-679.53906736,
 322.23502302,
 -119.47249434,
-847.02646194,
 392.92628931,
-505.20248892,
-920.76895484,
 -880.1114035 ,
-877.84292587,
 815.46591497,
 479.76783566,
 796.12471443,
  345.16462259,
  57.87985806,
-391.10727131,
 995.92450266,
-275.62188212,
  -58.70210157,
-243.50965015,
 959.05385867,
-650.68322921,
-344.02399818,
  360.69733203,
-873.58476332,
 214.49874802,
 -44.70699425,
-432.00004648,
 -523.17343815,
  29.0254866 ,
-264.14483893,
 -86.96021747,
-325.04523647,
  940.98738719,
-733.12113651,
-806.39209364,
-313.21654242,
 182.05380174,
  318.3529437 ,
-205.48650566,
 998.55598784,
-296.21400761,
 442.81333592,
  275.16538906,
 626.10772649,
 952.45132691,
 779.58731289,
 529.12394872,
  396.49695564,
-329.00366065,
-704.62884359,
-874.72799388,
-516.1965916 ,
 -135.43703764,
  43.99254726,
 546.16710811,
 917.48184611,
-765.35903923,
 -785.99171961,
 179.38944603,
 490.79614789
};


const double G_OUT[M * N] = {
1.13038983e+05,
-4.26071551e+05,
 8.04398205e+05,
 6.20353425e+05,
 -5.93878486e+05,
-4.15246556e+05,
-5.72343102e+05,
 5.73013693e+03,
 -2.41936917e+05,
 5.92947947e+05,
 3.79399573e+05,
 3.86582035e+05,
 -1.33277506e+05,
-1.98240166e+05,
-7.11593444e+04,
 3.12619236e+05,
 -4.54227839e+05,
-8.62867789e+04,
 4.97976741e+04,
 9.51478371e+05,
 -2.39083708e+05,
-1.06738245e+05,
 5.28667768e+05,
-2.47606981e+05,
 -4.57749469e+05,
-1.59226591e+05,
-4.05263789e+04,
-3.58707826e+05,
  5.85120891e+05,
-2.17439848e+05,
-2.88894902e+05,
-2.17145725e+05,
  8.52791283e+04,
 6.33834854e+05,
 4.21292857e+05,
-5.43770114e+05,
  2.71928011e+05,
-7.75579602e+05,
 1.44238303e+05,
-1.23064003e+06,
  1.26997047e+06,
 2.37919808e+05,
 3.20810517e+05,
 1.49627849e+06,
  2.13191001e+06,
 4.60044346e+05,
 6.44962080e+05,
-8.76070407e+05,
 -2.66871637e+05,
 9.61028860e+05,
 3.02576926e+05,
-4.95135507e+05,
  1.26254429e+04,
-1.58781340e+06,
-3.48097612e+06,
 4.46912364e+04,
  4.51589183e+05,
-1.72998689e+04,
-5.47067159e+05,
-1.61050058e+05,
  1.03122411e+04,
 1.47017363e+06,
 1.52586758e+06,
 2.96172986e+06,
 -1.41639063e+06,
 3.24979072e+06,
-2.04216695e+06,
 9.58591621e+05,
  1.98769187e+06,
-8.78483252e+05,
 3.13917782e+05,
 2.54914044e+05,
  7.29814216e+05,
 4.94240432e+04,
 1.70425928e+06,
 3.12015819e+05,
 -1.11747504e+06,
 5.35981628e+05,
-2.22438426e+06,
 7.01853629e+05,
 -1.73259255e+06,
 8.11555751e+05,
 1.80755557e+04,
 1.83479718e+06,
  1.58009019e+06,
 1.91066042e+06,
 2.31130519e+05,
 1.82480986e+06,
 -5.25842257e+05,
 6.76718290e+05,
 7.95305820e+05,
 5.41525845e+04,
  7.76569312e+05,
 1.78595410e+06,
 2.05215396e+05,
-1.58452972e+05,
 -1.04840222e+06,
-2.32156071e+06,
-6.75660534e+05,
-4.10539663e+05,
  1.03734391e+06,
 7.51906895e+04,
-9.30375371e+05,
 4.24664099e+05,
  2.77931729e+05,
-1.48668359e+05,
 7.69328377e+04,
-2.31583293e+05,
 -3.98930613e+04,
-1.19877761e+06,
 2.51921598e+05,
 1.27150286e+06,
 -1.46998439e+06,
 1.52022128e+06,
-1.15501790e+06,
-1.62853948e+06,
 -2.28094985e+06,
-2.56015922e+05,
 5.07469905e+05,
 5.60541219e+05,
  3.62597155e+05,
 1.21724370e+05,
 5.12482805e+05,
 8.32144161e+05,
  1.33564255e+06,
-2.71944661e+05,
 1.27655590e+06,
-1.49987633e+06,
 -1.63788753e+06,
 5.77111995e+05,
 1.08449381e+06,
 1.38901105e+06,
 -8.28942660e+05,
-1.08327517e+06,
-9.81456577e+05,
-1.22006370e+06,
 -2.00626619e+05,
-7.70819506e+05,
 7.04734663e+05,
 4.85305115e+04,
 -1.14747057e+06,
 1.07348938e+06,
-2.19389604e+05,
 9.30770461e+05,
 -4.89677688e+05,
 2.28964855e+05,
 5.75413566e+05,
-7.74666763e+05,
 -1.49529947e+06,
-4.56228273e+05,
 4.10668740e+05,
-8.10230717e+05,
 -1.04081226e+06,
 4.99721020e+04,
 8.77868589e+05,
-1.30375575e+06,
  3.81194889e+05,
-1.32664881e+06,
 7.15899957e+05,
-8.70795477e+05,
 -4.04121639e+05,
 5.28590585e+05,
 1.75713961e+06,
 3.05628405e+05,
  1.37513760e+05,
 7.49147499e+05,
-3.27327248e+04,
-6.14600519e+04,
 -9.96811797e+05,
-9.87353279e+05,
-1.32453022e+06,
-1.80128994e+06,
 -4.09088475e+05,
-1.66320702e+06,
 1.22036961e+06,
-3.63265904e+05,
 -1.10166656e+06,
 3.15299414e+04,
 4.85437697e+05,
 1.67991903e+05,
  1.24235686e+06,
 8.04046264e+05,
-9.36007097e+05,
 3.63305347e+05,
  8.43140041e+05,
 1.38639733e+05,
-1.01776208e+06,
 1.92530195e+06,
  1.05085955e+06,
-2.29954216e+05,
-3.58353993e+05,
 1.03116488e+06,
 -4.52827863e+05,
 1.30209893e+06,
 3.20110452e+05,
 3.21213531e+05,
  7.17370365e+04,
-2.32896538e+05,
-1.13607719e+06,
-2.13351305e+05,
  1.00130582e+06,
-3.77107912e+05,
-8.72551913e+05,
 5.58345147e+05,
  6.25744949e+05,
 5.60971821e+05,
 1.79218656e+06,
 1.76091543e+06,
 -2.71758561e+04,
 1.35185409e+06,
-7.55213792e+05,
 1.70922197e+06,
  1.97713978e+06,
 5.64744237e+05,
-8.16166528e+05,
 9.79281239e+05,
  2.96551975e+05,
 8.39851611e+05,
-1.66616122e+05,
 3.04397696e+05,
  1.40975234e+06,
 5.80010537e+05,
-1.13544457e+06,
 3.06407340e+05,
 -4.81332850e+05,
-1.02328670e+06,
-8.44430791e+05,
 1.80114124e+06,
  9.21800241e+04,
 1.62025376e+06,
-8.86664516e+05,
 1.26240992e+06,
  6.42453368e+05,
 9.29757773e+05,
 2.40785685e+05,
-2.23003072e+06,
  4.47344213e+05,
-6.83543919e+04,
-4.08297492e+05,
 2.00645453e+05,
  1.12046222e+06,
-5.09167275e+05,
-2.82232265e+05,
 4.94075701e+05,
 -2.92780443e+05,
 3.42583779e+05,
-3.63864130e+05,
 4.39251116e+05,
  7.08954290e+05,
-8.89600368e+05,
-8.90406058e+05,
-1.86188805e+05,
 -4.66923094e+05,
 3.74191714e+05,
-1.57519870e+06,
-1.64559515e+05,
  1.12748226e+06,
-8.75063428e+04,
 1.82434705e+06,
-4.29972397e+05,
  1.04143418e+06,
-6.12121119e+05,
-9.23472958e+05,
-7.25170970e+05,
 -5.45191978e+05,
-8.76601096e+05,
-3.66178157e+05,
-9.45521063e+05,
  5.45303082e+05,
-9.37934324e+03,
-9.86330570e+04,
-2.17044595e+05,
 -1.74784816e+05,
-1.01391588e+06,
-2.23515809e+05,
 2.82734094e+02,
  1.15736737e+06,
 1.35576207e+06,
 2.68421679e+05,
 2.11786429e+05,
 -1.24183175e+05,
-2.71949162e+05,
 8.08761555e+05,
-5.37142081e+05,
 -6.91751390e+05,
-4.74316497e+05,
-3.83922316e+05,
 1.46179256e+05
};

