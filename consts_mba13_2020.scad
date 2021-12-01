// Updated to Macbook Air 13" 2020 M1
// v1-4 work from MBA11 2010
// v1m, v2m, ... for MBA13 2020 M1
CASE_WIDTH = 299.5;
CASE_HEIGHT= 16.9;
CASE_DEPTH = 192;

CASE_CORNER_RADIUS = 11;
CASE_CURVE_WIDTH = 30;
CASE_EDGE_FRONT = 5;
CASE_EDGE_BACK = 5 /*v4*/ - 0.4 /*v1m*/ - 0.8;
CASE_CORNER_R = 8;


// Base anchor
BASE_WIDTH = 1.2 * CASE_HEIGHT + 8;
BASE_HEIGHT_ABOVE_SURFACE = 3;
BASE_ROTATE_RADIUS = 12.5;
BASE_FRONT_EXT = 42;
BASE_BACK_EXT = 5;
BASE_BACK_UNDER = 15;
BASE_PLATE_SINK = 2.1;
BASE_PLATE_HEIGHT = 2.05;
BASE_EDGE_RADIUS = 1;
BASE_BUMP_DEPTH = 11;
BASE_BUMP_HEIGHT = 2.2;


// ports
USBC_1_HEIGHT=16 /*v6*/ + 0.3;
USBC_1_WIDTH = 10.3;
USBC_1_DEPTH = 6;

USBC_2_HEIGHT=16 /*v6*/ + 0.3;
USBC_2_WIDTH = 10.3;
USBC_2_DEPTH = 6;


USBC_1_DY=/*v1m measured*/-21.9;
USBC_1_DX=-0.95 /*v3*/- 0.5 /*v4*/ + 0.25 /*v1m*/ + 0.5 /*v2m*/ - 0.25 /*v3m*/ - 0.125;

USBC_2_DY=USBC_1_DY /*v1m measured*/ - 14.6 /*v2m*/ - 0.3;
USBC_2_DX=-0.95 + 0.7 /*v2m*/ - 0.7 /*v3m*/ - 0.125;

USBC_1_XYR = 3;
USBC_2_XYR = 3;

USBC_TUNNEL_XY_PADDING=0.25;

// pad sliding track
PAD_SINK=0.4;
PAD_DY = -7;
PAD_DZ = 14.75;
PAD_TH2 = 3.6;