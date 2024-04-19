#define M 8
#define K 8
#define N 44

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
-493.61761255
};


const double G_IN[M * N] = {
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
 490.79614789,
 696.30076069,
  871.66416043,
 966.85248452,
-200.39661555,
-239.32963294,
-704.38264661,
  369.86887737,
 313.52391688,
 724.1251917 ,
-805.48401042,
  -4.44618435,
  162.16385934,
-516.88591992,
-661.94918774,
 719.16167284,
-882.93015553,
  -58.75819216,
-768.3319974 ,
 -85.88247734,
 959.92465268,
-152.58729309,
  714.24983501,
-765.36887163,
-457.49584648,
-192.41451867,
-200.37571998,
  342.76695734,
-310.56374525,
 427.53373682,
 278.37379845,
-201.67770949,
 -136.47974469,
 229.05539962,
-859.91561971,
 644.81347671,
 306.84232223,
  452.68492884,
  73.84600216,
-779.04577802,
-189.92877341,
-189.2528343 ,
 -357.91401991,
-940.09935019,
 474.50848519,
-780.43108387,
 212.61626609,
  406.43499293,
 269.57264587,
 918.28450396,
-793.40368983,
 734.33431821,
 -941.6195303 ,
  69.83370985,
-191.51276412,
  48.36772079,
-269.80024588,
 -618.86617012,
-961.7542051 ,
  36.29962758,
 685.55372537,
-253.56808851,
 -554.27236397,
-838.93599306,
-829.37815376,
-557.20710741,
-799.97187816,
 -469.92060327,
-867.70107577,
-868.79026558,
 712.55235925,
-675.75947858,
  119.36481165,
 546.9110889 ,
 -87.18086932,
-693.26224428,
-600.80771576,
 -134.03158744,
  56.46817836,
-301.1194159 ,
 562.95920047,
 502.04329771,
  854.42361475,
-942.09490195,
 791.38258242,
-214.86242308,
 756.74499076,
  381.56955231,
 974.69751415,
 518.56490343,
-270.91074801,
   2.12634567,
 -247.22168961,
-270.17632796,
-478.19100124,
  -8.05940925,
 363.47989014,
 -445.31945739,
  48.75962215,
-765.23941166,
-680.30942629,
-906.38729058,
  941.46288554,
-992.27929698,
-642.84006388,
 225.73350623,
-837.26080229,
  763.79300619,
 439.24031568,
 932.77994288,
  15.27109448,
-399.19263368,
   99.00114559,
 861.6374346 ,
  41.52287448,
-465.58593628,
 754.79757835,
 -256.16250298,
-997.2333    ,
-504.62995502,
-363.53298165,
 717.55493646,
  -82.99366587,
-110.82542438,
-327.7954672 ,
 761.35624609,
 890.05355388,
  983.78065831,
-246.51746608
};


