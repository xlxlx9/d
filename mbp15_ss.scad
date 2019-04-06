use <comp/anchor.scad>;
use <comp/cloud.scad>;
use <laptop.scad>;
include <consts.scad>;

$fn = 128;

difference() {
  union() {
    anchor(
        width=BASE_WIDTH
      , height_above_surface = BASE_HEIGHT_ABOVE_SURFACE
      , rotate_radius = BASE_ROTATE_RADIUS
      , front_extension_depth = BASE_FRONT_EXT
      , back_extension_depth = BASE_BACK_EXT
      , back_plate_height = BASE_PLATE_HEIGHT
      , back_plate_sink = BASE_PLATE_SINK
      , r = BASE_EDIGE_RADIUS
    );

    r0 = 4;
    translate([20, 0, 0])
    rotate([0, 0, 0]) cloud_xy(
        thickness=BASE_WIDTH
      , r1=18
      , r2=21
      , r3=25
    );
  }
  extra_deg = atan2(CASE_WIDTH, CASE_DEPTH);
  rotate([180 + extra_deg, -90, 0])
    translate([14, 35, 32])
      case_ss(
          depth=CASE_DEPTH
        , width=CASE_WIDTH
        , thickness=CASE_HEIGHT
        , usbc_width=10.3 /*r1*/ + 0.2
        , usbc_depth=6 /*r1*/ + 0.2
        , usbc_1_dy=-33.175 /*r1*/ - 0.25
        , usbc_1_dx=-0.2 /*r1*/ + 0.45
        , usbc_2_dy=-48.175 /*r1*/ - 0.25
        , usbc_2_dx=-0.2 /*r1*/ + 0.45
        , usbc_tunnel_xy_padding=0.3
        , tunnel_1=[[0, 0, 0], [0, 0, -19], [0, 7, -42], [20, 60, -30]]
        , tunnel_2=[[0, 0, 0], [0, 0, -20], [0, 32, -35], [-25, 60, -30]]
        , fn=$fn);
// test cable alignment
*    rotate([0, 0, extra_deg])
      cube([40, 60, 2 * BASE_WIDTH], center=true);
}
