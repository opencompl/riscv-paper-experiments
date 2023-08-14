
memref.global constant @A : memref<12x12xf32> = dense<[
  [1.1176220178604126, -1.3871248960494995, -0.4265716075897217,
 -0.8035872578620911, 0.6014277338981628, -0.07499324530363083,
 0.059693194925785065, -0.03200608864426613, -0.18548467755317688,
 1.2047736644744873, 0.7774530649185181, -1.3582810163497925],
  [0.7698278427124023, -0.8702269792556763, 1.0997635126113892,
 -0.9584742188453674, -1.2749319076538086, -1.3653380870819092,
 -1.474327564239502, 0.4335317015647888, -0.328120619058609,
 -0.9709680080413818, 1.2655024528503418, 0.003763606771826744],
  [-1.0665411949157715, 1.7288987636566162, -0.45138227939605713,
 0.04862817004323006, -1.1382405757904053, -0.33829328417778015,
 -1.5297398567199707, 0.20406699180603027, -0.05367063730955124,
 -0.9068519473075867, -0.02107640542089939, -1.2441277503967285],
  [0.08321687579154968, -0.24711604416370392, 1.314589262008667,
 0.9204949736595154, -0.22877256572246552, -0.030402617529034615,
 0.007356334012001753, -0.1641322374343872, -0.015097764320671558,
 1.2274370193481445, 1.0408066511154175, 0.6799344420433044],
  [0.2518334984779358, 1.6651910543441772, 1.0347177982330322,
 -0.38181933760643005, -0.3505185842514038, 1.2286534309387207,
 -0.35867178440093994, -1.9132933616638184, 1.0271670818328857,
 -1.3551664352416992, -1.6714682579040527, -1.0570014715194702],
  [-1.3222408294677734, 0.7736058831214905, -1.7251851558685303,
 -0.1460547000169754, 0.40561553835868835, -1.415915608406067,
 0.8947690725326538, 1.4356279373168945, 0.2768274247646332,
 0.8864038586616516, -0.31188464164733887, 0.9887157678604126],
  [-0.8038562536239624, -1.4020450115203857, 0.12107295542955399,
 -2.0658767223358154, 0.9201765060424805, -0.42329636216163635,
 -1.4801915884017944, -0.7969468832015991, 0.6704075932502747,
 0.3807937204837799, 1.2836308479309082, -1.7994437217712402],
  [0.560377836227417, -0.5901781320571899, 1.513032078742981,
 0.6417092680931091, -0.8430933952331543, -0.6770299673080444,
 0.47085481882095337, 0.07626532763242722, 1.4205647706985474,
 -0.7763586640357971, 0.13012942671775818, -0.13884983956813812],
  [0.7501691579818726, 1.6195898056030273, 0.4826870560646057,
 0.9587796926498413, -0.41793495416641235, 0.5500046014785767,
 -0.2969793379306793, -0.973719596862793, 0.11110638082027435,
 0.0972077026963234, -1.2553112506866455, 0.5298007130622864],
  [1.1207773685455322, -0.10136342793703079, 0.6133917570114136,
 1.0013039112091064, 1.6809592247009277, 0.9251255989074707,
 -0.9882517457008362, 0.2078029066324234, -1.219529628753662,
 0.08932888507843018, -1.0524274110794067, -0.6917388439178467],
  [-1.982431173324585, 2.267630100250244, -0.13079318404197693,
 -0.4808737337589264, -1.232639193534851, 0.7591094970703125,
 -0.4769798815250397, -0.6204180717468262, -0.6902609467506409,
 2.365145683288574, -0.3796442151069641, 1.864675521850586],
  [-0.8315299153327942, 0.033423274755477905, 0.32895520329475403,
 -1.6618777513504028, -0.07653109729290009, 0.8074823021888733,
 -0.7966762185096741, 1.251874566078186, 0.9226643443107605,
 0.7866818308830261, 0.7923650741577148, -0.4601968824863434]
]>


