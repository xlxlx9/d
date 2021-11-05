use <comp/anchor.scad>;
//use <comp/cloud.scad>;
use <lib/star.scad>;
use <laptop.scad>;

include <consts.scad>;
include <variants/model_16in_2019.scad>;
//include <variants/um3.scad>
//include <variants/cr10.scad>
// comment if print without rotating
include <variants/prusa_mk3_16in.scad>
include <variants/thinkvision_usbc.scad>
//include <variants/cr10_fc.scad>
//include <variants/power_cable_only.scad>

$fn = 128;
extra_deg = atan2(CASE_WIDTH, CASE_DEPTH);

BASE_FRONT_EXT = 10;
//BASE_FRONT_EXT = 40;
BASE_BACK_EXT = 8;
//BASE_HEIGHT_ABOVE_SURFACE = 12;
BASE_WIDTH = 30;

BACK_TO_FRONT = BASE_BACK_EXT + BASE_ROTATE_RADIUS + BASE_FRONT_EXT;

// hollow for cable observing
HW_R = 6;
HW_DIST = 4;
FINGER_R = 9;

intersection() {

difference() {
  union() {
    translate([0, 0, 0]) anchor(
        width=BASE_WIDTH
      , height_above_surface = BASE_HEIGHT_ABOVE_SURFACE
      , rotate_radius = BASE_ROTATE_RADIUS
      , front_extension_depth = BASE_FRONT_EXT
      , back_extension_depth = BASE_BACK_EXT
      , back_extension_under = BASE_BACK_UNDER
      , back_plate_height = BASE_PLATE_HEIGHT
      , back_plate_sink = BASE_PLATE_SINK
      , back_height_under = 13.2
      , r = BASE_EDGE_RADIUS
    );
    difference() {
      translate([-BASE_BACK_EXT, 24, 3.1 + 18])
        rotate([0, 90, 0])
        rotate([0, 0, 22])
      linear_extrude(height=BACK_TO_FRONT) {
        offset(r=-15)
        offset(r=30)
          Star(points=5, outer=26, inner=16);
      }
      // do not intrude plate insert
      translate([-80, -BASE_PLATE_SINK - BASE_ROTATE_RADIUS * 10, -BASE_WIDTH * 3])
        cube([150, BASE_ROTATE_RADIUS * 10, 6 * BASE_WIDTH]);
    }
  }
  // laptop corner, cable support, and tunnel
  translate([-8, -8, -25 + 18]) mirror([0, 0, 1]) rotate([180 + extra_deg, 0, 0])
    //translate([30, 0, 0])
    translate([15, 35, 37]) union() {
      case_ss(
          depth=CASE_DEPTH
        , width=CASE_WIDTH
        , thickness=CASE_HEIGHT
        , edge_front=CASE_EDGE_FRONT
        , edge_back=CASE_EDGE_BACK
        , corner_radius=CASE_CORNER_R
        , usbc_1_width=USBC_WIDTH_1
        , usbc_1_depth=USBC_DEPTH_1
        , usbc_2_width=USBC_WIDTH_2
        , usbc_2_depth=USBC_DEPTH_2
        , usbc_1_xyr=USBC_1_XYR
        , usbc_1_height=USBC_1_HEIGHT
        , usbc_2_height=USBC_2_HEIGHT
        , usbc_1_dy=USBC_1_DY
        , usbc_1_dx=USBC_1_DX
        , usbc_2_dy=USBC_2_DY
        , usbc_2_dx=USBC_2_DX
        , usbc_tunnel_xy_padding=USBC_TUNNEL_XY_PADDING
        , usbc_1_tunnel_extend_bottom=28
        , usbc_2_tunnel_extend_bottom=36
        , usbc_extend_top=6
        , tunnel_1=[
//            [0, 0, 0], [0, 0, -10], [0, 4, -20], [0, 20, -47]
        ]
        , tunnel_2=[
//            [0, 0, 0], [0, 0, -12], [0, 5, -20], [0, 30, -28]
//          , [0, 0, 0], [0, 0, -11], [0, 5, -20], [0, 28, -36]
//          , [0, 0, 0], [0, 0, -10], [0, 4, -20], [0, 24, -42]
//          , [0, 0, 0], [0, 0, -9],  [0, 2, -20], [0, 18, -47]
//          , [0, 0, 0], [0, 0, -7],  [0, 0, -20], [0, 11, -51]
        ]
        , delicate=true // cause lag in preview, switch before Render
        , fn=$fn);
      // oberserving cables
      translate([0, (USBC_2_DY + USBC_1_DY) / 2, HW_R]) rotate([0, 90, 0])
      hull() {
        translate([0, -HW_DIST, 0]) cylinder(h=2 * BASE_WIDTH, r=HW_R, center=false);
        translate([0,  HW_DIST, 0]) cylinder(h=2 * BASE_WIDTH, r=HW_R, center=false);
      }
      // widen tunnel
*      translate([USBC_1_DX , (USBC_1_DY + USBC_2_DY) / 2, -44])
        linear_extrude(height=24) {
          offset(r=USBC_TUNNEL_XY_PADDING) {
            square([USBC_WIDTH, USBC_DEPTH * 5], center=true);
          }
        }
*      translate([USBC_1_DX , (USBC_1_DY + USBC_2_DY) / 2 + USBC_DEPTH * 1.75, -44 - 20])
        linear_extrude(height=24) {
          offset(r=USBC_TUNNEL_XY_PADDING) {
            square([USBC_WIDTH, USBC_DEPTH * 1.5], center=true);
          }
        }
      // widen tunnel
      translate([USBC_1_DX, -20, -27]) rotate([0, 90, 0])
        linear_extrude(height=USBC_WIDTH + USBC_TUNNEL_XY_PADDING * 2, center=true) union() {
          union() {
            difference() {
              circle(32);
              hull() {
                translate([-0.7, 0, 0])
                  circle(10);
                translate([0.7, 0, 0])
                  circle(10);
              }
              rotate([0, 0, -extra_deg]) translate([-100, 0])
                square([200, 200]);
              mirror([1, 0, 0]) translate([0, -100])
                square([200, 200]);
            }
          }
          rotate([0, 0, 90 - extra_deg]) translate([-1, -11 + 0.7])
            mirror([0, 1, 0]) square([65, 14.7]);
        }
      // push by finger
      translate([USBC_1_DX , (USBC_1_DY + USBC_2_DY) / 2, -8 - 5]) intersection() {
        translate([0, 0, -6])
        mirror([0, 0, 1])
          cylinder(r=FINGER_R, h=USBC_1_HEIGHT + 18);
        translate([0, -2, -4.32 + 5]) rotate([0, 90, 0])
          cylinder(r=30, h=FINGER_R * 2 + 5, center=true);
      }
    }
  // make room for bump
#  translate([BASE_ROTATE_RADIUS - 0.05 - 0.5, -BASE_BUMP_HEIGHT - 10, -35]) {
    cube([BASE_BUMP_DEPTH + 0.05, BASE_BUMP_HEIGHT + 10, BASE_WIDTH + 50]);
    translate([-25, 0, 80]) rotate([0, 90, 0])
    cube([BASE_BUMP_DEPTH + 0.2, BASE_BUMP_HEIGHT + 10, BASE_WIDTH + 50]);
  }
  // test cable alignment
*    rotate([0, 0, extra_deg])
      cube([40, 70, 2 * BASE_WIDTH], center=true);
*    rotate([0, 0, extra_deg])
      translate([68, 0, BASE_WIDTH / 2])
      cube([30, 150, 2 * BASE_WIDTH], center=true);
}

// test case fit
*translate([35, 42, 0])
  cube([114, 60, 2 * BASE_WIDTH], center=true);

// test cable reach
*rotate([0, 0, extra_deg])
  cube([74, 60, 2 * BASE_WIDTH], center=true);
*cube([56, 56, 2 * BASE_WIDTH], center=true);

// test clip on back plate
*translate([-40, -45, 0]) cube([50, 50, 50]);
}