const double G_OUT[M * N] = {
-2.29099434e+05,
 5.22133553e+05,
-2.68749434e+05,
-1.53483963e+05,
  8.37583089e+05,
 5.93943090e+05,
 7.11879841e+04,
-3.71672232e+05,
  1.33402673e+06,
-2.19243719e+05,
 1.23574046e+06,
 9.80801400e+04,
  5.72713047e+05,
 9.96207332e+05,
 8.97266500e+05,
-8.27808300e+04,
  3.71203413e+05,
-2.20502425e+04,
-1.50478198e+06,
-5.21822088e+05,
 -3.77264431e+05,
-4.72584747e+04,
-5.91791602e+05,
 2.48840760e+05,
 -4.68864735e+05,
-4.46194742e+05,
-4.74263182e+05,
-7.98999515e+05,
 -4.13617589e+05,
 8.35618137e+05,
-4.90851316e+05,
 4.06050713e+04,
  1.27720780e+06,
-3.99568149e+05,
-1.06759441e+04,
-1.86644398e+05,
  2.11318388e+05,
-1.05967717e+06,
-1.50690334e+06,
 2.06786006e+03,
 -8.69581660e+05,
 5.20504801e+04,
-6.41064148e+05,
 2.61681634e+05,
 -1.07261658e+06,
-1.06987512e+06,
 1.93137610e+06,
-5.81686604e+05,
  1.19610678e+06,
-1.43850652e+06,
-5.60107618e+01,
-1.88024953e+06,
  1.15571197e+06,
-1.91754896e+05,
-3.70977711e+05,
-6.06970594e+05,
 -8.69276344e+05,
 2.84897387e+05,
-6.41063287e+05,
 1.04461342e+06,
 -3.58115607e+04,
 7.63995982e+05,
-8.35100193e+04,
-3.53453426e+05,
 -2.85007894e+05,
-2.84193828e+06,
 1.04714184e+05,
-1.60786011e+06,
  9.33828772e+05,
 8.98172959e+05,
 9.81170469e+05,
-6.12653496e+05,
 -1.43495856e+06,
-2.50841050e+05,
 9.18531751e+05,
-2.74386997e+06,
  2.81271313e+05,
-1.06280173e+06,
 1.40491980e+06,
-5.45019196e+03,
 -6.57759064e+05,
-4.99653270e+05,
 1.63923487e+05,
 3.69301087e+05,
 -1.38785253e+06,
 5.26912950e+05,
 1.05004946e+06,
 8.65017337e+05,
  2.70181388e+05,
-3.62777666e+05,
-1.39181467e+06,
 3.68586421e+05,
  4.93142505e+05,
 1.32590484e+06,
-9.03012023e+05,
-2.01259194e+06,
 -7.47745897e+05,
-1.20782279e+06,
 7.91966490e+05,
 2.11294151e+06,
  1.70629669e+06,
 3.12854174e+06,
 2.87955038e+06,
-2.09598248e+05,
  1.43012648e+06,
 3.13226831e+04,
-2.98190005e+05,
-1.70149551e+06,
 -1.40479180e+06,
-1.30200829e+06,
-1.34178623e+06,
 1.74186949e+06,
 -1.68226281e+05,
-2.65478990e+05,
-3.08851718e+05,
-9.18343462e+05,
 -1.44731387e+06,
 6.14275615e+05,
 1.65723303e+06,
 6.49522557e+05,
  1.56470759e+06,
 2.05187870e+06,
-1.32455397e+06,
 1.98636678e+06,
  9.88859512e+05,
-5.84355289e+05,
-2.38985951e+06,
-3.48380720e+05,
 -9.96008782e+05,
 1.26598943e+06,
-6.04287299e+05,
-4.79253116e+05,
  8.74436685e+05,
 2.01079306e+05,
-9.17038353e+05,
-4.72932992e+05,
 -4.15219563e+05,
 1.01545542e+06,
-8.94719867e+05,
-3.05048131e+04,
 -1.16378658e+06,
-6.41304702e+05,
 2.47314273e+05,
 6.35978691e+05,
  4.78346480e+05,
 1.41050819e+06,
 2.39303911e+06,
 2.20520324e+05,
 -7.78987113e+04,
 4.38772574e+05,
-8.86300144e+05,
 9.13843168e+05,
 -2.32919869e+05,
 7.26986738e+05,
-7.97182729e+05,
 2.69385532e+06,
 -2.52092109e+04,
-6.91183070e+05,
-1.05429034e+06,
 6.05198047e+05,
  7.29565372e+05,
 1.34677291e+06,
 2.74873951e+05,
 4.91708478e+05,
  9.79065349e+05,
 4.96671936e+05,
-1.40452168e+06,
 4.66284623e+04,
 -5.13317646e+05,
-4.31385217e+05,
-1.53727465e+06,
-7.35417953e+04,
 -6.38026502e+04,
-9.41410403e+05,
-1.62013338e+06,
 4.58841236e+04,
  3.92991229e+05,
-6.41303749e+05,
-7.65261748e+04,
-4.45036832e+05,
 -1.15978377e+06,
 6.77018070e+05,
 5.55565252e+05,
 9.02414126e+05,
 -7.58415527e+05,
-5.15862690e+05,
 1.44200281e+05,
-8.73098270e+05,
 -8.63418305e+05,
-3.90710197e+05,
 1.89164240e+06,
-7.84650419e+05,
  4.84565484e+05,
-9.38508626e+04,
-4.76730083e+05,
 2.04039047e+05,
  3.27471879e+05,
 1.62049542e+06,
-9.65293186e+05,
 2.31693777e+05,
  1.98243679e+05,
-9.66255710e+05,
-7.07907039e+05,
 1.00354543e+06,
 -2.76348451e+05,
-5.61731891e+05,
-1.68976410e+05,
 1.59113727e+06,
 -9.28262937e+05,
 8.54705667e+05,
-2.59559578e+05,
-7.69903561e+04,
  4.70092303e+05,
-2.16342918e+05,
-1.96295868e+05,
 4.00836143e+05,
  8.46506097e+05,
-4.56461031e+05,
-3.87720397e+05,
-4.64752227e+05,
  4.61052563e+05,
-7.49463566e+04,
 1.40874995e+06,
 4.39033024e+05,
  5.50180276e+05,
-8.96653594e+05,
-5.11902748e+05,
-6.48814619e+05,
  3.58982594e+05,
 6.35149095e+05,
-1.23142276e+06,
 8.37926283e+05,
 -4.71165541e+04,
-4.62099468e+04,
-1.07859312e+06,
 1.63505153e+06,
 -2.09907648e+05,
 1.06237754e+06,
 2.04738745e+06,
-9.53013904e+05,
  3.38317547e+04,
-1.49061473e+06,
-1.53177126e+04,
-7.15738576e+05,
  2.62616767e+05,
-4.49738872e+05,
 1.35937797e+06,
-9.37619659e+05,
  3.02466529e+05,
-1.35757496e+06,
 9.65851511e+05,
-6.23778877e+05,
 -9.40383641e+05,
-6.58745964e+04,
 5.65910243e+05,
 1.65631773e+06,
 -5.01966074e+05,
 1.45270525e+06,
 6.45479743e+05,
-1.25361212e+05,
 -6.68972041e+04,
 5.97804915e+05,
 1.00346720e+06,
 8.12098793e+04,
  1.20533478e+06,
-2.88683796e+05,
-2.14769078e+05,
-3.38012054e+05,
  3.16559558e+05,
-8.96719870e+05,
-4.49707939e+05,
-4.49742660e+05,
 -1.79859612e+06,
 6.46794028e+05,
-1.38072734e+06,
 1.81064089e+06,
  1.03638752e+06,
-9.72178538e+03,
-7.00509382e+05,
-3.22437418e+05,
 -8.68523749e+05,
 3.30239953e+05,
 2.44601126e+06,
 3.66140063e+05,
 -2.98532000e+05,
-1.18138125e+06,
 8.23826564e+04,
 1.64900090e+06,
  3.17365186e+05,
 1.33893141e+06,
-3.51540996e+04,
 5.68215641e+05,
  4.24647906e+05,
 1.55480295e+05,
 1.37451745e+06,
 2.73628753e+05,
 -5.93905211e+05,
 8.03817989e+05,
-1.05173780e+06,
 1.17624425e+06,
  3.89811109e+05,
 1.97422206e+06,
 1.44535450e+06,
 6.28151573e+05,
  1.00468500e+05,
 6.71797920e+05,
 3.28850801e+05,
-1.00532646e+06,
 -3.53659972e+05,
 5.06467962e+05,
 1.53524179e+05,
 6.38890809e+05,
 -8.36723284e+05,
-8.74431906e+05,
 4.70040991e+05,
 1.50825580e+06,
 -3.10493681e+05,
 9.15334923e+05,
-8.63377361e+05,
-8.97092212e+05,
 -7.36950338e+05,
-2.37220104e+06,
-2.77991967e+06,
-9.10548819e+03,
 -9.37934181e+05,
-5.31177733e+05,
 9.69303599e+05,
 1.03513494e+06,
  1.00299147e+06,
 9.92192970e+05,
 1.76678987e+06,
-1.32438217e+06,
 -1.22355401e+05,
 6.09434316e+05,
 6.22474623e+05,
 7.72587550e+05,
  1.32167591e+06,
-6.92126593e+05,
-8.88296413e+05,
-2.76014759e+05,
 -1.23998305e+06,
-8.14657958e+05,
 5.93763374e+05,
-1.01606667e+06,
 -4.13791506e+05,
 9.84262420e+05,
 2.20754434e+06,
-1.76260993e+05,
  1.33648421e+06,
-3.98095697e+05,
 6.79294521e+05,
 2.02127566e+05
};

