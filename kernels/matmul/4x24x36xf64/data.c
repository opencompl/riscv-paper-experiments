#define M 4
#define K 24
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
 -633.61727599
};


const double Y[K * N] = {
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


const double G_IN[M * N] = {
-559.79227844,
 245.78806437,
-777.0078854 ,
 -82.06027964,
-355.33292391,
 -366.99850909,
 -34.83151658,
 459.65527106,
-861.63468242,
 758.34667537,
  469.62754926,
-647.00122222,
 878.32181817,
  12.62444805,
 999.61715623,
 -605.4810514 ,
  69.81639677,
-419.50391488,
-391.65288522,
 182.13076167,
  843.43813374,
 610.52771116,
 447.882797  ,
 118.3475642 ,
 844.59700733,
  -15.27718662,
 747.66435667,
 667.96328775,
-572.3293064 ,
 542.45092593,
 -975.65768611,
-354.3409249 ,
-540.86511062,
  13.72591697,
 473.70632336,
 -804.6472651 ,
  29.84440387,
 876.82404339,
-542.70689803,
 354.28228822,
  185.76054156,
-979.87260869,
 -48.34760829,
 417.54078188,
-912.04913595,
  759.04296605,
  40.16283327,
-938.67790335,
-551.17277616,
 907.35139285,
  164.6394661 ,
-785.05486446,
-424.91099544,
 -86.59274828,
-958.09986146,
 -176.76897277,
 -21.08272913,
-512.64424944,
 177.27800058,
 506.48023918,
 -528.33155179,
 240.99980056,
 279.24448593,
 897.08060226,
 556.55233459,
  696.69053958,
 -19.16018313,
-629.30282604,
 991.63058592,
-741.28847792,
  -57.08536129,
-863.81380152,
 887.7017147 ,
 929.8498817 ,
 438.77812401,
 -300.01431274,
-491.23519776,
-469.39335093,
-745.41194916,
  51.61790615,
 -716.3654486 ,
-366.53866689,
 253.41295192,
 455.08721918,
-951.45459076,
 -139.76803125,
 304.24918968,
 706.49195232,
 -49.35043558,
 938.41174344,
 -468.73490492,
-972.98258675,
 -32.4942706 ,
-487.77240996,
 647.43534405,
 -534.45465564,
-378.74156342,
 582.45486204,
 430.28650405,
 116.10247331,
  409.89612385,
-162.72627286,
-989.37990477,
-977.28974298,
  22.44357515,
 -833.41804056,
-897.84903966,
 931.03327827,
 718.00527932,
-695.94554558,
 -998.67156282,
 883.33559078,
-443.34940336,
-628.20479429,
 383.01621566,
 -782.19252232,
-470.70080399,
 950.18936042,
 278.92554895,
  41.35558297,
 -204.16277033,
 549.00190977,
-718.08504695,
 934.67560407,
 722.24601613,
  235.31396514,
-914.18761919,
 401.7112989 ,
 826.56868177,
  49.15413496,
 -291.55035635,
-759.44531004,
 509.80220828,
 770.04370242,
-799.49651185,
  517.9691095 ,
-965.87902748,
 934.10983615,
 230.11604127,
 104.87811798,
 -408.10033282,
 858.58334314,
-468.18874533,
 656.29322643,
 970.21735867,
  566.79329103,
  37.97984077,
-867.8514723 ,
 -55.17242166,
-123.48810606,
 -594.40791763,
-152.82472657,
-284.48423184,
-672.6314777 ,
-117.25171334,
 -474.40008735,
  44.12484136,
-929.67988057,
 812.46283957,
 632.72861104,
  105.16266502,
 703.61716551,
 924.79014762,
-778.95541189,
 261.66361682,
  995.98800187,
 975.77833867,
 206.64598458,
-743.9582591 ,
 166.38566198,
 -995.87072885,
-602.17733067,
 912.24631912,
-339.11885479,
 276.78021155,
 -438.28101074,
 895.64377422,
 457.1174599 ,
-340.69768484,
 583.52284236,
 -783.66895105,
-215.36211987,
-557.56374454,
 367.45289455,
-795.10743646,
 -205.94833543,
-446.70053958,
  12.68583865,
-300.20463899,
 412.82115533,
 -950.84595139,
 267.97384261,
-538.85742061,
-462.58194249,
 600.51120717,
  911.13678796,
-366.89957995,
 653.61054074,
-792.01832406,
 267.96330601,
  502.06459907,
-688.04414393,
-147.99522466,
 785.4143285 ,
-792.8430731 ,
 -963.8072836 ,
 181.1707581 ,
-128.93691894,
 597.37849777,
 846.91107641,
 -401.69271091,
-223.19176566,
 -27.45582734,
 176.30292087,
 967.70765936,
  394.66050166,
-220.90298531,
-472.4646271 ,
 889.25143684,
-728.90313378,
  440.53170501,
 850.79005058,
 329.33117307,
-153.89111967,
-602.01812015,
 -265.0493555 ,
 413.74361884,
 299.06844835,
 855.9523332 ,
 733.72182732,
  632.30150453,
 822.9017507 ,
-447.32569453,
-260.95291972,
-240.21219243,
  120.90117742,
 336.43645909,
-426.56663392,
-961.07506538,
-201.55523268,
 -382.94408089,
 884.36943804,
 776.53008109,
 720.62135669,
 305.99952189,
 -311.4216706 ,
  97.6985348 ,
 630.45008143,
-802.77926255,
 602.14976051,
 -917.64041734,
 632.84206243,
 615.12760832,
-897.98538234,
 254.32142292,
    4.90614863,
-660.36099366,
-703.24212465,
 546.51825213,
 135.38549767,
  965.99826983,
 964.49555458,
 985.33398693,
-762.76896327,
 876.51227393,
 -510.86078196,
 -83.57548048,
 514.81311164,
-592.75813585,
 132.62321111,
 -628.36650355,
-790.52778664,
-766.88277514,
-284.7219303 ,
-990.69032633,
 -150.2921576 ,
 328.39421016,
-196.62362999,
-828.41079896,
-874.62227595,
 -443.76697447,
-661.37461891,
 930.18994644,
-697.53955005,
 610.92487481,
  172.21588348,
 138.57383997,
  24.16143185,
 943.52615223,
-272.31044982,
  575.83150191,
 110.58821493,
-208.73266475,
 910.93186661,
 196.63193873,
 -762.16611571,
-164.92159801,
 563.16345536,
 387.49404648,
 832.68065967,
 -481.24523172,
 516.38743271,
 -80.24958521,
 147.21949393,
 910.09336201,
  958.57263998,
 723.18192785,
-281.80582454,
 775.40167145,
 277.21835528,
 -140.00643906,
-928.514635  ,
 540.25624838,
   4.21116145,
 572.37699893,
  496.04559869,
 587.1347361 ,
-398.69768261,
 601.59719814,
  97.69265693,
  -53.3475991 ,
 350.25182764,
-957.28263412,
-795.36636822,
-415.64526966,
  965.98021992,
-720.50844227,
-338.80739848,
-897.89387062,
-337.46223941,
 -359.34742698,
 893.61434189,
 690.30817399,
-234.47156151,
-950.46188392,
  662.06222799,
 321.07235429,
-695.2710327 ,
 992.14254202,
-799.53312515,
  734.22908319,
-411.46767174,
-129.29306735,
 590.91305355,
 355.01671199,
  875.72874889,
 242.28065092,
-804.37967704,
 768.72072648,
 538.31104998,
  423.74090179,
-892.53290529,
-207.55451068,
-665.12836108,
 643.80781682,
  401.05724564,
 766.15519464,
 933.15021385,
 549.49522838,
 988.46616644,
  229.53977229,
-925.74079222,
-971.4969697 ,
-315.79224959,
 646.94343814,
  732.26941265,
 921.62505765,
-869.7570629 ,
-910.85777802,
 826.56719273,
 -389.90660327,
 115.97480122,
 964.889766  ,
-199.10293053,
 331.74279662,
 -198.24087274,
 536.38932893,
  55.42945115,
-524.95372403,
-457.38779748,
 -483.88157492,
  64.64065652,
 406.37803203,
 898.55980009,
 388.17475017,
  562.38568792,
-662.14776827,
-251.87474999,
-172.43956028,
 372.76046   ,
 -408.21604725,
-393.41615716,
-288.22169072,
 620.60416309,
 155.18018009,
 -849.44544033,
-843.50780062,
-257.42611144,
 533.18210121,
 377.36685296,
  415.9647093 ,
 534.42013211,
-425.69457423,
  96.51256388,
  86.70528063,
  479.26500236,
 913.74113821,
-444.02011041,
 586.56334551,
 319.94109705,
  160.47574173,
 549.75955869,
 888.06493286,
-926.61716426,
-705.19979497,
  512.574463  ,
-832.41729418,
  32.24740148,
-560.27844672,
-451.40859231,
  403.68096589,
-939.61445346,
 746.6388558 ,
-111.0420893 ,
   4.78658781,
   80.09592739,
 291.08858916,
-310.28682675,
-797.78501887,
-363.24212667,
 -663.71576395,
 112.2663589 ,
-363.94273808,
 916.13435599,
 931.46855596,
  240.25176114,
 234.99453533,
 970.75712913,
 774.56630247,
 530.13989832,
 -372.81877651,
-268.92194376,
-597.46646848,
 -25.70374617,
 980.73704428,
  824.30190602,
-763.30113196,
-949.61942142,
 797.27533682,
  74.3402559 ,
 -599.62022358,
 347.30653917,
 288.44635586,
-755.82878633,
-480.799533  ,
 -879.84407137,
-580.27905226,
-735.38865029,
-613.52741505,
 370.93429183,
 -901.00051148,
-796.2907695 ,
-731.65272384,
-366.91775808,
-402.4993783 ,
 -489.87242937,
 501.07330686,
 996.04557552,
  67.95584726,
 888.40543583,
 -206.77977575,
-786.63510639,
-182.45234106,
-407.74445317,
 -13.18607542,
  314.08735383,
 -77.8995617 ,
 870.32102416,
 769.5296446 ,
 403.95519033,
  -20.63017527,
-736.62543637,
-205.97266644,
 408.8030788 ,
-430.22895889,
 -792.02384491,
 815.79691502,
 418.10161963,
 230.55285327,
 584.99781122,
  671.29207517,
 -33.08200366,
 762.37650282,
 832.8380214 ,
-456.89780915,
  215.09071958,
  53.16805764,
  75.8915583 ,
 875.32618793,
-389.62259461,
  966.86795647,
 804.26242961,
 -82.55422277,
 634.90652724,
 538.09398864,
  355.78993924,
-360.33222123,
-607.09801636,
 343.05539353,
 685.9465928 ,
 -967.49442265,
 285.60675062,
-114.25395076,
 796.17551025,
-357.05413829,
  -51.63037547,
  29.53420807,
-719.12095726,
 425.7846054 ,
 660.95269024,
 -884.18144621,
-417.22235893,
-923.91063693,
 913.08820938,
 334.33764141,
  928.40083891,
  62.98855666,
 604.13704779,
-251.17203224,
-292.36193485,
 -243.46436579,
 315.72426745,
-281.09369796,
 800.73490321,
 966.5497301 ,
 -939.14696933,
-612.7534192 ,
-775.50001483,
-915.27190582,
-544.51801331,
 -106.41335926,
 673.98073058,
-556.35193898,
 -12.10948868,
 859.23747889,
  334.42941357,
 596.15803951,
 101.98794037,
 960.93291768,
 177.32430936,
 -908.97857207,
-604.03440012,
-190.45274209,
 202.55434515,
 543.86173482,
 -173.82774819,
 420.11661003,
 579.73900622,
-365.4796055 ,
 958.54048007,
  299.31299047,
 761.99612157,
 111.87537762,
 483.2062143 ,
 541.08812323,
  816.49675847,
-699.30048626,
 116.56684834,
-143.24297379,
 846.31804235,
 -789.8106115 ,
 965.14777736,
 750.90264819,
-852.34743687,
 -18.06722892,
  435.11900043,
 476.30309138,
 812.98825048,
 599.73087116,
-378.13923931,
   -3.13042828,
 403.57152587,
-723.12631727,
-612.0184048 ,
 -37.91510378,
 -403.50840259,
 725.11849957,
 172.55464304,
-302.66960456,
 697.66605121,
  609.75689711,
 996.7097542 ,
 694.61537667,
-171.08693039,
-745.00223646,
  681.2818164 ,
-880.48416408,
-299.45758531,
 839.47596154,
 921.53294689,
  281.12918704,
 377.29663397,
-915.09102255,
  28.96068218,
  93.73635761,
 -319.79850775,
-862.80633049,
-542.18480055,
-284.03212628,
-129.71602697,
  181.85345107,
 444.7830374 ,
-364.73625345,
-342.09248016,
-960.61671455,
 -918.25027981,
-484.35661138,
 480.48999535,
 256.62766075,
 539.57804136,
  537.83887243,
 713.13493534,
 440.63853197,
 958.021838  ,
 797.6504386 ,
  173.43433245,
 176.31534098,
-931.4659193 ,
 997.05315542,
-736.84800527,
  480.69439326,
 642.03039025,
-253.89094139,
-606.29589067,
-802.48022642,
  497.21201166,
 -94.69294159,
 427.435518  ,
 830.8152977 ,
-706.8325277 ,
  838.34200145,
-176.74708098,
-389.46598021,
 886.12452121,
 981.30338521,
 -602.21556447,
 313.6766939 ,
-787.00937246,
 301.82800772,
 654.62645555,
  368.99709305,
-165.33371587,
-233.86728087,
-213.75516955,
 179.42363599,
  763.13454014,
 858.13231454,
-892.94075959,
-636.75521071,
-775.55136834,
 -613.33071847,
-306.78437878,
  13.06336525,
 258.92245402,
 464.28443828,
  780.22308277,
 978.17687446,
 325.71295711,
 690.72903734,
 556.07769385,
 -384.93592156,
 751.38454047,
-914.4737241 ,
-999.2653125 ,
-452.53474122,
  -75.80494075,
 276.72579   ,
-796.45946691,
 346.02026767,
 603.63173412,
 -629.37416084,
-169.74949034,
  39.96997991,
 -96.38596383,
 599.65986178,
  921.04479624,
 597.90632802,
-844.01436425,
 609.87114432,
-866.80733553,
 -528.05922952,
-693.80620633,
-604.96178631,
  56.63025411,
 343.37971522,
  -59.35743533,
 919.39127806,
-519.41535994,
 526.28046051,
 740.36435701,
  124.13222151,
 -87.55499608,
 192.36889356,
-142.38045968,
 110.38776465,
 -166.13209574,
-199.06057941,
 390.69293628,
-814.29757386,
-666.91585454,
  702.39694343,
 542.15469363,
-437.09254541,
-245.46213467,
 852.05301326,
  636.15445035,
 228.69259996,
-557.01964239,
-911.49605737,
-137.48430632,
  345.25427851,
 656.96098104,
 705.37801148,
-934.44819741,
-511.68593233,
 -321.81082305,
-622.53557808,
 605.95075673,
 534.93152617,
  33.66608076,
  965.85295599,
-711.88291782,
 799.30340666,
-767.07349168,
-673.63658897,
  392.4384005 ,
-780.86061592,
 131.69019084,
-159.53292705,
 456.94793108,
  801.35047762,
 539.74302934,
 699.37975284,
-934.10910294,
-379.60900351,
   30.86617337,
-168.09337074,
-537.49009404,
-384.25180408,
 890.86194078,
 -411.63824026,
-292.19177964,
-992.5804525 ,
 690.15525456,
-690.3185932 ,
 -591.71144897,
-489.47096582,
 769.24411369,
-587.09717751,
 595.05272174,
  616.09868065,
 854.04113757,
-768.8773728 ,
-565.44205532,
 485.79658416,
 -607.99849144,
-427.34090625,
-666.51683978,
-654.60662769,
 -36.89329074,
 -780.63387577,
-356.60476307,
-146.8121808 ,
-950.90376695,
-223.33366705,
 -811.75512783,
 -12.84293771,
 651.47637711,
 636.84432436,
-839.10296893,
  202.45551535,
 669.17276394,
-524.05491413,
 523.8530229 ,
 781.5286929 ,
  612.24830288,
-785.39793697,
-981.88000096,
-616.55178016,
-459.04531811,
  232.36598123,
-231.45364952,
 406.81406132,
-293.85007896,
-691.14915069,
 -374.62031303,
 768.64845278,
 917.06468849,
-584.97453187,
 576.93677405,
 -453.30252692,
 774.26308686,
-668.90877441,
 331.91983739,
-831.57747057,
  947.78664795,
 401.26668928,
 683.63147881,
 133.33867873,
 -46.39727214,
  243.76478279,
  57.4830234 ,
 -61.23128971,
 518.90050292,
-643.59809012,
 -657.65590369,
-136.3146987 ,
-358.50416791,
-851.75096417,
 688.94098484,
  543.20561339,
  87.84299961,
 958.64907453,
-854.7998669 ,
 533.33860206,
 -467.25921678,
-262.80216011,
-561.44122959,
 578.07578292,
-711.51979596,
  680.03339547,
 323.15529646,
-881.95350946,
 621.9634632 ,
 255.51143233,
  809.96463916,
 497.44461282,
 122.24185486,
 673.09436124,
-443.8995234 ,
   93.90012369,
-412.76636039,
 936.40878218,
-547.60739832,
-968.52352066,
 -348.29031599,
   5.01879394,
-943.27413154,
 118.49660007,
 748.5655499 ,
  409.46438883,
 245.93664596,
 911.92350142,
 916.55866768,
 648.53293941,
  215.48369477,
 -24.470881  ,
-973.36777351,
 212.52381245,
 978.17615071,
  636.20210005,
-318.79071223,
-695.90594991,
 568.11722893
};


const double G_OUT[M * N] = {
-479274.67631989,
 3357190.5668711 ,
 1905227.11007137,
   710421.57056803,
 -790495.13051344,
-2016666.51218107,
  -971001.03071723,
-2327976.73470549,
-1100351.07184755,
  1053007.32215433,
 -259953.40063588,
 2031090.46842051,
  -857486.3689486 ,
 1111038.70968755,
-1670991.20572674,
  1047759.27174221,
  623983.70250373,
 2716013.59763541,
 -1039254.27516596,
 1622465.65527925,
 2847495.18411981,
   291117.36738882,
 -454514.60380751,
-2530918.27297897,
   590948.77227089,
 -155165.39004578,
 -988377.76046252,
  -463904.94005161,
  -79712.27605564,
 1542679.11878707,
  -302130.28629764,
 1878412.43705418,
  121433.66629751,
   660781.46929682,
 -110517.20409765,
 1790776.2359169 ,
 -1736898.66277769,
  614716.74325717,
 -741999.00480333,
   -38185.76794443,
 1734111.89539968,
 2855031.45949545,
  -327749.96383862,
-1030162.64123249,
 1935962.10720194,
   658417.09164583,
 -920001.54274674,
 2652395.46416002,
   693686.44227341,
  472928.15809316,
-1198218.27905728,
 -1951408.06510737,
  371629.2919985 ,
  858636.55183977,
   387735.37977139,
   11162.69321073,
  610642.06068157,
   582288.39122646,
-1696028.87986395,
  960579.1809927 ,
  1645388.3513123 ,
 1406452.54558019,
-1194115.82771073,
  -884329.91122794,
 1614837.8286922 ,
 -660374.14792583,
  1740473.14605559,
 1049279.36998123,
 -456340.23993388,
  -182707.69626986,
 1991774.63182701,
 2528863.71600424,
  1408961.39343092,
 -910240.85858076,
 -886832.77862043,
 -1673257.01535328,
  769255.73624636,
-1936324.39107979,
 -1018190.95069648,
 1618423.38982884,
  833760.36717775,
  3648767.17072896,
-1505125.97921074,
  309212.24629919,
  3362340.58687681,
-3545881.46361422,
 -911192.71658088,
 -4040465.53283728,
  198941.47297218,
 3813624.15089239,
  -994259.87629182,
 1593255.33448868,
  822956.84234426,
 -1919824.90776327,
-1191571.44852044,
  304899.27008928,
  2381021.58857897,
-1042837.00109865,
-1728779.99550021,
   771310.6702242 ,
-3018510.06460673,
 -176675.16727579,
  4147043.20157539,
-1031009.08063747,
-1235692.28365117,
  2756719.75544842,
 -677322.23446489,
 2858634.09654042,
  -359229.48098057,
 -247027.79296404,
-1849022.61766914,
  -995113.17626718,
 -929139.9073438 ,
-2340331.63719006,
 -3310224.52813152,
 2146313.95061978,
 1420383.6215897 ,
  3201092.72131102,
 1159194.87041721,
-2214853.59973285,
  -725013.66018543,
 3744376.02853918,
 -308226.8309647 ,
   897085.21928238,
  -43773.78354256,
 -674774.71756087,
   130543.04367554,
  846080.3339225 ,
 1129130.07443456,
  -797848.9164834 ,
-1774858.08445903,
 -152818.23466327,
 -1520985.35149186,
-1357011.63861031,
 4905510.02120966,
  1684986.82438339,
 1379461.87662487,
  594359.68924866,
 -1728858.09452301,
   30140.74127051,
-2103429.20092862,
  1513581.96743147,
-1755273.78111948,
-2604187.8626363
};

