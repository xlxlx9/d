use <comp/anchor.scad>;
use <comp/cloud.scad>;
use <lib/star.scad>;
use <laptop.scad>;

include <consts.scad>;
include <variants/model_15in.scad>;
//include <variants/um3.scad>
include <variants/cr10_fc.scad>
//include <variants/power_cable_only.scad>

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
      , r = BASE_EDGE_RADIUS
    );

    // Use star shape as closure
    difference() { 
      translate([23.5, 24, 0])
        rotate([0, 0, 22])
      linear_extrude(height=BASE_WIDTH) {
        offset(r=-15)
        offset(r=30)
          Star(points=5, outer=26, inner=16);
      }
      // do not intrude plate insert
      translate([-80, -BASE_PLATE_SINK - BASE_ROTATE_RADIUS * 10, -BASE_WIDTH * 3]) 
        cube([150, BASE_ROTATE_RADIUS * 10, 6 * BASE_WIDTH]);
    }
  }
  // holes, optional
  translate([18, 10, -BASE_WIDTH / 2])
    linear_extrude(height=BASE_WIDTH * 2) {
      offset(r=-1.5) offset(r=3)
        Star(points=5, outer=4, inner=2.4);
      translate([12, -5])
        offset(r=-1.5) offset(r=3)
          Star(points=5, outer=2, inner=1.2);
      translate([23, -7])
        offset(r=-0.5) offset(r=1)
          Star(points=5, outer=1.2, inner=0.7);
    }
  // laptop corner, cable support, and tunnel
 rotate([180 + extra_deg, -90, 0])
//    translate([30, 0, 0])
    translate([15, 27, 30]) {
      case_ss(
          depth=CASE_DEPTH
        , width=CASE_WIDTH
        , thickness=CASE_HEIGHT
        , edge_front=CASE_EDGE_FRONT
        , edge_back=CASE_EDGE_BACK
        , corner_radius=CASE_CORNER_R
        , usbc_1_width=USBC_WIDTH
        , usbc_1_depth=USBC_DEPTH
        , usbc_2_width=USBC_WIDTH
        , usbc_2_depth=USBC_DEPTH
        , usbc_1_height=USBC_1_HEIGHT
        , usbc_2_height=USBC_2_HEIGHT
        , usbc_1_dy=USBC_1_DY
        , usbc_1_dx=USBC_1_DX
        , usbc_2_dy=USBC_2_DY
        , usbc_2_dx=USBC_2_DX
        , usbc_tunnel_xy_padding=USBC_TUNNEL_XY_PADDING
        , usbc_1_tunnel_extend_bottom=44
        , usbc_2_tunnel_extend_bottom=36
        , usbc_extend_top=6
        , tunnel_1=[[0, 0, 0], [0, 0, -10], [0, 18, -30], [0, 40, -37]]
        , tunnel_2=[[0, 0, 0], [0, 0, -12], [0, 5, -20], [0, 30, -28]]
        , psink=PAD_SINK
//        , delicate=true // cause lag in preview, switch before Render
        , fn=$fn);
    }
  // widen tunnel
  //translate([0, 0, 30])
  translate([0, 0, BASE_WIDTH / 2 - USBC_WIDTH / 2 - USBC_TUNNEL_XY_PADDING])
    linear_extrude(height=USBC_WIDTH + 2 * USBC_TUNNEL_XY_PADDING) {
      polygon([[-36, -12], [6, -20], [-11, 19]]);
  }
  // make room for bump
  translate([BASE_ROTATE_RADIUS - 0.05, -BASE_BUMP_HEIGHT - 10, -5])
    cube([BASE_BUMP_DEPTH + 0.05, BASE_BUMP_HEIGHT + 10, BASE_WIDTH + 10]);
  // test cable alignment
    *rotate([0, 0, extra_deg])
      cube([40, 80, 2 * BASE_WIDTH], center=true);
    *rotate([0, 0, extra_deg])
      translate([65, 0, 0])
      cube([40, 80, 2 * BASE_WIDTH], center=true);
}

// test cable reach
*rotate([0, 0, extra_deg])
  cube([74, 60, 2 * BASE_WIDTH], center=true);
*cube([56, 56, 2 * BASE_WIDTH], center=true);
}
