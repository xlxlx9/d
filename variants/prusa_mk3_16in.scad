// modify params in consts from printing experiments

// Material PLA
// Bed 60 centigrade
// Extruder 190 centigrade

USBC_WIDTH=
  10.3 /*r1, r2*/ + 0.2 /*r3*/ - 0.15 /*r4*/ + 0.08 /*r5*/ + 0.08 /*r6*/ - 0.03 /*r7*/ + 0.016
  + 0.1 // compensate for squeezing from 90% fill
  - 0.15 // after 16in v1
  - 0.15 // after 16in v2
  ;
USBC_DEPTH=
  6 /*r1, r2*/ + 0.2 /*r3*/ - 0.15 /*r5*/ + 0.15 /*r6*/ - 0.03 /*r7*/ + 0.016
  + 0.1 // compensate for squeezing from 90% fill
  - 0.15 // after 16in v1
  - 0.15 // after 16in v2
  ;

USBC_1_DY=-33.175 /*r1*/ - 0.25 /*r5*/ - 0.2
  //+ 0.15 // after 16in v1 // wrong direction
  - 0.3 // after 16in v2
  ;
USBC_1_DX=-0.2 /*r1*/ + 0.45 /*r2*/ + 0.1 /*r5 - 0.35*/ /*r6*/ - 0.4
  - 0.2 // after 16in v1
  - 0.3 // after 16in v2
  ;
USBC_2_DY=-48.175 /*r1*/ - 0.25 /*r5*/ - 0.2 /*r8*/ + 0.15
  //+ 0.15 // after 16in v1 // wrong direction
  - 0.3 // after 16in v2
  ;
USBC_2_DX=-0.2 /*r1*/ + 0.45 /*r2*/ + 0.1 /*r5 - 0.45*/ /*r6*/ - 0.4
  - 0.2 // after 16in v1
  - 0.3 // after 16in v2
  ;

USBC_1_HEIGHT=16.3
  - 0.2
  ;
USBC_2_HEIGHT=16.3
  - 0.2
  ;
