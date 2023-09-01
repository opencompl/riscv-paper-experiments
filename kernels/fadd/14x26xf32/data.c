#include "data.h"

const float X[N * M] = {+97.62700653076172f,  +430.37872314453125f, +205.52674865722656f,
                        +89.76636505126953f,  -152.69039916992188f, +291.7882385253906f,
                        -124.82557678222656f, +783.5460205078125f,  +927.3255004882812f,
                        -233.11695861816406f, +583.4500732421875f,  +57.78984069824219f,
                        +136.08912658691406f, +851.1932983398438f,  -857.9278564453125f,
                        -825.7413940429688f,  -959.563232421875f,   +665.2396850585938f,
                        +556.3134765625f,     +740.0242919921875f,  +957.2366943359375f,
                        +598.317138671875f,   -77.04127502441406f,  +561.058349609375f,
                        -763.451171875f,      +279.842041015625f,   -713.2933959960938f,
                        +889.3378295898438f,  +43.6966438293457f,   -170.67611694335938f,
                        -470.8887634277344f,  +548.4674072265625f,  -87.69933319091797f,
                        +136.86790466308594f, -962.42041015625f,    +235.27099609375f,
                        +224.1914520263672f,  +233.8679962158203f,  +887.4961547851562f,
                        +363.6405944824219f,  -280.98419189453125f, -125.93609619140625f,
                        +395.26239013671875f, -879.549072265625f,   +333.5334167480469f,
                        +341.2757263183594f,  -579.23486328125f,    -742.1473999023438f,
                        -369.143310546875f,   -272.5784606933594f,  +140.39353942871094f,
                        -122.7969741821289f,  +976.7476806640625f,  -795.910400390625f,
                        -582.2464599609375f,  -677.3809814453125f,  +306.2166442871094f,
                        -493.41680908203125f, -67.37845611572266f,  -511.1488037109375f,
                        -682.0608520507812f,  -779.2496948242188f,  +312.6591796875f,
                        -723.6340942382812f,  -606.8352661132812f,  -262.5496520996094f,
                        +641.9864501953125f,  -805.7974243164062f,  +675.8898315429688f,
                        -807.8031616210938f,  +952.9189453125f,     -62.69759750366211f,
                        +953.5221557617188f,  +209.6910400390625f,  +478.52716064453125f,
                        -921.6243896484375f,  -434.3860778808594f,  -759.6068725585938f,
                        -407.7196044921875f,  -762.5445556640625f,  -364.03363037109375f,
                        -171.47401428222656f, -871.7050170898438f,  +384.9442443847656f,
                        +133.20291137695312f, -469.22100830078125f, +46.4961051940918f,
                        -812.1189575195312f,  +151.8929901123047f,  +858.5924072265625f,
                        -362.8620910644531f,  +334.8207702636719f,  -736.404296875f,
                        +432.6544189453125f,  -421.18780517578125f, -633.6172485351562f,
                        +173.02586364746094f, -959.784912109375f,   +657.8800659179688f,
                        -990.6090698242188f,  +355.6330871582031f,  -459.9840393066406f,
                        +470.3880310058594f,  +924.3770751953125f,  -502.49371337890625f,
                        +152.31466674804688f, +184.0838623046875f,  +144.50381469726562f,
                        -553.8367309570312f,  +905.498046875f,      -105.7492446899414f,
                        +692.8173217773438f,  +398.95855712890625f, -405.1260986328125f,
                        +627.5956420898438f,  -206.988525390625f,   +762.2064208984375f,
                        +162.54574584960938f, +763.470703125f,      +385.06317138671875f,
                        +450.508544921875f,   +2.64876389503479f,   +912.1672973632812f,
                        +287.98040771484375f, -152.28990173339844f, +212.7864227294922f,
                        -961.6135864257812f,  -396.8503723144531f,  +320.3470764160156f,
                        -419.84478759765625f, +236.03085327148438f, -142.4626007080078f,
                        -729.0518798828125f,  -403.4353332519531f,  +139.92982482910156f,
                        +181.7455291748047f,  +148.65049743652344f, +306.4016418457031f,
                        +304.20654296875f,    -137.1631317138672f,  +793.0932006835938f,
                        -264.8762512207031f,  -128.27015686035156f, +783.8466796875f,
                        +612.3880004882812f,  +407.77716064453125f, -799.5462036132812f,
                        +838.9652099609375f,  +428.48260498046875f, +997.6940307617188f,
                        -701.1033935546875f,  +736.2521362304688f,  -675.01416015625f,
                        +231.11912536621094f, -752.3600463867188f,  +696.0164794921875f,
                        +614.637939453125f,   +138.20147705078125f, -185.63340759277344f,
                        -861.666015625f,      +394.8575439453125f,  -92.91463470458984f,
                        +444.1112060546875f,  +732.7646484375f,     +951.0430297851562f,
                        +711.606689453125f,   -976.5718383789062f,  -280.04388427734375f,
                        +459.9811096191406f,  -656.7406616210938f,  +42.073211669921875f,
                        -891.3240356445312f,  -600.0069580078125f,  -962.9564208984375f,
                        +587.3953857421875f,  -552.150634765625f,   -309.296630859375f,
                        +856.16259765625f,    +408.82879638671875f, -936.3221435546875f,
                        -670.6116943359375f,  +242.95680236816406f, +154.45718383789062f,
                        -524.21435546875f,    +868.427978515625f,   +227.93191528320312f,
                        +71.26560974121094f,  +179.8199462890625f,  +460.2440490722656f,
                        -376.1100158691406f,  -203.55787658691406f, -580.3125f,
                        -627.614013671875f,   +888.7447509765625f,  +479.1015930175781f,
                        -19.082382202148438f, -545.1707153320312f,  -491.28704833984375f,
                        -883.941650390625f,   -131.166748046875f,   -376.4082336425781f,
                        +392.6869812011719f,  -244.49632263183594f, -640.7926635742188f,
                        -950.6425170898438f,  -865.500732421875f,   +358.7855529785156f,
                        -92.60630798339844f,  +73.1584243774414f,   +793.3425903320312f,
                        +980.6779174804688f,  -566.2060546875f,     +326.1564025878906f,
                        -473.3552551269531f,  -958.697998046875f,   +516.75732421875f,
                        -359.9656982421875f,  -233.07220458984375f, +176.6342315673828f,
                        +662.096923828125f,   +257.96368408203125f, +745.3013305664062f,
                        -452.9159240722656f,  +596.0936889648438f,  -628.7280883789062f,
                        +905.5833129882812f,  +374.9765625f,        -568.984619140625f,
                        +894.7412109375f,     +461.71160888671875f, -492.1167297363281f,
                        -573.3760375976562f,  +36.40142822265625f,  -948.674560546875f,
                        -585.0598754882812f,  -150.62905883789062f, -251.6600341796875f,
                        -72.84915161132812f,  -444.7425842285156f,  +173.56869506835938f,
                        +727.711181640625f,   -764.936279296875f,   +34.75821304321289f,
                        -735.86376953125f,    +433.7193603515625f,  -207.88059997558594f,
                        +130.84262084960938f, -633.4403076171875f,  -710.3045043945312f,
                        -23.88743782043457f,  -288.7745361328125f,  +880.8638916015625f,
                        +530.6505126953125f,  +497.3272399902344f,  +807.439453125f,
                        -833.1551513671875f,  +104.38494110107422f, +168.95213317871094f,
                        +923.8727416992188f,  -415.7049560546875f,  -518.3424682617188f,
                        -799.412109375f,      -967.1407470703125f,  +859.0586547851562f,
                        +339.8330993652344f,  +570.3058471679688f,  -436.539794921875f,
                        +172.82032775878906f, -872.0894775390625f,  -28.744808197021484f,
                        +954.9902954101562f,  +753.010498046875f,   -323.6820983886719f,
                        +923.1403198242188f,  -536.5967407226562f,  +898.6376342773438f,
                        +882.7554321289062f,  +598.4051513671875f,  +260.8958740234375f,
                        +748.575927734375f,   -413.9594421386719f,  +697.8870849609375f,
                        +235.75338745117188f, -973.5263061523438f,  -305.532958984375f,
                        -703.71826171875f,    +963.6587524414062f,  -43.25938415527344f,
                        -5.217268943786621f,  +278.9450378417969f,  -262.8307800292969f,
                        -726.199462890625f,   +644.2354736328125f,  -620.30419921875f,
                        +22.637964248657227f, -551.365966796875f,   -804.31103515625f,
                        +724.383056640625f,   +945.8389892578125f,  +921.6693115234375f,
                        +813.1110229492188f,  +548.0946655273438f,  -333.7096862792969f,
                        -837.7972412109375f,  -185.5176544189453f,  -535.53173828125f,
                        -735.0247192382812f,  -893.1456298828125f,  +451.188720703125f,
                        -977.1450805664062f,  +541.1614990234375f,  -706.106689453125f,
                        -840.955810546875f,   -820.7939453125f,     +344.0956115722656f,
                        -509.2655944824219f,  -158.9210662841797f,  +114.73757934570312f,
                        +721.1023559570312f,  +454.0885314941406f,  -459.34417724609375f,
                        -737.034423828125f,   -889.2513427734375f,  -396.802734375f,
                        -475.7637023925781f,  -87.71886444091797f,  +366.56268310546875f,
                        +391.2508850097656f,  -432.9623107910156f,  -240.14608764648438f,
                        -637.6980590820312f,  +577.0910034179688f,  -886.3038330078125f,
                        +393.9944763183594f,  +557.3908081054688f,  +554.8151245117188f,
                        -481.1548767089844f,  -252.37371826171875f, +175.1992645263672f,
                        -454.356201171875f,   -258.2944030761719f,  -605.8914184570312f,
                        -80.2882308959961f,   -910.775390625f,      +599.591796875f,
                        -846.0870971679688f,  +37.6702995300293f,   -386.3797912597656f,
                        +155.0858917236328f,  +918.86669921875f,    +291.1405029296875f,
                        -929.275146484375f,   -139.1951141357422f,  +20.03370475769043f,
                        +72.35498809814453f,  +362.7850341796875f,  -444.80780029296875f,
                        -742.2788696289062f,  -214.64865112304688f, +912.8114624023438f,
                        -625.7382202148438f,  +807.9678955078125f,  +87.61190032958984f,
                        -86.17715454101562f};

