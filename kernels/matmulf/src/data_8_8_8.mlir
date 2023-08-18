
memref.global constant @A : memref<8x8xf32> = dense<[
  [1.1176220178604126, -1.3871248960494995, -0.4265716075897217,
 -0.8035872578620911, 0.6014277338981628, -0.07499324530363083,
 0.059693194925785065, -0.03200608864426613],
  [-0.18548467755317688, 1.2047736644744873, 0.7774530649185181,
 -1.3582810163497925, 0.7698278427124023, -0.8702269792556763,
 1.0997635126113892, -0.9584742188453674],
  [-1.2749319076538086, -1.3653380870819092, -1.474327564239502,
 0.4335317015647888, -0.328120619058609, -0.9709680080413818,
 1.2655024528503418, 0.003763606771826744],
  [-1.0665411949157715, 1.7288987636566162, -0.45138227939605713,
 0.04862817004323006, -1.1382405757904053, -0.33829328417778015,
 -1.5297398567199707, 0.20406699180603027],
  [-0.05367063730955124, -0.9068519473075867, -0.02107640542089939,
 -1.2441277503967285, 0.08321687579154968, -0.24711604416370392,
 1.314589262008667, 0.9204949736595154],
  [-0.22877256572246552, -0.030402617529034615, 0.007356334012001753,
 -0.1641322374343872, -0.015097764320671558, 1.2274370193481445,
 1.0408066511154175, 0.6799344420433044],
  [0.2518334984779358, 1.6651910543441772, 1.0347177982330322,
 -0.38181933760643005, -0.3505185842514038, 1.2286534309387207,
 -0.35867178440093994, -1.9132933616638184],
  [1.0271670818328857, -1.3551664352416992, -1.6714682579040527,
 -1.0570014715194702, -1.3222408294677734, 0.7736058831214905,
 -1.7251851558685303, -0.1460547000169754]
]>


memref.global constant @B : memref<8x8xf32> = dense<[
  [0.40561553835868835, -1.415915608406067, 0.8947690725326538,
 1.4356279373168945, 0.2768274247646332, 0.8864038586616516,
 -0.31188464164733887, 0.9887157678604126],
  [-0.8038562536239624, -1.4020450115203857, 0.12107295542955399,
 -2.0658767223358154, 0.9201765060424805, -0.42329636216163635,
 -1.4801915884017944, -0.7969468832015991],
  [0.6704075932502747, 0.3807937204837799, 1.2836308479309082,
 -1.7994437217712402, 0.560377836227417, -0.5901781320571899,
 1.513032078742981, 0.6417092680931091],
  [-0.8430933952331543, -0.6770299673080444, 0.47085481882095337,
 0.07626532763242722, 1.4205647706985474, -0.7763586640357971,
 0.13012942671775818, -0.13884983956813812],
  [0.7501691579818726, 1.6195898056030273, 0.4826870560646057,
 0.9587796926498413, -0.41793495416641235, 0.5500046014785767,
 -0.2969793379306793, -0.973719596862793],
  [0.11110638082027435, 0.0972077026963234, -1.2553112506866455,
 0.5298007130622864, 1.1207773685455322, -0.10136342793703079,
 0.6133917570114136, 1.0013039112091064],
  [1.6809592247009277, 0.9251255989074707, -0.9882517457008362,
 0.2078029066324234, -1.219529628753662, 0.08932888507843018,
 -1.0524274110794067, -0.6917388439178467],
  [-1.982431173324585, 2.267630100250244, -0.13079318404197693,
 -0.4808737337589264, -1.232639193534851, 0.7591094970703125,
 -0.4769798815250397, -0.6204180717468262]
]>


memref.global constant @C : memref<8x8xf32> = dense<[
  [2.566528081893921, 1.693392038345337, 0.23577234148979187,
 5.741125106811523, -2.7163543701171875, 2.7728805541992188,
 0.6824861764907837, 1.3661705255508423],
  [4.852248191833496, -0.20470309257507324, 0.8408195376396179,
 -3.2912862300872803, -1.89341139793396, -0.1964414119720459,
 -2.1885483264923096, -2.243088960647583],
  [0.9922657012939453, 3.4180095195770264, -3.1850767135620117,
 3.10847544670105, -4.318671226501465, 0.015233635902404785,
 -1.5874793529510498, -2.709197521209717],
  [-6.033438682556152, -3.947488307952881, 0.05883026123046875,
 -5.9734673500061035, 2.822360038757324, -2.0220675468444824,
 -1.2599596977233887, -1.0275883674621582],
  [2.1619186401367188, 5.59598445892334, -1.839840292930603,
 1.5188333988189697, -5.678056240081787, 2.201626777648926,
 -0.8335932493209839, -0.9800424575805664],
  [0.6016366481781006, 3.0800528526306152, -2.9418320655822754,
 0.2337624579668045, -1.0457594394683838, 0.40956613421440125,
 -0.5561807155609131, -0.07252287864685059],
  [2.842787981033325, -7.1574506759643555, 0.46852707862854004,
 -3.809185266494751, 5.958770275115967, -2.5976486206054688,
 1.1203515529632568, 2.6456379890441895],
  [-2.2397944927215576, -3.468738555908203, -1.7735636234283447,
 6.055191516876221, 0.30276060104370117, 2.2205636501312256,
 1.771515130996704, 4.515838623046875]
]>
