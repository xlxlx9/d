use <comp/anchor.scad>;
use <comp/cloud.scad>;
use <laptop.scad>;

include <consts.scad>;
include <variants/um3.scad>
//include <variants/cr10.scad>

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
      , back_extension_under = BASE_BACK_UNDER
      , back_plate_height = BASE_PLATE_HEIGHT
      , back_plate_sink = BASE_PLATE_SINK
      , r = BASE_EDIGE_RADIUS
    );

    // Use cloud shape as closure
    difference() { 
      translate([15, -BASE_BUMP_HEIGHT, 0])
        rotate([0, 0, 0]) cloud_xy(
            thickness=BASE_WIDTH
          , r1=17
          , r2=16
          , r3=25
          , r4=13.6
        );
      // do not intrude plate insert
      translate([-30, -BASE_PLATE_SINK - BASE_ROTATE_RADIUS, -BASE_WIDTH * 3]) 
        cube([30, BASE_ROTATE_RADIUS, 6 * BASE_WIDTH]);
    }
  }
  // laptop corner, cable support, and tunnel
#  rotate([180 + extra_deg, -90, 0])
    translate([14, 35, 37])
      case_ss(
          depth=CASE_DEPTH
        , width=CASE_WIDTH
        , thickness=CASE_HEIGHT
        , edge_front=CASE_EDGE_FRONT
        , edge_back=CASE_EDGE_BACK
        , corner_radius=CASE_CORNER_R
        , usbc_width=USBC_WIDTH
        , usbc_depth=USBC_DEPTH
        , usbc_height_1=USBC_HEIGHT_1
        , usbc_height_2=USBC_HEIGHT_2
        , usbc_1_dy=USBC_1_DY
        , usbc_1_dx=USBC_1_DX
        , usbc_2_dy=USBC_2_DY
        , usbc_2_dx=USBC_2_DX
        , usbc_tunnel_xy_padding=USBC_TUNNEL_XY_PADDING
        , usbc_tunnel_extend_bottom=2
        , usbc_extend_top=2
        , tunnel_1=[[0, 0, 0], [0, 0, -8], [0, 5, -18], [0, 30, -47]]
        , tunnel_2=[[0, 0, 0], [0, 0, -12], [0, 5, -18], [0, 30, -28]]
        , fn=$fn);
  // widen tunnel
#    rotate([0, 0, extra_deg])
  translate([1, 13.5, BASE_WIDTH / 2])
      cube([40, USBC_DEPTH + 2 * USBC_TUNNEL_XY_PADDING, USBC_WIDTH + 2 * USBC_TUNNEL_XY_PADDING], center=true);
  // make room for bump
  translate([BASE_ROTATE_RADIUS - 0.05, -BASE_BUMP_HEIGHT - 10, -5])
    cube([BASE_BUMP_DEPTH + 0.05, BASE_BUMP_HEIGHT + 10, BASE_WIDTH + 10]);
  // test cable alignment
*    rotate([0, 0, extra_deg])
      cube([40, 60, 2 * BASE_WIDTH], center=true);
}

// test cable reach
*rotate([0, 0, extra_deg])
  cube([74, 60, 2 * BASE_WIDTH], center=true);
}