const float Y[N * M] = {+764.0828247070312f,  -82.79207611083984f,  +448.33526611328125f,
                        -201.94935607910156f, +808.0888061523438f,  +380.050048828125f,
                        +399.2441101074219f,  -344.5592041015625f,  +513.5573120117188f,
                        +272.1221008300781f,  -519.95947265625f,    -678.92236328125f,
                        +592.782958984375f,   +918.3331909179688f,  -83.72234344482422f,
                        +181.9683380126953f,  +715.4453125f,        -85.55309295654297f,
                        +903.7489624023438f,  +151.5023193359375f,  +641.5342407226562f,
                        +817.6874389648438f,  +631.047607421875f,   -681.1710815429688f,
                        +257.796875f,         -203.13148498535156f, -874.5740966796875f,
                        -151.9355010986328f,  -482.6318664550781f,  +698.0765991210938f,
                        -933.3907470703125f,  +917.9654541015625f,  -289.2622985839844f,
                        -286.5862121582031f,  -967.343017578125f,   -629.5353393554688f,
                        -197.4810028076172f,  +858.5828247070312f,  -800.7701416015625f,
                        +890.6030883789062f,  +738.97705078125f,    -91.67520904541016f,
                        -346.5982360839844f,  -534.51171875f,       +228.92941284179688f,
                        -933.850830078125f,   -968.787841796875f,   -142.40855407714844f,
                        -863.8518676757812f,  -496.1180114746094f,  -557.6781616210938f,
                        -493.61761474609375f, -737.8895263671875f,  -975.9275512695312f,
                        -769.0314331054688f,  +236.9605255126953f,  +948.512451171875f,
                        +980.6900024414062f,  -181.89181518554688f, -674.0911254882812f,
                        +277.5235290527344f,  -19.389307022094727f, +978.819580078125f,
                        -869.3916015625f,     +566.4688720703125f,  -423.2030029296875f,
                        -517.1627807617188f,  +325.0091552734375f,  -507.8736267089844f,
                        +331.7182312011719f,  +34.617034912109375f, -151.822021484375f,
                        +109.37561798095703f, -425.89697265625f,    +413.1494140625f,
                        -170.2862548828125f,  -278.90887451171875f, +657.3138427734375f,
                        +849.933837890625f,   -907.9853515625f,     -534.7460327148438f,
                        -302.9612731933594f,  +629.9329833984375f,  +970.9828491210938f,
                        +937.9434204101562f,  +809.8966674804688f,  -406.8874816894531f,
                        +984.0224609375f,     -501.159912109375f,   -788.1876831054688f,
                        +901.9052124023438f,  -533.1594848632812f,  +379.5365295410156f,
                        -883.2872924804688f,  +461.418212890625f,   +763.4404296875f,
                        -455.126220703125f,   -241.88621520996094f, -251.4076385498047f,
                        +497.5765075683594f,  -524.385498046875f,   -656.2938232421875f,
                        -101.41670227050781f, -391.06317138671875f, +678.3782348632812f,
                        -524.516357421875f,   +4.778914928436279f,  +885.1671752929688f,
                        +267.9953918457031f,  +734.5787963867188f,  +880.4193725585938f,
                        +501.52972412109375f, +399.1501159667969f,  +935.93115234375f,
                        +988.8015747070312f,  -96.35663604736328f,  -858.2604370117188f,
                        -414.41192626953125f, -695.2905883789062f,  -165.02725219726562f,
                        -737.4213256835938f,  +208.23561096191406f, -234.38388061523438f,
                        +790.7717895507812f,  +935.58935546875f,    +93.76980590820312f,
                        -450.3528747558594f,  +184.46083068847656f, +793.5223388671875f,
                        -186.53330993652344f, +104.15655517578125f, -456.6944580078125f,
                        -89.11170196533203f,  -196.5729217529297f,  -503.1730651855469f,
                        +11.732768058776855f, -379.23834228515625f, -253.93026733398438f,
                        +49.94088363647461f,  +501.1900329589844f,  -332.9850769042969f,
                        +848.3175048828125f,  +724.6370849609375f,  -902.619384765625f,
                        -492.7149658203125f,  -107.72897338867188f, -790.7442016601562f,
                        -303.04803466796875f, +480.1950378417969f,  +361.0289611816406f,
                        +244.76885986328125f, +421.0567932128906f,  -590.1526489257812f,
                        -316.603759765625f,   +352.4849548339844f,  +758.4695434570312f,
                        +87.35610961914062f,  -434.6007080078125f,  -939.5294799804688f,
                        +420.67364501953125f, -984.2318115234375f,  -254.64186096191406f,
                        +61.07442855834961f,  +844.222900390625f,   -821.0109252929688f,
                        -188.1153564453125f,  -951.3735961914062f,  -314.7780456542969f,
                        +244.4621124267578f,  -441.8641052246094f,  -580.5001220703125f,
                        -768.593505859375f,   +154.28048706054688f, +390.5400085449219f,
                        +343.9142761230469f,  +897.7220458984375f,  -994.5935668945312f,
                        +294.393310546875f,   +200.7844696044922f,  +177.47921752929688f,
                        +925.5406494140625f,  -966.2566528320312f,  +392.9648742675781f,
                        +627.3572998046875f,  +19.61439323425293f,  -332.07025146484375f,
                        +581.6802978515625f,  -805.51416015625f,    -115.92872619628906f,
                        +39.90475082397461f,  +387.9128112792969f,  -818.228515625f,
                        -544.4810180664062f,  -179.39688110351562f, +246.58934020996094f,
                        +773.9215698242188f,  +237.65234375f,       -733.0770874023438f,
                        +961.1602783203125f,  +743.5714721679688f,  +5.441522121429443f,
                        +844.6959838867188f,  +82.76158905029297f,  +846.6121215820312f,
                        +659.7947387695312f,  +936.5728149414062f,  +839.5656127929688f,
                        -927.932373046875f,   -650.4559936523438f,  -221.73065185546875f,
                        +904.285400390625f,   -399.9421691894531f,  -679.064697265625f,
                        +772.6093139648438f,  -107.21116638183594f, +815.7511596679688f,
                        -679.5390625f,        +322.2350158691406f,  -119.47249603271484f,
                        -847.0264892578125f,  +392.9263000488281f,  -505.2024841308594f,
                        -920.7689819335938f,  -880.1113891601562f,  -877.8428955078125f,
                        +815.4659423828125f,  +479.767822265625f,   +796.1246948242188f,
                        +345.16461181640625f, +57.879859924316406f, -391.1072692871094f,
                        +995.9244995117188f,  -275.62188720703125f, -58.70210266113281f,
                        -243.5096435546875f,  +959.0538330078125f,  -650.6832275390625f,
                        -344.02398681640625f, +360.69732666015625f, -873.5847778320312f,
                        +214.49874877929688f, -44.706993103027344f, -432.00006103515625f,
                        -523.1734619140625f,  +29.02548599243164f,  -264.14483642578125f,
                        -86.96022033691406f,  -325.04522705078125f, +940.9873657226562f,
                        -733.1211547851562f,  -806.39208984375f,    -313.216552734375f,
                        +182.05380249023438f, +318.3529357910156f,  -205.48651123046875f,
                        +998.5559692382812f,  -296.2140197753906f,  +442.8133239746094f,
                        +275.1653747558594f,  +626.1077270507812f,  +952.4513549804688f,
                        +779.5873413085938f,  +529.1239624023438f,  +396.4969482421875f,
                        -329.003662109375f,   -704.6288452148438f,  -874.7279663085938f,
                        -516.1965942382812f,  -135.43704223632812f, +43.99254608154297f,
                        +546.1671142578125f,  +917.4818725585938f,  -765.3590087890625f,
                        -785.99169921875f,    +179.3894500732422f,  +490.796142578125f,
                        +696.30078125f,       +871.6641845703125f,  +966.8524780273438f,
                        -200.39662170410156f, -239.3296356201172f,  -704.3826293945312f,
                        +369.8688659667969f,  +313.52392578125f,    +724.1251831054688f,
                        -805.4840087890625f,  -4.446184158325195f,  +162.1638641357422f,
                        -516.8859252929688f,  -661.9491577148438f,  +719.1616821289062f,
                        -882.93017578125f,    -58.75819396972656f,  -768.3319702148438f,
                        -85.88247680664062f,  +959.9246826171875f,  -152.58729553222656f,
                        +714.2498168945312f,  -765.368896484375f,   -457.495849609375f,
                        -192.41452026367188f, -200.37571716308594f, +342.7669677734375f,
                        -310.5637512207031f,  +427.5337219238281f,  +278.3738098144531f,
                        -201.67770385742188f, -136.47975158691406f, +229.05540466308594f,
                        -859.9156494140625f,  +644.8134765625f,     +306.8423156738281f,
                        +452.6849365234375f,  +73.84600067138672f,  -779.0457763671875f,
                        -189.92877197265625f, -189.25283813476562f, -357.9140319824219f,
                        -940.099365234375f,   +474.50848388671875f, -780.4310913085938f,
                        +212.61627197265625f, +406.43499755859375f, +269.5726318359375f,
                        +918.2844848632812f,  -793.4036865234375f,  +734.3342895507812f,
                        -941.6195068359375f,  +69.83370971679688f,  -191.5127716064453f,
                        +48.36772155761719f,  -269.80023193359375f, -618.8661499023438f,
                        -961.7542114257812f,  +36.29962921142578f,  +685.5537109375f,
                        -253.56808471679688f, -554.2723388671875f,  -838.9359741210938f,
                        -829.378173828125f,   -557.2070922851562f,  -799.9718627929688f,
                        -469.92059326171875f, -867.7010498046875f,  -868.790283203125f,
                        +712.5523681640625f,  -675.7594604492188f,  +119.36481475830078f,
                        +546.9110717773438f,  -87.18087005615234f,  -693.2622680664062f,
                        -600.8077392578125f,  -134.03158569335938f, +56.468177795410156f,
                        -301.1194152832031f,  +562.959228515625f,   +502.0433044433594f,
                        +854.4236450195312f,  -942.0949096679688f,  +791.382568359375f,
                        -214.8624267578125f,  +756.7449951171875f,  +381.5695495605469f,
                        +974.697509765625f};

