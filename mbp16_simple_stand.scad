use <comp/anchor.scad>;
use <comp/cloud.scad>;
use <comp/prezel.scad>;
use <laptop.scad>;

include <consts.scad>;
include <variants/model_16in_2019.scad>;
//include <variants/um3.scad>
//include <variants/cr10.scad>
// comment if print without rotating
include <variants/prusa_mk3_16in.scad>
//include <variants/cr10_fc.scad>
//include <variants/power_cable_only.scad>

$fn = 128;
extra_deg = atan2(CASE_WIDTH, CASE_DEPTH);

// hollow for cable observing
HW_R = 6;
HW_DIST = 4;
FINGER_R = 9;

EXTRUDE_H = 52;
THICKNESS = 6;
WIDTH = 48;
VERT_TH = 26;
VERT_HEIGHT = 32;

difference() {
  rotate([90, 0, 0]) linear_extrude(height=EXTRUDE_H) {
    square([WIDTH, THICKNESS], center=true);
    translate([-WIDTH / 2, 0, 0]) circle(r=THICKNESS / 2);
    translate([WIDTH / 2, 0, 0]) circle(r=THICKNESS / 2);
    translate([-VERT_TH / 2, 0, 0]) square([VERT_TH, VERT_HEIGHT]);
    translate([0, VERT_HEIGHT, 0]) circle(d=VERT_TH);
  }

    //translate([30, 0, 0])
    translate([0, 85, 4]) union() {
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
}
