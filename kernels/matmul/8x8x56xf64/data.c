#define M 8
#define K 8
#define N 56

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
-303.04802193
};


const double G_IN[M * N] = {
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
 -246.51746608,
 932.29489125,
 583.75913926,
 351.37829529,
-510.22104116,
 -567.08547811,
-667.90435096,
 845.51322045,
-411.84667523,
 -93.8115091 ,
  -12.08433203,
 556.3431909 ,
 688.46992311,
-721.8545977 ,
-146.19127958,
  685.70977567,
 636.06661151,
-795.1724831 ,
-687.23330226,
-391.6026168 ,
 -849.28186183,
-150.67399432,
-784.7645897 ,
 136.43518734,
-506.88612038,
  192.8661307 ,
-764.94871419,
 951.76773684,
 865.12240771,
-216.40612287,
 -515.64281175,
-499.20357429,
 -33.2129296 ,
-920.0143962 ,
 279.41021215,
 -183.39418332,
-245.18685482,
 618.72994298,
 418.07092037,
 908.66763079,
 -296.12751901,
 795.0855293 ,
 539.9343725 ,
-285.15069681,
 243.33087291,
 -422.8600847 ,
 748.79983415,
-775.14536558,
-575.13127741,
-633.93341584,
 -193.94799519,
 490.46592006,
  53.8148981 ,
 -24.64735292,
-998.90807021,
 -149.19654929,
-872.89245033,
-583.49349576,
 864.78787792,
-569.20359131,
  716.67527727,
 605.78674312,
-681.70752612,
 211.42391454,
-768.67625619,
  455.77631674,
 274.92455474,
 623.87712338,
 -41.23090122,
 829.72617567,
 -901.30210642,
-414.22286995,
 430.10519493,
-163.7815765 ,
-654.09729146,
 -785.57850914,
 634.67822292,
 -53.71404307,
 764.56734384,
 466.57826863,
 -180.54758874,
-252.97797169,
  31.2766933 ,
 778.11990638,
 474.55715943,
 -989.69407146,
 388.31570274,
 839.01481381,
 420.91151901,
-645.98843687,
  -32.96374515,
-719.36796415,
-282.00944332,
 874.23408388,
 846.61061512,
 -434.32629565,
-320.73791167,
 200.42573626,
 926.39459052,
-704.39733187,
 -486.16671263,
 747.11365458,
 -16.21553658,
 797.92218445,
-628.96420495,
   65.33717494,
-347.4607347 ,
-366.91488022,
-106.24607211,
-133.8451018 ,
 -285.30624064,
 829.94154063,
 463.48837087,
 455.09398266,
-420.17310082,
  155.41884863,
 558.3588666 ,
 591.18073709,
-310.93907849,
 541.74551314,
  471.78779362,
-716.98702876,
 731.89093713,
-117.35705964,
 -27.17910222,
 -103.2616422 ,
 135.69200296,
 242.33849473,
  -3.64086847,
 733.57708652,
  255.46951239,
-197.14410139,
-166.61648618,
 621.67723026,
-303.61611451,
 -577.09040844,
-881.23362399,
 752.05369584,
 837.09290238,
-759.75963567,
 -331.05251701,
-649.25586097,
-768.20306235,
 799.733486  ,
-886.24548171,
  960.97132694,
-807.09827861,
 726.94129839,
 133.01221398,
-264.16502436,
 -315.31524675,
 514.72828648,
-370.85340999,
 314.63783323,
  34.65216703,
  -30.06870968,
 802.3243413 ,
 109.29011724,
 653.7232061 ,
 451.1470682 ,
 -922.88550788,
 546.22010501,
-566.25949982,
 806.2992937 ,
-914.15161878,
 -333.85593105,
-800.53410553,
 -48.82176583,
 640.04487174,
-403.62528067,
 -698.13020538,
-339.46592861,
 627.76028384,
-719.2320844 ,
-545.27510184,
 -862.29607101,
 411.42008798,
-209.53351293,
-378.32004571,
 437.25278068,
 -328.04491532,
 455.54254643,
 630.39879063,
-564.67431308,
 947.63739369,
 -675.28410417,
-418.31818669,
-640.40941833,
-308.98868729,
 -39.87822436,
   44.351738  ,
 707.21208459,
 778.89581763
};


