use <comp/anchor.scad>;
use <comp/cloud.scad>;
use <comp/screw.scad>;
//use <comp/prezel.scad>;
use <laptop.scad>;

include <consts.scad>;
include <variants/model_16in_2019.scad>;
//include <variants/um3.scad>
//include <variants/cr10.scad>
// comment if print without rotating
include <variants/prusa_mk3_16in.scad>
include <consts_owc.scad>;
//include <variants/cr10_fc.scad>
//include <variants/power_cable_only.scad>

// rename consts from prusa_mk3_16in
USBC_1_WIDTH = USBC_WIDTH_1;
USBC_1_DEPTH = USBC_DEPTH_1;

$fn = 128;
extra_deg = atan2(CASE_WIDTH, CASE_DEPTH);

BASE_WIDTH = 1.1 * CASE_HEIGHT + 8;

//BASE_FRONT_EXT = 15;
BASE_FRONT_EXT = 40;
BASE_BACK_EXT = 15;
BASE_HEIGHT_ABOVE_SURFACE = 64;
//BASE_WIDTH = 60;

// hollow for cable observing
HW_R = 6;
HW_DIST = 4;
FINGER_R = 9;

intersection() {

difference() {
  translate([15, -BASE_BUMP_HEIGHT, 0])
    rotate([0, 0, 0]) cloud_xy(
        thickness=BASE_WIDTH
        , r1=23
        , r2=12
        , r3=20
        , r4=12
    );
  // laptop corner, cable support, and tunnel
#  translate([-18, 34.985, -2]) rotate([180 + extra_deg, -90, 0])
    //translate([30, 0, 0])
    translate([15, 53, 5]) union() {
      case_ss(
          depth=CASE_DEPTH
        , width=CASE_WIDTH
        , thickness=CASE_HEIGHT
        , edge_front=CASE_EDGE_FRONT
        , edge_back=CASE_EDGE_BACK
        , corner_radius=CASE_CORNER_R
        , usbc_1_width=USBC_1_WIDTH
        , usbc_1_depth=USBC_1_DEPTH
        , usbc_2_width=USBC_2_WIDTH
        , usbc_2_depth=USBC_2_DEPTH
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
      // push by finger
      translate([USBC_1_DX , (USBC_1_DY + USBC_2_DY) / 2, -8 -9]) difference() {
        translate([0, 0, -2])
        mirror([0, 0, 1])
          cylinder(r=FINGER_R, h=USBC_1_HEIGHT + 18);
        translate([0, -29, -5])
          cylinder(r=30, h=12, center=true);
      }
    }
    // screw tunnels 1
*    translate([40, 4, BASE_WIDTH / 2 + 3])
      rotate([-60, 0, 5]) screw_subtract(h1=15, h0=60, r0=4.2, r1=1.8, hc=2.75);
    // screw tunnels 2
*    translate([15, 2, BASE_WIDTH / 2 - 3])
      rotate([-120, 0, -20]) screw_subtract(h1=15, h0=60, r0=4.2, r1=1.8, hc=2.75);
  // test cable alignment
    rotate([0, 0, extra_deg])
      cube([40, 86, 2 * BASE_WIDTH], center=true);
    rotate([0, 0, extra_deg])
      translate([48, -50, BASE_WIDTH / 2])
      cube([80, 50, 2 * BASE_WIDTH], center=true);
}

// test case fit
#translate([30, 42, 0])
  cube([114, 60, 2 * BASE_WIDTH], center=true);

// test cable reach
*rotate([0, 0, extra_deg])
  cube([74, 60, 2 * BASE_WIDTH], center=true);
*cube([56, 56, 2 * BASE_WIDTH], center=true);

// test clip on back plate
*translate([-40, -45, 0]) cube([50, 50, 50]);
}
