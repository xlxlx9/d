// modify params in consts from printing experiments

// Material PLA
// Bed 60 centigrade
// Extruder 190 centigrade

USBC_WIDTH=
  10.3 /*r1, r2*/ + 0.2 /*r3*/ - 0.15 /*r4*/ + 0.08 /*r5*/ + 0.08 /*r6*/ - 0.03 /*r7*/ + 0.016
  + 0.1 // compensate for squeezing from 90% fill
  ;
USBC_DEPTH=
  6 /*r1, r2*/ + 0.2 /*r3*/ - 0.15 /*r5*/ + 0.15 /*r6*/ - 0.03 /*r7*/ + 0.016
  + 0.1 // compensate for squeezing from 90% fill
  ;

USBC_1_DY=-33.175 /*r1*/ - 0.25 /*r5*/ - 0.2;
USBC_1_DX=-0.2 /*r1*/ + 0.45 /*r2*/ + 0.1 /*r5 - 0.35*/ /*r6*/ - 0.4;
USBC_2_DY=-48.175 /*r1*/ - 0.25 /*r5*/ - 0.2 /*r8*/ + 0.15;
USBC_2_DX=-0.2 /*r1*/ + 0.45 /*r2*/ + 0.1 /*r5 - 0.45*/ /*r6*/ - 0.4;