memref.global constant @B : memref<12x12xf32> = dense<[
  [2.397496223449707, 0.19480518996715546, 0.2745186388492584,
 0.07115253806114197, 0.6442416310310364, 1.7909514904022217,
 -0.3518707752227783, -0.48048457503318787, -0.2042524218559265,
 0.8529296517372131, 0.6624273657798767, 1.1685149669647217],
  [0.8331336379051208, 0.10706620663404465, 0.7593052983283997,
 -0.5092511773109436, 1.1114634275436401, -0.09248355031013489,
 0.839974045753479, -0.351138710975647, -1.167814016342163,
 -1.3892009258270264, -1.3128107786178589, 1.2767237424850464],
  [1.7505762577056885, 0.11671149730682373, -0.19988541305065155,
 0.20591729879379272, 0.519942581653595, -1.745890498161316,
 -1.5392831563949585, 1.5183165073394775, 1.9789714813232422,
 -2.1282575130462646, 0.033984508365392685, 0.20649342238903046],
  [1.0877691507339478, -0.04195538908243179, -0.8090072274208069,
 -0.9252509474754333, -2.590146780014038, 0.47342216968536377,
 -0.4365278482437134, 0.6825875043869019, -1.850749135017395,
 0.49484506249427795, -0.48870959877967834, -0.38816624879837036],
  [-1.0301549434661865, -0.36660921573638916, -0.3237517178058624,
 -0.5332834720611572, 0.4271363615989685, 1.0811803340911865,
 -1.4866969585418701, 0.3560142517089844, 2.7962992191314697,
 -1.236227035522461, -0.16417492926120758, -1.4708625078201294],
  [1.5814311504364014, 1.0583893060684204, -1.0116018056869507,
 -0.42502477765083313, 1.6123285293579102, -1.5226322412490845,
 0.1130620464682579, 0.5907350778579712, 0.4400123059749603,
 -0.4507058262825012, 1.1341685056686401, 0.8541713356971741],
  [-0.0659295842051506, -0.7156318426132202, -1.0751136541366577,
 0.2649860680103302, 0.0305627454072237, -0.10863208025693893,
 -1.423568606376648, 0.2957165241241455, -1.1918089389801025,
 1.4413282871246338, 0.9170172810554504, -0.3843468129634857],
  [0.08095530420541763, 0.9625868797302246, -1.6510791778564453,
 0.8501227498054504, 0.12471510469913483, 0.7270844578742981,
 0.8355269432067871, 0.5956495404243469, 0.8922373056411743,
 0.9441280364990234, 0.9534943103790283, 0.2391490936279297],
  [-0.3468391001224518, 0.8117190599441528, -0.2533649802207947,
 -0.41677600145339966, -0.4404476583003998, -0.2697369158267975,
 2.2145965099334717, -0.20847786962985992, 0.21919436752796173,
 -0.17911101877689362, -0.1249602660536766, 0.29202017188072205],
  [-0.3865996301174164, 0.30083832144737244, -0.6511463522911072,
 -1.1278417110443115, 0.28226661682128906, -1.6474008560180664,
 1.3611891269683838, -0.13157759606838226, 0.4386368989944458,
 0.39703479409217834, -0.09683380275964737, 0.5352716445922852],
  [-0.34043800830841064, 1.1934998035430908, 0.8844823837280273,
 -0.9531003832817078, 0.6773251295089722, 1.1001825332641602,
 1.9886763095855713, 0.9349692463874817, -0.6289650797843933,
 0.22432196140289307, 1.0289722681045532, -0.7286362648010254],
  [1.0373172760009766, 0.04016899690032005, 1.906428337097168,
 1.9585762023925781, 0.43330779671669006, 1.3770594596862793,
 -0.797773540019989, 0.05532928556203842, 0.5319772958755493,
 1.045296311378479, 0.06524834781885147, 0.32584694027900696]
]>


memref.global constant @C : memref<12x12xf32> = dense<[
  [-2.9167909622192383, 0.7649552822113037, -2.78056263923645,
 -3.54142689704895, 1.5315052270889282, 0.27908143401145935,
 2.2935104370117188, -0.5458223819732666, 2.860002040863037,
 2.0027225017547607, 3.397894859313965, -1.6388039588928223],
  [1.3520127534866333, 1.6721749305725098, 4.611230373382568,
 2.8823816776275635, 0.5754331946372986, 3.3467726707458496,
 2.391155242919922, 0.8926072120666504, 1.495613694190979,
 -0.5124804973602295, 1.317800521850586, 0.23059186339378357],
  [-2.013132095336914, 0.8815119862556458, 1.302909255027771,
 -1.94683837890625, -0.964776873588562, -1.8879269361495972,
 6.100618839263916, -1.640695333480835, -5.169074535369873,
 -4.43499755859375, -4.428703784942627, 1.9798381328582764],
  [3.351712942123413, 1.6195173263549805, 0.6170666217803955,
 -1.4902396202087402, -0.7360361814498901, -1.9452654123306274,
 0.6916021704673767, 3.3284590244293213, 0.6033797264099121,
 -0.3416033685207367, 0.8260414600372314, 0.08012313395738602],
  [5.200223445892334, -1.4032806158065796, 0.9794571995735168,
 -1.6974228620529175, 2.69663143157959, -6.63120698928833,
 -2.5945684909820557, -1.6970961093902588, -0.8412003517150879,
 -9.13522720336914, -4.285664081573486, 4.4755120277404785],
  [-7.611191749572754, -1.116822600364685, -0.3821254372596741,
 2.253538131713867, -2.0685338973999023, 3.5277652740478516,
 3.40761399269104, -2.3389370441436768, -1.8797820806503296,
 5.444581031799316, -1.738669753074646, -1.558808445930481],
  [-9.398179054260254, 1.4193536043167114, 0.686378002166748,
 -4.244015693664551, 2.8055224418640137, -3.152529716491699,
 5.837310314178467, -0.27191558480262756, 7.853769302368164,
 -5.412395000457764, 0.6562089323997498, -4.361183166503906],
  [3.5905873775482178, 0.5938923358917236, -0.7941849827766418,
 0.8727837800979614, -3.415031671524048, -0.30820775032043457,
 -0.2729552090167999, 2.0778136253356934, -0.9520724415779114,
 -0.1853080540895462, 0.7813646793365479, 0.32290881872177124],
  [7.177668571472168, -1.0112758874893188, 1.8777321577072144,
 -0.3983326554298401, -0.013431730680167675, -2.0017266273498535,
 -2.3130414485931396, -1.2138413190841675, -3.1669676303863525,
 -2.950618267059326, -3.870211124420166, 4.809437274932861],
  [4.608118534088135, -0.7396993041038513, -3.4614341259002686,
 -1.9878604412078857, 0.08989391475915909, 0.15836051106452942,
 -6.79506254196167, 1.3085923194885254, 5.786742687225342,
 -4.1416730880737305, -0.5121352076530457, -0.10137198865413666],
  [0.22438490390777588, 0.6340001821517944, 4.615016460418701,
 0.43715164065361023, 4.548688888549805, -8.207356452941895,
 4.540760040283203, -1.290636658668518, -2.593128204345703,
 -1.965561866760254, -4.437007904052734, 5.183340549468994],
  [-3.0592031478881836, 4.5203728675842285, -1.8491895198822021,
 -0.84837406873703, 5.530953884124756, -4.4757184982299805,
 7.981980800628662, 1.1322420835494995, 5.869400501251221,
 -2.670027494430542, 2.21394419670105, 1.1551340818405151]
]>