const double G_OUT[M * N] = {
5.72130137e+05,
-1.02242652e+06,
 9.99381637e+05,
 3.24475633e+05,
 -6.61948377e+05,
 2.40853477e+05,
-4.01235618e+05,
 5.55191178e+02,
  1.17507919e+05,
-6.84468857e+05,
 8.42235979e+04,
-5.03899739e+05,
  1.62777087e+05,
-9.93080992e+05,
 5.20063707e+04,
 9.77099633e+05,
 -1.64784894e+04,
 1.31056788e+06,
 1.04200724e+06,
 5.28321033e+05,
  6.38334092e+05,
 5.19837700e+05,
 6.85806839e+05,
 2.13851857e+05,
 -1.32535980e+05,
 2.69125273e+05,
-9.49869911e+05,
 1.81181500e+05,
 -6.03792998e+05,
 4.99852602e+05,
-7.36854843e+05,
 6.24690685e+05,
  8.11499309e+05,
 6.32578165e+05,
-3.43046266e+05,
 3.79152459e+05,
  1.17750747e+06,
-1.89859524e+05,
 9.24903676e+04,
-4.58914791e+05,
  2.36136158e+05,
 4.90319771e+04,
-2.16077906e+04,
 3.81878863e+05,
  4.67650919e+05,
 3.20978176e+05,
-8.80085808e+05,
 2.79276923e+05,
 -3.74811870e+05,
 7.32395504e+05,
 4.97080921e+05,
-1.10099372e+06,
 -3.95823149e+05,
-3.43976551e+05,
-6.89466518e+05,
-5.37293141e+05,
 -4.80426643e+05,
-4.88839643e+05,
 8.89696662e+05,
-3.19156101e+06,
  2.17968441e+05,
 3.14945252e+05,
 1.92810252e+06,
-1.07977558e+06,
  1.36694778e+06,
 1.83984496e+06,
 1.53751682e+06,
 1.20277793e+05,
 -2.62731930e+04,
-5.40294731e+05,
-2.75533535e+05,
-7.69151798e+05,
 -9.25570432e+05,
 1.13227825e+06,
-7.09105833e+05,
-3.83614681e+05,
 -7.80340724e+05,
-2.44892373e+06,
-6.01233251e+05,
-6.70607892e+05,
  8.28514016e+05,
 1.51063846e+06,
-1.18329226e+05,
 2.36569909e+05,
 -8.28941462e+05,
 5.58296522e+04,
 2.19080452e+05,
-2.21149365e+06,
  4.85356942e+05,
-1.28720401e+05,
 1.48230063e+06,
-1.32241091e+06,
  1.21558505e+05,
-3.01955022e+05,
 3.54004893e+05,
 2.10849348e+06,
  1.32643114e+04,
 3.41986710e+05,
 2.75891867e+05,
 6.69440136e+05,
  3.36977008e+05,
 1.49354555e+06,
-1.36983729e+06,
-2.01907645e+05,
 -1.13404026e+06,
-4.89364006e+05,
-2.15354234e+05,
 2.48245913e+05,
  1.90651036e+06,
 1.04270118e+06,
-6.15523400e+05,
 1.96607149e+05,
  1.31877322e+06,
-7.72986378e+05,
-1.23215832e+05,
-2.34169224e+05,
 -9.11980890e+05,
 8.25288457e+05,
-1.71577094e+06,
-1.13046079e+06,
 -8.45261746e+05,
-5.10660598e+05,
 7.29626945e+05,
 1.23594253e+06,
  1.46819508e+06,
-7.80867170e+04,
 6.56826907e+04,
 3.39856997e+05,
 -7.71356405e+05,
 1.30323284e+06,
 9.93697706e+05,
-4.62761128e+05,
  1.52911903e+06,
-1.66571014e+05,
 1.33088467e+06,
-1.87669296e+05,
 -6.94935098e+05,
-9.98437474e+05,
 4.66718348e+05,
-1.14653632e+06,
 -2.23004047e+05,
-4.02444958e+05,
-2.90851059e+05,
 2.12907538e+06,
  1.56126845e+05,
 1.80910371e+06,
-2.06592066e+06,
 1.07070345e+06,
  1.31375328e+04,
 4.17150860e+04,
 5.16745660e+05,
-3.93434579e+05,
  2.45947150e+05,
 4.43949559e+05,
-7.60681151e+05,
 1.60354223e+06,
  1.09514645e+06,
 5.98441726e+05,
-6.17304060e+05,
 6.81055887e+05,
 -1.74136863e+06,
 1.56174577e+06,
-1.44006840e+05,
-1.89921697e+06,
 -1.51703017e+06,
-1.81165217e+06,
-1.07125024e+06,
-2.46523654e+06,
  1.04094377e+06,
-1.98535771e+06,
-4.34561048e+05,
 1.26324882e+06,
 -9.00010274e+05,
 1.64746181e+05,
-1.52568786e+06,
 1.12420329e+06,
 -1.01738094e+06,
-1.01243024e+06,
 1.10346057e+05,
-2.88019397e+05,
  1.07534193e+06,
 6.47000767e+05,
 8.99270912e+05,
 1.00913649e+06,
  7.28635548e+05,
 2.62620360e+05,
 9.50014037e+05,
 6.03898352e+05,
  6.42622893e+05,
 1.09979201e+06,
 1.85230642e+06,
 4.60157357e+05,
 -3.59346949e+05,
-9.90118294e+05,
 1.53948489e+05,
 4.21959000e+05,
  1.33429999e+05,
 1.27355656e+05,
-7.55447468e+05,
 1.93620629e+06,
  5.60095407e+05,
 4.45018041e+05,
-2.08841622e+06,
 1.63288842e+06,
 -8.66915675e+05,
 8.10938791e+05,
 8.46423888e+05,
-8.24823603e+05,
  4.17072201e+05,
 2.77557409e+05,
-1.43123421e+06,
 9.97131580e+05,
  1.25111085e+06,
-4.36325684e+05,
 2.66922658e+05,
-4.98916259e+05,
 -6.58495052e+05,
 5.39514682e+04,
 2.30833017e+05,
-1.68629613e+06,
 -1.65591347e+06,
-1.01424966e+06,
 9.27467246e+04,
 7.45169570e+04,
  5.22923725e+05,
-7.18341738e+05,
-1.05557273e+06,
 1.79063521e+06,
  1.17712202e+06,
-2.44492863e+05,
-7.94335103e+05,
-1.37844600e+05,
 -9.04748333e+05,
-1.37554504e+06,
-7.37775559e+05,
-2.61981818e+05,
 -8.44308219e+05,
-3.57288071e+05,
-3.36613367e+05,
 4.10673641e+05,
 -2.56166283e+05,
-1.33410449e+06,
-9.17606179e+05,
 3.45362843e+05,
  2.01319280e+06,
 1.56699984e+06,
 1.44337201e+06,
-7.30098997e+05,
  3.91970765e+05,
-6.20705177e+05,
 1.16143568e+06,
-4.21974208e+05,
  1.23525299e+06,
 5.33001577e+05,
-1.13601170e+06,
 9.66600513e+05,
 -1.72884012e+05,
-1.35518279e+05,
-1.55918576e+06,
 6.53658689e+05,
 -1.98565471e+04,
 2.25726182e+04,
 1.77877429e+06,
-7.13232323e+05,
  1.41429699e+05,
 1.06470048e+06,
 3.24352738e+05,
-1.16966540e+06,
 -6.12747195e+05,
-8.78913339e+05,
 8.70540538e+05,
 6.36185417e+05,
  1.02626769e+06,
 3.72223962e+05,
-6.31316042e+05,
 8.72626122e+05,
 -1.83147214e+06,
-1.69752534e+06,
 9.82444040e+05,
-5.02484140e+05,
 -4.89251249e+03,
 1.20875015e+06,
 4.27507437e+05,
-1.50398559e+06,
 -3.69252252e+04,
 6.99599953e+05,
 7.99823748e+05,
-8.52974889e+05,
 -6.64269794e+05,
 2.03327433e+06,
 8.09997474e+05,
 1.79913923e+06,
  1.30623336e+05,
 9.04547074e+05,
 3.63215441e+04,
 1.80223804e+05,
  4.13336324e+05,
 4.99139659e+05,
 2.26780302e+05,
-1.70996389e+06,
 -1.25391587e+06,
-2.08322402e+06,
-1.35145941e+06,
 9.67970855e+05,
  1.11105700e+05,
-1.11266710e+05,
-5.06519971e+05,
 2.51225998e+05,
  5.74526859e+05,
 3.35537462e+05,
 1.73567179e+06,
-1.56224415e+06,
 -5.84663285e+05,
-1.41609864e+05,
 6.70487982e+05,
-3.04314134e+05,
  1.51846778e+05,
 2.76701853e+05,
-1.21361329e+06,
 1.04942300e+04,
  5.36099794e+05,
-9.71061448e+05,
 3.17910639e+05,
-1.84337345e+05,
 -2.55052458e+05,
-1.49758824e+05,
-7.70296943e+05,
-1.38338548e+06,
 -6.75801538e+05,
-1.00397707e+06,
-8.02998459e+05,
 1.06340912e+06,
  9.54871749e+05,
 1.11365677e+06,
-1.62307359e+06,
-2.12134523e+05,
 -5.71108459e+05,
 1.37717409e+06,
-4.89393490e+05,
-1.33147977e+06,
  1.12612344e+05,
-8.36740155e+05,
 1.49143544e+05,
 2.11650280e+05,
 -8.59651756e+05,
 1.84285333e+06,
 1.26378402e+06,
 1.45396075e+06,
  1.56211604e+06,
 2.13339328e+06,
 2.34079741e+05,
-1.62876015e+06,
  6.57898158e+05,
-9.88021389e+05,
-5.94691093e+05,
-1.49704308e+06,
 -1.39714043e+06,
-1.97814881e+06,
-5.97596835e+05,
 9.88253692e+04,
 -1.33344320e+06,
-1.20590122e+06,
 1.23507130e+05,
 3.60425707e+03,
 -3.09050303e+05,
-4.54168215e+05,
 2.09377702e+06,
 1.73720062e+05,
 -1.16984478e+06,
-1.37481881e+06,
-3.63522177e+05,
-4.93714934e+05,
 -1.78126832e+06,
 4.25947559e+05,
-1.04727824e+06,
 5.43801805e+05,
 -6.43669555e+05,
-1.31191204e+06,
-1.37747631e+06,
 1.35607286e+06,
 -6.29607582e+05,
 3.97839281e+05,
 1.04951288e+06,
-4.29656644e+05,
 -7.16481922e+05,
-1.47830297e+06,
 4.40627798e+05,
-7.76907549e+05,
  6.48812736e+05,
 5.21901266e+05,
 7.26350959e+04,
 6.03398684e+04,
 -1.20594122e+06,
 1.72219920e+06,
-4.16339369e+05,
 2.73641102e+05,
  4.56066005e+05,
-4.78055886e+05,
 8.14446909e+05,
 6.96234070e+05,
  8.11534611e+05,
 3.20262923e+05,
-9.23511154e+05,
-5.20776744e+05,
 -9.94959131e+05,
 5.27085888e+05,
-3.00050669e+04,
-8.95047939e+05,
  4.10041254e+05,
-1.35240667e+06,
-7.46191751e+05,
 1.24085188e+05,
 -1.48047217e+06,
 1.26243179e+05,
-1.76650546e+06,
 2.97199456e+05,
  3.68072091e+05,
 5.06390727e+05,
 9.10003341e+04,
 4.07674716e+05,
  3.11022575e+05,
-4.66172120e+05,
 6.08394969e+05,
-1.24144872e+06,
 -7.77028841e+05,
-9.29954394e+05,
 1.73821930e+06,
-7.49059886e+05,
 -5.43613585e+05,
-3.41407917e+04,
-1.08837170e+06,
 1.80824480e+05,
 -3.86325535e+05,
-4.89297489e+05,
 6.72675060e+05,
-9.76446559e+05,
 -5.96593655e+05,
-4.51340535e+05,
 8.08787507e+05,
-3.91580492e+05,
  1.38764654e+06,
-9.50242099e+05,
-1.80910940e+04,
 1.46776912e+06,
  1.22677348e+06,
 1.32160772e+06,
 1.14730335e+06,
 1.61546647e+06
};

