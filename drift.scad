use <laptop.scad>;

include <consts.scad>;

$fn = 128;

PLATE_WDITH = 90;
PLATE_RADIUS = 16;
PLATE_HEIGHT = 20;

SH1_WDITH = 68;
SH1_DEPTH = 50;
SH1_HEIGHT = 30;

color("LightYellow", 1)
union() {
  translate([0, 0, -PLATE_HEIGHT])
  linear_extrude(height=PLATE_HEIGHT) {
    offset(r=PLATE_RADIUS)
      square(PLATE_WDITH - 2 * PLATE_RADIUS, center=true);
  }
  rotate([0, 0, 45])
  translate([-SH1_HEIGHT / 2, 0, 0]) rotate([0, 90, 0])
  linear_extrude(height=SH1_HEIGHT) {
  translate([-SH1_DEPTH, -SH1_WDITH / 2])
    union() {
      square([SH1_DEPTH, SH1_WDITH]);
      polygon([[0, 0], [0, SH1_WDITH], [-SH1_WDITH / 2, SH1_WDITH / 2]]);
    }
  }
}

color("Silver", 1)
translate([-13, 13, 25])
  rotate([-28, 0, 45])
      case_ss(
          depth=CASE_DEPTH
        , width=CASE_WIDTH
        , thickness=CASE_HEIGHT
        , edge_front=CASE_EDGE_FRONT
        , edge_back=CASE_EDGE_BACK
        , corner_radius=CASE_CORNER_R
        , usbc_width=USBC_WIDTH
        , usbc_depth=USBC_DEPTH
        , usbc_height_1=USBC_1_HEIGHT
        , usbc_height_2=USBC_2_HEIGHT
        , usbc_1_dy=USBC_1_DY
        , usbc_1_dx=USBC_1_DX
        , usbc_2_dy=USBC_2_DY
        , usbc_2_dx=USBC_2_DX
        , usbc_tunnel_xy_padding=USBC_TUNNEL_XY_PADDING
        , usbc_1_tunnel_extend_bottom=0
        , usbc_2_tunnel_extend_bottom=0
        , usbc_extend_top=2
        , tunnel_1=[]
        , tunnel_2=[]
        , delicate=true // cause lag in preview, switch before Render
        , fn=$fn);
