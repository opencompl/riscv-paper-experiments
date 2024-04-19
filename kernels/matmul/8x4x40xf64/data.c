#define M 8
#define K 4
#define N 40

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


const double G_IN[M * N] = {
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


const double G_OUT[M * N] = {
423216.93184172,
   41091.04026434,
  173440.75554981,
  -353741.55454586,
   46764.2285095 ,
 -258273.46940544,
    51419.76937465,
 -290889.66030602,
  -56067.49567872,
   -93889.74868991,
 -109233.98700913,
  204769.36687751,
   143961.59558632,
  -61013.36827153,
 -321838.65756731,
  -528674.25487163,
  136463.88524332,
  197666.33136941,
   -90174.51230179,
   22820.63971158,
 -425275.89249207,
   -60854.94726551,
 -156625.58733805,
 -351037.06503105,
   107148.88861966,
 -321413.47957408,
  375781.28714387,
  -588479.92446809,
  189272.84696481,
 -306672.98050502,
   220471.10278025,
  441230.65961113,
  -71688.38221144,
   144190.79273838,
  -16029.88779075,
  172095.35553471,
   -42995.37816591,
  482134.46527334,
 -114849.75478632,
   391279.83362458,
 -287087.46337112,
  271949.53045849,
  -381267.7369173 ,
  266355.59864801,
  225473.60529939,
  -169356.39281431,
 -495232.9113244 ,
-1001246.64393067,
   189836.92013391,
 -103938.38893898,
  -80586.28301439,
   784828.38854986,
  752135.30982107,
  341992.68563644,
  -543144.35804107,
 -293538.1503087 ,
  421114.0873213 ,
  -170031.87290424,
 -123812.02394867,
 -564163.72378237,
  -743142.81770182,
 -456390.25786406,
  408790.30625143,
  -536774.39313178,
 -257172.96044482,
  427882.08283234,
   484613.11603591,
 -927530.5418506 ,
 -416539.73562936,
   208197.18471227,
  226549.33661132,
 -128375.84965228,
   550047.7735693 ,
  212226.55764542,
  111332.0335066 ,
   201374.93257788,
   42331.87883651,
  -31679.77076982,
  -248339.28169108,
 -334875.37070981,
 -109844.58685531,
  -144975.95913698,
 -681337.83772462,
  352474.29406142,
   789390.41657252,
  496772.97567611,
 1352763.51918655,
   689844.88057718,
  109966.6057002 ,
  -80634.35229163,
  1127615.30456886,
 -694996.78185671,
  244349.27266234,
   591130.97498494,
-1165467.77564655,
 -746619.58639613,
  -164236.07329278,
 -735832.82036143,
  354923.44903001,
  -326554.45149257,
  617391.69999494,
-1129960.56882905,
  -326158.45262225,
 -406314.97789598,
  312483.19133021,
    -5568.28572923,
  -14729.28114365,
 -377211.31443862,
  -291420.77753133,
 -755889.70448603,
  114368.23100249,
  -459491.18653864,
  -38109.90414496,
  -27886.36414211,
    90040.47920312,
 -281036.73619051,
 1032474.24745169,
  -399814.14631404,
  487495.58185022,
  176381.62961826,
  1014806.18868774,
  353838.17820325,
  359167.18274123,
 -1149611.06689167,
-1500686.58281951,
 -868316.58566309,
  -727987.24740638,
 -218428.41655938,
-1060655.95924702,
   -88645.04533415,
-1837493.26784353,
 -644175.63487953,
  -495890.14114163,
-1123112.37070244,
 1592140.52316922,
  -220555.58963825,
 -575606.24095295,
 1596227.59974823,
  -526998.78975019,
 1126511.63012933,
  627026.87458349,
  1401229.18857982,
-1042836.05034333,
 -331505.86802355,
   316818.84479534,
-1853950.52279611,
  -47760.53429585,
   -21925.52557843,
   83226.49139675,
 -470957.50553392,
   425445.50587532,
  448726.3837124 ,
-1752784.62170827,
  -444137.14867697,
  871164.35950756,
 -854916.03619932,
 -1127090.59662818,
  115440.69539755,
  809251.16968939,
   428725.84464923,
  440893.02485306,
  -46181.94422078,
  1034213.6849984 ,
 -438939.94800325,
  374775.98060035,
  -537032.9225166 ,
 -835484.07946609,
-1279648.98284374,
   570280.64376685,
  -60513.22166557,
 -123067.97183059,
  1802534.12834652,
  387639.45892284,
    5362.11202644,
  -670901.98212653,
 -256128.92192148,
  973872.18423444,
   113156.64157573,
 -213664.39149265,
 -398287.78418011,
 -2276737.60418871,
  114497.5267244 ,
  791043.1762462 ,
   -79014.90074663,
 -324921.3034286 ,
  639014.0709818 ,
   974079.26592658,
 -937719.69499885,
  836001.22365365,
   474179.40444145,
   55848.20126612,
 1357438.13097902,
  1231355.55794258,
  748785.85181893,
 -885626.77364269,
  1469142.07093161,
 -438030.7342994 ,
 1654211.54310647,
 -1525405.59243384,
  501193.54453664,
   77101.03754721,
   417359.46211623,
-1105421.766335  ,
   80238.85973543,
   240830.03158179,
 -165602.42119331,
  442628.32453117,
  -621264.0222014 ,
 -299945.57539354,
 -275481.08137866,
    35701.39239719,
 -222680.54018995,
  944291.24998843,
   428798.22135705,
-1000475.30130485,
-1322862.51071133,
   -29081.0236796 ,
  -83336.00996858,
  -77295.35032088,
  -406326.05961435,
  213903.59081896,
-1012203.63251357,
  -490568.85372027,
-1351308.60368748,
  211660.46666266,
  -589820.80925212,
  535064.13454509,
-1596752.89411516,
  -877465.49013947,
 -864423.40565053,
  677271.64499986,
  -494121.85185632,
 -441475.95387156,
  -63722.25956654,
   826255.74272403,
 -648625.23707148,
  540829.4484157 ,
  -519367.14619547,
  788703.42703051,
  -27802.93362078,
  -551100.36402858,
  448705.18262854,
 -248089.11022033,
   329110.14939429,
 -289774.75831172,
 -384151.73757016,
 -1501326.50561104,
-1531989.07705233,
  142462.75292108,
   -36361.42891263,
 -801381.2609595 ,
 1225477.12298435,
   737065.21028231,
   89224.46437287,
  272639.48142289,
   373345.40205967,
  504906.0746806 ,
  163778.80844375,
  -339669.63940682,
 -503624.1263373 ,
 -965356.98642932,
   160087.79806377,
  749232.62862394,
 -280851.80401124,
  -566462.16631444,
  650974.95521953,
  382141.05571719,
  -621846.05550462,
 -541867.29277345,
  871201.38622231,
   121793.20767555,
 -214177.51007481,
  658183.77616699,
   154911.58710842,
  195079.36970998,
  217117.53560852,
  -567317.02462343,
 -176022.75579398,
 -438039.41665785,
  -799511.68319848,
 -724663.96645317,
  287722.04982754,
  -831900.37817454,
  646790.72481806,
   62130.1551743 ,
   139124.03592359,
 -352955.05840012,
 -507879.60618963,
    54280.84237984,
  -28444.38494683,
  -19897.95534355,
   162156.63998425,
  585167.40866502,
  385091.73960004,
  -116051.13537863,
  139457.42107902,
   59381.97042546,
  -320952.60571018,
  -20001.87624445,
 -484289.83613591,
   182585.32344949,
 -446799.38935165,
  302720.32148714,
  -309874.46827888,
 -255787.71181154,
  467547.8632156 ,
   -34246.81086588,
 -302215.75134134,
 -831769.15854178,
   302438.83511277,
   78493.84716841,
 -846008.568551  ,
   247184.8138221 ,
 -104473.48823955,
  412218.13745299,
  -356307.92449822,
  174722.02745799,
 -865932.1602991 ,
   278185.09210118,
 -785962.38475349
};

