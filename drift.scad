use <laptop.scad>;

include <consts.scad>;
include <variants/model_15in.scad>;

$fn = 128;
extra_deg = atan2(CASE_WIDTH, CASE_DEPTH);

PLATE_WDITH = 90;
PLATE_RADIUS = 16;
PLATE_HEIGHT = 20;

SH1_WDITH = 68;
SH1_DEPTH = 50;
SH1_HEIGHT = 30;
SH1_OFF_R = 4;

USBC_2_WIDTH = 12.20 + 0.15;

intersection() {
* translate([40, 70, 0])
  cube([100, 100, 40], center=true);
* translate([20, 20, 0])
  cube([100, 100, 40], center=true);
* translate([10, 20, 0])
  rotate([0, 0, 90 - extra_deg])
  cube([100, 100, 40], center=true);

rotate([-90, 0, 0])
rotate([0, 0, 45]) difference() {
color("LightYellow", 1)
union() {
*  translate([0, 0, -PLATE_HEIGHT])
  linear_extrude(height=PLATE_HEIGHT) {
    offset(r=PLATE_RADIUS)
      square(PLATE_WDITH - 2 * PLATE_RADIUS, center=true);
  }
  rotate([0, 0, 45])
  translate([-SH1_HEIGHT / 2, 0, 0]) rotate([0, 90, 0])
  linear_extrude(height=SH1_HEIGHT) {
  translate([-SH1_DEPTH, -SH1_WDITH / 2])
    offset(r=SH1_OFF_R)
    union() {
      square([SH1_DEPTH, SH1_WDITH]);
      polygon([[0, 0], [0, SH1_WDITH], [-SH1_WDITH / 2, SH1_WDITH / 2]]);
    }
  }
}

color("Silver", 1)
translate([-17, 17, 27])
  rotate([extra_deg - 90, 0, 45])
      case_ss(
          depth=CASE_DEPTH
        , width=CASE_WIDTH
        , thickness=CASE_HEIGHT
        , edge_front=CASE_EDGE_FRONT
        , edge_back=CASE_EDGE_BACK
        , corner_radius=CASE_CORNER_R
        , usbc_1_width=USBC_WIDTH
        , usbc_1_depth=USBC_DEPTH
        , usbc_1_height=USBC_1_HEIGHT
        , usbc_2_width=USBC_2_WIDTH
        , usbc_2_depth=6.45 + 0.15
        , usbc_2_height=22.68
        , usbc_2_xyr=1.25
        , usbc_1_dy=USBC_1_DY
        , usbc_1_dx=USBC_1_DX
        , usbc_2_dy=USBC_2_DY
        , usbc_2_dx=USBC_2_DX
        , usbc_tunnel_xy_padding=USBC_TUNNEL_XY_PADDING
        , usbc_1_tunnel_extend_bottom=50
        , usbc_2_tunnel_extend_bottom=30
        , usbc_extend_top=2
        , tunnel_1=[]
        , tunnel_2=[]
        , delicate=true // cause lag in preview, switch before Render
        , fn=$fn);
 rotate([0, 0, -45]) translate([40, -0.25, 0])
    cube([30, USBC_2_WIDTH + USBC_TUNNEL_XY_PADDING * 2, 42], center=true);
} // difference
} // intersection
