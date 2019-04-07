use <comp/anchor.scad>;
use <comp/cloud.scad>;
use <laptop.scad>;
include <consts.scad>;

$fn = 128;
extra_deg = atan2(CASE_WIDTH, CASE_DEPTH);

intersection() {

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
    translate([20, -BASE_BUMP_HEIGHT, 0])
    rotate([0, 0, 0]) cloud_xy(
        thickness=BASE_WIDTH
      , r1=17
      , r2=16
      , r3=25
      , r4=13.6
    );
  }
  rotate([180 + extra_deg, -90, 0])
    translate([14, 35, 37])
      case_ss(
          depth=CASE_DEPTH
        , width=CASE_WIDTH
        , thickness=CASE_HEIGHT
        , usbc_width=10.3 /*r1*/ + 0.2 /*r2*/ + 0.3
        , usbc_depth=6 /*r1*/ + 0.2 /*r2*/ + 0.3
        , usbc_height_1=16.3
        , usbc_height_2=16.3
        , usbc_1_dy=-33.175 /*r1*/ - 0.25 /*r2*/ - 0.15
        , usbc_1_dx=-0.2 /*r1*/ + 0.45
        , usbc_2_dy=-48.175 /*r1*/ - 0.25 /*r2*/ - 0.15
        , usbc_2_dx=-0.2 /*r1*/ + 0.45
        , usbc_tunnel_xy_padding=0.4
        , usbc_tunnel_extend_bottom=2
        , usbc_extend_top=0
        , tunnel_1=[[0, 0, 0], [0, 0, -8], [0, 5, -18], [0, 30, -47]]
        , tunnel_2=[[0, 0, 0], [0, 0, -7], [0, 5, -14], [0, 30, -24]]
        , fn=$fn);
  // make room for bump
  translate([BASE_ROTATE_RADIUS - 0.05, -BASE_BUMP_HEIGHT - 10, -5])
    cube([BASE_BUMP_DEPTH + 0.05, BASE_BUMP_HEIGHT + 10, BASE_WIDTH + 10]);
// test cable alignment
*    rotate([0, 0, extra_deg])
      cube([40, 60, 2 * BASE_WIDTH], center=true);
}

// test cable reach
*rotate([0, 0, extra_deg])
  cube([40, 60, 2 * BASE_WIDTH], center=true);
}
