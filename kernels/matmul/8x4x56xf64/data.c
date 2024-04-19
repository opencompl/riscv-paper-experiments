#define M 8
#define K 4
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


const double G_IN[M * N] = {
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
 -96.35663466
};


const double G_OUT[M * N] = {
1.48883002e+05,
 5.01941110e+05,
-4.36402038e+05,
 2.81976709e+05,
 -2.92316688e+05,
 3.36397043e+05,
-2.06515311e+05,
-9.41876828e+04,
 -8.51312883e+04,
-3.06649131e+05,
 2.55127647e+05,
-4.19981065e+05,
  3.41221193e+05,
-1.78736904e+05,
 2.16845758e+04,
 1.94670619e+05,
 -2.03459987e+05,
-1.07651366e+03,
 2.00064526e+05,
 2.60239839e+05,
  7.56186448e+04,
 5.25161944e+05,
-3.43723461e+05,
 2.27995829e+05,
  2.39698080e+05,
-2.76215311e+05,
 3.05833312e+05,
-3.73252001e+05,
  2.18450048e+05,
-1.62586716e+05,
 4.35655484e+05,
-6.98748366e+04,
  7.43446810e+04,
 6.63132817e+04,
 4.86759170e+05,
-1.60687627e+05,
 -1.59976484e+05,
 5.61100646e+04,
-3.29005264e+05,
-2.69076380e+05,
  4.74769262e+05,
-1.82040203e+05,
 1.66066943e+05,
-1.80386314e+05,
 -2.22650356e+05,
-3.43749495e+05,
-9.67294806e+03,
-1.72356916e+05,
 -1.64316419e+05,
 2.95644794e+05,
 1.18368028e+05,
 5.36988708e+04,
  2.89922039e+05,
-2.16135123e+05,
-1.59858223e+05,
 1.56318624e+05,
 -3.13663418e+05,
 4.86416029e+05,
-5.06968258e+04,
-5.45041701e+05,
 -1.04746373e+06,
-7.12163309e+05,
 1.10230827e+05,
-4.04870890e+05,
  2.34972520e+05,
 3.31946129e+05,
 9.93928901e+05,
-6.85278487e+05,
  2.31678205e+05,
-5.74474151e+05,
-5.02314889e+05,
 8.95502216e+05,
 -4.21595116e+05,
-8.49609354e+04,
 1.15241363e+05,
 4.88230046e+05,
 -2.27331110e+05,
 8.80892684e+05,
-1.74932258e+05,
 8.07608963e+05,
 -4.80399743e+05,
 7.48673198e+05,
 4.81972627e+05,
-3.16914903e+05,
  1.10251408e+06,
 6.48386766e+05,
-2.83886342e+05,
-1.57495104e+05,
  2.91241340e+05,
-8.09339460e+05,
-3.41319098e+05,
 2.05918978e+05,
 -2.61116014e+05,
 9.80244824e+04,
-7.93845584e+05,
 9.52114719e+04,
  4.09673005e+05,
-7.82338077e+05,
 1.41434109e+04,
-4.99874965e+05,
  1.35986673e+05,
-1.17668865e+05,
 2.31015188e+05,
-2.54427354e+05,
 -3.79255050e+05,
-1.40681610e+04,
-6.42073824e+04,
 5.93779472e+05,
  6.94916786e+05,
 4.45361730e+05,
 6.98477278e+05,
-2.83722391e+05,
  2.18810576e+05,
 1.87379580e+05,
-1.28851240e+06,
 5.92583421e+05,
  5.74627502e+05,
 6.48100177e+05,
 5.32859192e+05,
 9.09134790e+05,
 -6.90508316e+05,
 2.87652004e+05,
-1.69117399e+05,
-2.11330615e+05,
  6.03849027e+05,
 4.76982327e+05,
-8.10505545e+05,
-1.37657598e+06,
 -1.55988878e+04,
-3.55956350e+05,
 3.56601819e+05,
 3.18235009e+05,
  1.60466558e+06,
-4.90897137e+05,
-1.11123493e+06,
-9.18603591e+05,
  4.23000436e+05,
-6.93958086e+05,
-1.62567495e+05,
-9.78673408e+05,
 -1.10854281e+06,
-1.29566507e+06,
 4.26235409e+05,
-1.11609676e+06,
 -8.46110541e+05,
 2.00617905e+05,
 5.87409447e+05,
-1.36937171e+06,
  2.56459401e+05,
-6.61157410e+05,
 1.17225093e+06,
-2.61450929e+05,
  1.35828581e+06,
 3.81106140e+05,
 4.32316245e+05,
-7.59044878e+05,
  6.07310682e+04,
-8.41810020e+05,
-5.21913294e+05,
-1.12468479e+06,
 -7.79460450e+05,
 2.86718112e+05,
-6.16426379e+05,
 4.28715034e+05,
 -3.48774724e+05,
-6.31274473e+05,
-3.96055068e+05,
-1.06050377e+06,
 -9.72134908e+04,
 7.53530093e+04,
 4.48003013e+05,
 1.26372357e+05,
 -1.78934615e+05,
 2.58829691e+05,
 6.74984055e+04,
-1.04502559e+06,
  6.27743070e+05,
-1.68748036e+06,
 4.49458308e+05,
-1.09248899e+06,
 -4.48533102e+05,
-7.27892946e+04,
 1.27246028e+06,
 9.98364768e+05,
 -5.19476376e+05,
 3.64725689e+05,
-3.51072595e+05,
-1.06909072e+06,
 -1.36743498e+06,
-5.63494281e+05,
 1.04256918e+06,
 2.45575511e+05,
  5.05799790e+05,
-5.96330791e+05,
 1.79306268e+05,
 9.88776882e+05,
  3.31901755e+05,
 4.77203197e+05,
 5.94828907e+05,
 1.17645022e+06,
  5.36182221e+05,
 1.53585643e+04,
 9.96160529e+05,
 1.06314424e+06,
  7.45495689e+05,
-7.70957048e+04,
-4.54107885e+05,
-3.99135663e+04,
 -9.43508595e+05,
 1.07258030e+05,
 1.76188173e+05,
 2.06674380e+05,
 -1.43267552e+06,
 4.75551882e+04,
 1.30216926e+05,
 1.07185073e+06,
  1.20196464e+06,
-5.05282813e+05,
-3.22725408e+04,
-7.75360084e+05,
  7.22740149e+05,
-2.78491612e+05,
-1.12330669e+04,
 1.35718679e+06,
  2.47326763e+05,
 9.57286189e+05,
 5.63813560e+04,
-1.04957729e+04,
 -1.17013914e+06,
-2.20531606e+04,
-1.25632277e+06,
-4.29387427e+05,
  6.33453096e+04,
 1.98024106e+05,
 3.65546103e+05,
 1.53187589e+05,
  4.99829865e+05,
-9.06886327e+05,
 5.60030895e+04,
 1.23012620e+06,
 -2.67812144e+04,
 1.38713257e+05,
 3.65522092e+05,
 1.11157580e+06,
 -5.85707846e+05,
 2.31351702e+06,
-3.90095176e+05,
 1.39621106e+06,
 -2.37811536e+05,
 5.08758607e+05,
 7.83053071e+05,
-5.64135433e+05,
  1.48986867e+06,
 6.61843397e+05,
 1.70472455e+05,
 2.19050913e+05,
  7.36865023e+05,
 2.79476350e+04,
-2.14738232e+05,
 3.32431758e+05,
 -1.30917316e+06,
 9.97942198e+05,
-1.79728319e+06,
-3.67020783e+05,
  3.19784991e+05,
-9.19779060e+05,
-2.36792017e+05,
 3.45064289e+05,
  5.08829503e+05,
 9.74378369e+04,
 4.67904328e+05,
 6.10171263e+04,
 -4.26591211e+05,
 8.45114120e+05,
 1.09165683e+06,
 1.80620209e+05,
  4.89188883e+05,
 3.68765652e+05,
-2.41702063e+04,
 6.11200561e+05,
 -2.51434979e+05,
 8.33630145e+05,
-1.21394936e+06,
 1.38200511e+03,
 -7.92375801e+05,
-7.97284709e+04,
 8.52853523e+05,
-1.39693295e+05,
 -7.23939480e+04,
-2.67500625e+05,
 1.38016087e+06,
-1.80593160e+06,
  6.67692082e+05,
-2.24761814e+05,
-7.96607737e+05,
 1.98974777e+05,
 -8.86390193e+05,
-2.93398473e+05,
 3.09417591e+05,
 2.83935217e+05,
  6.75071817e+05,
 1.43234804e+05,
-7.99495207e+05,
 1.22128844e+05,
  1.43634855e+05,
-1.56029321e+05,
 5.18146446e+05,
-8.63700022e+05,
  3.51374805e+05,
-3.15437965e+05,
 4.34726562e+05,
-7.41458239e+05,
 -2.67086068e+05,
-8.47959010e+05,
 8.00548884e+05,
-6.11411514e+05,
  4.66337681e+05,
-7.05535404e+05,
 7.53929460e+04,
-1.59690504e+05,
  1.44579920e+06,
-4.97210430e+05,
 6.13296049e+05,
-1.39416660e+06,
 -6.44130427e+05,
-1.05616300e+06,
-2.17469049e+05,
-9.31883141e+05,
 -6.09696297e+05,
-6.26881430e+04,
-8.51345984e+05,
 7.82101872e+05,
  9.41754501e+05,
-2.90756593e+05,
 4.88882210e+05,
-7.65744556e+05,
 -6.62106200e+05,
 1.94144910e+05,
 9.86088126e+05,
-1.25423051e+06,
 -1.52831229e+06,
-1.53884303e+06,
 2.37479818e+04,
-1.06245667e+06,
  8.09483316e+05,
 3.68251708e+05,
 1.29114639e+06,
-6.05733731e+05,
 -3.03469349e+05,
-9.08821167e+05,
-1.46343432e+05,
 1.89946539e+06,
 -4.60576398e+05,
 1.09719847e+05,
-2.15363303e+05,
 2.00339356e+05,
 -1.34964180e+06,
 1.01627539e+06,
 7.08710660e+05,
 1.44090880e+06,
 -1.00938929e+06,
 1.53714659e+06,
 5.30538093e+05,
 4.62069054e+05,
  1.95772572e+06,
 1.73789431e+06,
-8.81692097e+05,
 5.44136549e+05,
  8.42352750e+05,
-1.25320225e+06,
-1.04679330e+06,
 1.22968831e+06,
 -3.04093860e+05,
 4.38177861e+05,
-1.50230666e+06,
 4.65090995e+05,
 -6.10583887e+05,
-1.12044820e+06,
-3.19202245e+05,
-1.18947703e+05,
  1.85047160e+05,
 5.50425290e+05,
 6.11992037e+05,
 4.83616203e+05,
  1.35492843e+05,
-4.38523720e+05,
 1.52075844e+05,
 4.64726791e+05,
  9.81041186e+05,
 1.07682755e+06,
 1.27720338e+06,
 1.91970433e+05,
 -5.24570937e+05,
-1.17202245e+05,
 2.62276440e+05,
-7.93378527e+05,
 -5.87681032e+05,
-1.00812636e+06,
 6.37591191e+05,
-2.73451186e+05,
  3.16172135e+05,
 4.84600505e+05,
 7.97134954e+05,
-5.07651909e+05,
 -1.56663729e+05,
-2.31276538e+05,
-5.43996519e+05,
 4.98974932e+05,
 -3.13730075e+05,
-1.21987287e+05,
-1.37532860e+05,
-1.19412583e+04,
 -1.69143511e+05,
-1.15639646e+05,
 2.04053754e+05,
 3.10960796e+05,
 -6.16148866e+05,
 8.53519398e+05,
 7.57908026e+04,
 1.20637470e+05,
  6.13378689e+05,
 6.44885850e+05,
-6.63151933e+05,
-1.51817996e+05,
  6.22015935e+04,
-9.35399023e+05,
-6.41031654e+05,
 2.73926439e+05,
  2.33282560e+05,
-2.25976864e+05,
-1.10895115e+05,
 4.07036629e+05,
 -2.28170121e+04,
-4.46052906e+05,
-3.38692277e+04,
-5.04229410e+05,
  1.26607692e+05,
 9.87547660e+04,
 1.25917372e+05,
-1.38498971e+05,
 -1.35320593e+05,
-4.91389704e+05,
-4.73998343e+05,
 5.32342031e+05,
  4.18217728e+05,
 5.28813988e+05,
 8.83016805e+05,
-5.64464249e+05
};

