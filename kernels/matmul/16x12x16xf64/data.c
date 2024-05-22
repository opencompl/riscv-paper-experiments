#define M 16
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
-580.31250205
};


const double Y[K * N] = {
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
 151.50232409
};


const double G_IN[M * N] = {
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
-399.94216105
};


const double G_OUT[M * N] = {
-6.97088586e+05,
-2.56196306e+05,
-1.09191243e+06,
-7.82321996e+05,
  3.08987892e+05,
-9.24446807e+05,
 2.60055213e+05,
 7.06182529e+05,
 -1.85125810e+06,
-3.77068149e+05,
-3.60878594e+05,
 3.14337543e+04,
 -5.38780534e+05,
 1.84383272e+05,
 1.32603666e+06,
 1.16321852e+06,
 -8.03793090e+05,
 2.16985423e+05,
-1.91206380e+06,
-3.29956579e+05,
  5.67024402e+05,
-8.33881094e+05,
 9.20142384e+05,
-3.40275924e+05,
 -1.14848573e+06,
 1.18151051e+05,
 1.57239889e+06,
-3.69392459e+05,
  4.23171038e+05,
 1.00300582e+06,
 6.31070091e+05,
 2.28117332e+05,
  1.85430021e+06,
-2.25775567e+06,
-3.49050349e+05,
-1.16950519e+06,
  5.81066685e+05,
 5.06665531e+04,
 1.11442384e+06,
-1.32468523e+06,
  3.93700194e+05,
-1.25134530e+06,
 3.76840117e+04,
 1.04797183e+06,
  5.25294356e+05,
 1.43804189e+06,
 8.36659764e+05,
 1.10759536e+05,
 -1.08092974e+06,
 7.02267556e+05,
 4.57763522e+05,
-6.48927281e+05,
  4.27807230e+05,
 8.68819821e+05,
-4.34609012e+05,
-7.85502543e+05,
 -3.34328754e+04,
-1.57537629e+06,
-6.62028089e+05,
 1.05957239e+06,
 -6.54719857e+05,
 8.65329839e+05,
-1.92755855e+06,
-1.09451140e+06,
  2.15467722e+05,
-9.89400230e+05,
 1.01690667e+06,
 3.32769350e+05,
 -1.95568879e+06,
 3.49713530e+05,
-5.97488585e+05,
 1.80219292e+06,
  1.33949383e+06,
-2.55779480e+05,
-1.57936303e+06,
 9.58880558e+05,
 -1.55940588e+06,
-1.03211925e+05,
-7.64069069e+05,
 1.51310535e+06,
 -2.89428135e+05,
-4.21027817e+05,
-1.69373548e+06,
 1.54478397e+06,
 -3.52595070e+05,
 1.42165174e+06,
 1.33895438e+06,
 1.37562439e+06,
 -2.84067073e+05,
 1.46509524e+06,
 2.15409581e+05,
 9.98031633e+05,
  1.20312362e+06,
-4.60989863e+05,
-1.73083733e+06,
-1.69803716e+05,
 -5.28394142e+05,
 2.11256156e+06,
 1.86810110e+06,
 5.17588054e+05,
 -6.72197122e+05,
 1.62317289e+06,
-1.73264177e+06,
-9.29142698e+05,
  2.20213114e+06,
-6.71994074e+05,
-7.30313937e+05,
-6.77756142e+05,
 -1.15587820e+06,
-1.18787814e+06,
-2.56624396e+06,
 7.80428620e+05,
 -1.38372911e+06,
 1.13151438e+06,
-4.31041874e+05,
 1.66832070e+06,
  1.60756777e+05,
 5.79908875e+05,
 5.68222629e+05,
 3.28223236e+05,
  8.69996544e+05,
-8.26281506e+05,
 5.02026794e+05,
-3.10410152e+06,
 -1.48873701e+06,
-1.44482247e+06,
-1.27095757e+05,
 1.04375117e+05,
 -1.05256692e+06,
 4.08011409e+05,
-3.29231588e+05,
-6.86453875e+05,
  7.33887650e+04,
-1.02112216e+06,
 4.96881889e+04,
-1.48467877e+06,
  4.42873672e+05,
-5.71749159e+05,
 5.18829813e+05,
-1.58438057e+06,
 -3.24309733e+05,
-8.13937592e+05,
-2.12321126e+05,
 2.29110395e+05,
  9.68971061e+05,
-8.61401155e+05,
 7.39911894e+05,
-1.98457931e+06,
  3.18321382e+03,
-1.72505154e+06,
-9.22949583e+05,
 5.87573661e+05,
 -1.12288848e+06,
 8.74459147e+05,
-3.54196052e+04,
 3.10915911e+06,
  1.68190328e+06,
 2.45384507e+06,
 7.91981508e+05,
-1.30382719e+05,
 -7.45738492e+05,
 9.43672587e+05,
 4.61822556e+05,
 7.64633713e+05,
 -5.75842162e+04,
 1.38437001e+06,
-6.71156604e+05,
 8.95617397e+05,
  2.87717629e+03,
-6.66960243e+05,
-1.84344802e+06,
-7.87490875e+05,
 -1.42597591e+06,
-1.29604434e+06,
 1.15026818e+05,
 8.78436436e+05,
  8.26944173e+05,
-7.36388399e+05,
-1.14035915e+06,
-3.66846424e+05,
  9.48119136e+05,
 9.85246102e+05,
 7.86911751e+05,
-1.19737400e+05,
  1.32710386e+05,
 9.52050274e+05,
-3.72079696e+05,
 1.13042246e+06,
  4.14914423e+05,
 3.54257734e+05,
 1.25830511e+06,
 3.12249501e+05,
  1.21359985e+06,
 5.94130653e+05,
 7.90448640e+05,
-1.84929497e+05,
  9.40314094e+05,
-4.00442001e+05,
-6.66955327e+05,
-5.94864968e+05,
 -1.07617387e+04,
 7.10216288e+05,
 1.01155369e+05,
-1.46869598e+06,
 -6.38936368e+05,
-8.15667357e+05,
 3.18630060e+06,
 2.17901820e+05,
 -1.82255705e+06,
-1.47224155e+05,
-8.13732453e+05,
-1.53340089e+06,
 -8.45494945e+05,
-1.50262171e+06,
-4.99984640e+04,
-8.26892726e+05,
 -1.66115341e+04,
-1.59024125e+06,
 6.77058154e+04,
-5.31468268e+05,
 -2.70957039e+06,
 6.70940078e+05,
 2.58845871e+05,
 9.94324588e+05,
 -1.74679823e+06,
-2.58848333e+05,
-1.44228518e+05,
 6.50351056e+05,
 -1.96035256e+06,
-6.81683677e+05,
 3.46224558e+05,
-9.21423416e+05,
  7.20920968e+05,
-1.00009383e+06,
 7.48504417e+05,
-5.79614387e+05,
  3.41979489e+05,
 3.30660168e+05,
-2.95710122e+06,
-2.02879119e+06,
 -5.27839919e+05,
-5.05956587e+04,
-2.35806788e+05,
-8.10741312e+04,
 -9.55132100e+04,
-2.02315551e+05,
 7.80961154e+04,
 1.93819735e+06,
 -1.06238638e+05,
-3.85298109e+05,
-2.05110868e+05,
 3.30715832e+05,
 -1.45143959e+06,
 2.66101709e+05,
-1.56418435e+05,
 1.89456168e+06
};