const float G[N * M] = {+861.7098388671875f,  +347.5866394042969f,  +653.8619995117188f,
                        -112.18299102783203f, +655.3984375f,        +671.8382568359375f,
                        +274.41851806640625f, +438.98681640625f,    +1440.8828125f,
                        +39.00514221191406f,  +63.4906005859375f,   -621.1325073242188f,
                        +728.8720703125f,     +1769.5264892578125f, -941.6502075195312f,
                        -643.7730712890625f,  -244.117919921875f,   +579.6865844726562f,
                        +1460.0625f,          +891.526611328125f,   +1598.77099609375f,
                        +1416.004638671875f,  +554.00634765625f,    -120.11273193359375f,
                        -505.654296875f,      +76.71055603027344f,  -1587.867431640625f,
                        +737.40234375f,       -438.9352111816406f,  +527.4005126953125f,
                        -1404.279541015625f,  +1466.432861328125f,  -376.9616394042969f,
                        -149.7183074951172f,  -1929.763427734375f,  -394.26434326171875f,
                        +26.71044921875f,     +1092.4508056640625f, +86.72601318359375f,
                        +1254.24365234375f,   +457.99285888671875f, -217.61129760742188f,
                        +48.664154052734375f, -1414.060791015625f,  +562.4628295898438f,
                        -592.5750732421875f,  -1548.022705078125f,  -884.5559692382812f,
                        -1232.9951171875f,    -768.6964721679688f,  -417.28460693359375f,
                        -616.4146118164062f,  +238.858154296875f,   -1771.837890625f,
                        -1351.27783203125f,   -440.42047119140625f, +1254.7291259765625f,
                        +487.273193359375f,   -249.270263671875f,   -1185.239990234375f,
                        -404.5373229980469f,  -798.6389770507812f,  +1291.478759765625f,
                        -1593.025634765625f,  -40.36639404296875f,  -685.752685546875f,
                        +124.82366943359375f, -480.78826904296875f, +168.01620483398438f,
                        -476.0849304199219f,  +987.5360107421875f,  -214.51962280273438f,
                        +1062.8978271484375f, -216.2059326171875f,  +891.6765747070312f,
                        -1091.91064453125f,   -713.294921875f,      -102.29302978515625f,
                        +442.2142333984375f,  -1670.5299072265625f, -898.7796630859375f,
                        -474.435302734375f,   -241.77203369140625f, +1355.9271240234375f,
                        +1071.1463623046875f, +340.6756591796875f,  -360.3913879394531f,
                        +171.90350341796875f, -349.26690673828125f, +70.40472412109375f,
                        +539.0430908203125f,  -198.33871459960938f, -356.8677673339844f,
                        -450.63287353515625f, +40.23040771484375f,  +129.82318115234375f,
                        -282.100341796875f,   -1201.671142578125f,  +406.472412109375f,
                        -493.0325622558594f,  -168.75241088867188f, -1116.27783203125f,
                        +368.9713134765625f,  +533.3139038085938f,  +175.884521484375f,
                        -372.2016906738281f,  +188.86277770996094f, +1029.6710205078125f,
                        -285.8413391113281f,  +1640.076904296875f,  +774.6701049804688f,
                        +1194.3470458984375f, +798.108642578125f,   +530.8050537109375f,
                        +1616.397216796875f,  -303.34515380859375f, -96.05401611328125f,
                        -251.86618041992188f, +68.18011474609375f,  +220.03591918945312f,
                        -286.91278076171875f, +210.88436889648438f, +677.783447265625f,
                        +1078.752197265625f,  +783.2994384765625f,  +306.55621337890625f,
                        -1411.9664306640625f, -212.38954162597656f, +1113.869384765625f,
                        -606.3781127929688f,  +340.1874084472656f,  -599.1570434570312f,
                        -818.16357421875f,    -600.0082397460938f,  -363.24322509765625f,
                        +193.47830200195312f, -230.5878448486328f,  +52.47137451171875f,
                        +354.1474304199219f,  +364.02691650390625f, +460.1081237792969f,
                        +583.4412841796875f,  +596.366943359375f,   -118.772705078125f,
                        +119.67303466796875f, +300.0481872558594f,  -1590.2904052734375f,
                        +535.9171752929688f,  +908.6776123046875f,  +1358.7230224609375f,
                        -456.33453369140625f, +1157.3089599609375f, -1265.166748046875f,
                        -85.48463439941406f,  -399.8750915527344f,  +1454.486083984375f,
                        +701.9940185546875f,  -296.39923095703125f, -1125.162841796875f,
                        -440.99237060546875f, -589.374267578125f,   -347.5564880371094f,
                        +505.1856384277344f,  +1576.987548828125f,  +130.0321044921875f,
                        +523.4913330078125f,  -1927.9454345703125f, -594.8218994140625f,
                        +704.4432373046875f,  -1098.604736328125f,  -538.4268798828125f,
                        -1659.91748046875f,   -445.7264709472656f,  -572.4163818359375f,
                        +931.3096923828125f,  +345.5714111328125f,  -1303.89013671875f,
                        +1150.555908203125f,  +609.61328125f,       -758.8428955078125f,
                        +254.928955078125f,   -723.2998657226562f,  +547.4220581054688f,
                        +103.1429443359375f,  +888.0423583984375f,  -104.13833618164062f,
                        +652.9459228515625f,  -625.6942138671875f,  +344.3153076171875f,
                        -336.20526123046875f, +184.3549346923828f,  -1398.541015625f,
                        -1172.094970703125f,  +709.347900390625f,   +725.69091796875f,
                        +754.8391723632812f,  -307.51837158203125f, -1224.3641357421875f,
                        +77.2186279296875f,   +612.4047241210938f,  -370.9667053222656f,
                        +1237.3829345703125f, -161.7347412109375f,  +205.8194580078125f,
                        -290.8477783203125f,  +71.07208251953125f,  +1198.3511962890625f,
                        -1020.5386962890625f, -577.2975463867188f,  +571.6119384765625f,
                        +1884.96337890625f,   -966.148193359375f,   -352.9082946777344f,
                        +299.2540588378906f,  -1065.9091796875f,    +1332.508544921875f,
                        -1039.5047607421875f, +89.16281127929688f,  +57.16173553466797f,
                        -184.9295654296875f,  +650.8900146484375f,  +240.09884643554688f,
                        -1373.6849365234375f, -284.0177001953125f,  -1506.571044921875f,
                        +1721.04931640625f,   +854.744384765625f,   +227.14007568359375f,
                        +1239.90576171875f,   +519.5914916992188f,  -883.2239990234375f,
                        +422.5484619140625f,  -239.220458984375f,   -1007.3766479492188f,
                        -828.5695190429688f,  +808.4248046875f,     -902.34326171875f,
                        -416.8731384277344f,  -84.04525756835938f,  -700.01611328125f,
                        +942.2099609375f,     -809.6432495117188f,  -397.2418518066406f,
                        -1259.0372314453125f, +462.7448425292969f,  -472.02545166015625f,
                        +43.88240051269531f,  -958.4855346679688f,  +230.682861328125f,
                        -757.0086059570312f,  -1095.1666259765625f, +567.6473388671875f,
                        +712.704345703125f,   +815.68017578125f,    +601.9529418945312f,
                        +165.40081787109375f, -191.82907104492188f, +611.7654418945312f,
                        +1199.0380859375f,    +210.40277099609375f, +434.10888671875f,
                        -19.82476806640625f,  -438.01678466796875f, +1255.5556640625f,
                        +10.829437255859375f, -134.322998046875f,   -1311.267822265625f,
                        -343.37628173828125f, -1007.5264892578125f, +15.247737884521484f,
                        +1501.157470703125f,  +1670.492431640625f,  -1089.0411376953125f,
                        +137.14862060546875f, -357.207275390625f,   +1389.433837890625f,
                        +1579.05615234375f,   +1470.0693359375f,    +1227.748291015625f,
                        +548.1793212890625f,  -653.2890625f,        -6.49554443359375f,
                        +605.6222534179688f,  -660.0023803710938f,  +418.59222412109375f,
                        -1509.2022705078125f, +959.2125854492188f,  +118.90447998046875f,
                        -522.1032104492188f,  -383.0041198730469f,  +456.3309020996094f,
                        -1609.129638671875f,  +585.477294921875f,   -1388.63623046875f,
                        -63.24451446533203f,  +408.5587158203125f,  -956.8983154296875f,
                        +1438.6328125f,       +180.4700927734375f,  +464.1734619140625f,
                        +620.696533203125f,   +347.71893310546875f, +9.057281494140625f,
                        -1148.3609619140625f, +242.0160675048828f,  -257.1579284667969f,
                        -936.702392578125f,   -1029.6253662109375f, +680.244140625f,
                        -1837.060791015625f,  +1185.9749755859375f, -399.2643737792969f,
                        -388.2708740234375f,  -746.9479370117188f,  -434.9501647949219f,
                        -699.1943359375f,     -348.17388916015625f, -243.17645263671875f,
                        -218.99700927734375f, +928.5970458984375f,  -1239.7752685546875f,
                        -524.4181518554688f,  -482.81634521484375f, -127.2301025390625f,
                        +442.5207824707031f,  -881.12255859375f,    +1100.89697265625f,
                        -550.36865234375f,    -363.12860107421875f, -431.65887451171875f,
                        -589.330322265625f,   +307.290771484375f,   -1505.169921875f,
                        -567.759765625f,      +593.6904296875f,     +1240.368896484375f,
                        -734.7229614257812f,  -806.6460571289062f,  -663.7366943359375f,
                        -1283.734375f,        -815.50146484375f,    -1405.86328125f,
                        -550.2088012695312f,  -1778.4764404296875f, -269.198486328125f,
                        -133.53472900390625f, -638.0891723632812f,  -267.0149841308594f,
                        +701.9969482421875f,  +831.6858520507812f,  -402.12176513671875f,
                        -1530.0828857421875f, -273.2266845703125f,  +76.50188446044922f,
                        -228.76443481445312f, +925.7442626953125f,  +57.235504150390625f,
                        +112.144775390625f,   -1156.7435302734375f, +1704.194091796875f,
                        -840.6006469726562f,  +1564.712890625f,     +469.18145751953125f,
                        +888.5203857421875f};
