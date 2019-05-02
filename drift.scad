use <laptop.scad>;

include <consts.scad>;
include <variants/model_15in.scad>;
include <variants/cr10_fc.scad>

$fn = 128;
extra_deg = atan2(CASE_WIDTH, CASE_DEPTH);

PLATE_WDITH = 90;
PLATE_RADIUS = 16;
PLATE_HEIGHT = 20;
PLATE_SINK = 5.6;
PLATE_LEEWAY = 0.5;

SH1_OFF_R = 4;
SH1_SINK_WIDTH = 76;
SH1_WDITH = 102 - 2 * SH1_OFF_R;
SH1_DEPTH = (SH1_WDITH + 2 * SH1_OFF_R) * 25 / 36 - 2 * SH1_OFF_R;
SH1_HEIGHT = 29.2;

USBC_2_WIDTH = 12.20 + 0.15 /*t2*/ + 0.2;
USBC_2_DEPTH = 6.45 + 0.15;
USBC_2_HEIGHT= 22.68 /*t3*/ + 0.08;
USBC_2_XYR = 1.25 /*t2*/ + 0.25;

PAD_PTT2 = 4.2;
PAD_SINK = 0.6;

// L brackets
LBR_WIDTH = 33;
LBR_DEPTH = 1.4;
LBR_HEIGHT_V = 26.3;
LBR_HOLE_CZ = 20.075 /*t2*/ - 0.8 /*t3*/ - 1.0;
LBR_HOLE_CX = 10.075 /*t2*/ - 0.8;
echo(LBR_HOLE_CX, LBR_HOLE_CZ);
LBR_SCREW_R = 1.6;

// hollow for cable observing
HW_R = 6;
HW_DIST = 4;

// VENT
VENT_DX = -4.5;
VENT_DY = -5.4;
VENT_DZ = 35;
VENT_R = 3;

intersection() {
* translate([40, 70, 0])
  cube([100, 100, 40], center=true);
* translate([20, 20, 0])
  cube([100, 100, 40], center=true);
* translate([10, 20, 0])
  rotate([0, 0, 90 - extra_deg])
  cube([100, 100, 40], center=true);

//rotate([-90, 0, 0])
color("LightYellow", 1)
difference() { // diff::br
rotate([0, 0, 45]) difference() {
union() {
*  translate([0, 0, -PLATE_HEIGHT])
  linear_extrude(height=PLATE_HEIGHT) {
    offset(r=PLATE_RADIUS)
      square(PLATE_WDITH - 2 * PLATE_RADIUS, center=true);
  }
  rotate([0, 0, 45])
  translate([-SH1_HEIGHT / 2, 0, 0]) rotate([0, 90, 0])
  linear_extrude(height=SH1_HEIGHT) {
    translate([-SH1_DEPTH, -SH1_WDITH / 2]) {
      offset(r=SH1_OFF_R)
      union() {
        square([SH1_DEPTH, SH1_WDITH]);
        polygon([[0, 0], [0, SH1_WDITH], [-SH1_WDITH * 7 / 18, SH1_WDITH / 2]]);
      }
    }
    translate([-SH1_DEPTH, -SH1_SINK_WIDTH / 2 + SH1_OFF_R])
      offset(r=SH1_OFF_R)
        square([SH1_DEPTH + PLATE_SINK, SH1_SINK_WIDTH - SH1_OFF_R * 2]);
  }
}

color("Silver", 1)
translate([-2, 2, 19])
  rotate([extra_deg - 90, 0, 45]) union() {
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
        , usbc_2_depth=USBC_2_DEPTH
        , usbc_2_height=USBC_2_HEIGHT
        , usbc_2_xyr=USBC_2_XYR
        , usbc_1_dy=USBC_1_DY
        , usbc_1_dx=USBC_1_DX
        , usbc_2_dy=USBC_2_DY
        , usbc_2_dx=USBC_2_DX
        , usbc_tunnel_xy_padding=USBC_TUNNEL_XY_PADDING
        , usbc_1_tunnel_extend_bottom=50
        , usbc_2_tunnel_extend_bottom=30
        , usbc_extend_top=16
        , tunnel_1=[[0, 0, 0], [0, 0, -10], [0, -11, -20], [0, -30, -47]]
        , tunnel_2=[]
        , ptt2=PAD_PTT2
        , psink=PAD_SINK
        , delicate=true // cause lag in preview, switch before Render
        , fn=$fn);
      // oberserving cables
      translate([0, (USBC_2_DY + USBC_1_DY) / 2, HW_R]) rotate([0, 90, 0])
      hull() {
        translate([0, -HW_DIST, 0]) cylinder(h=2 * SH1_HEIGHT, r=HW_R, center=false);
        translate([0,  HW_DIST, 0]) cylinder(h=2 * SH1_HEIGHT, r=HW_R, center=false);
      }
      // widen tunnels
      translate([0, (USBC_1_DY + USBC_2_DY) / 2, -42 / 2 - USBC_2_HEIGHT - 7])
        cube([USBC_2_WIDTH + USBC_TUNNEL_XY_PADDING * 2, 24, 42], center=true);
      // vent
      translate([VENT_DX, VENT_DY, VENT_DZ])
        cylinder(h=100, r=VENT_R);
  }
} // difference
// sink for L brackets
  translate([0, SH1_HEIGHT / 2, -PLATE_SINK]) 
    cube([LBR_WIDTH, 2 * LBR_DEPTH, LBR_HEIGHT_V * 2], center=true);
  translate([0, -SH1_HEIGHT / 2, -PLATE_SINK]) 
    cube([LBR_WIDTH, 2 * LBR_DEPTH, LBR_HEIGHT_V * 2], center=true);
// screws
for(t = [-1,1]) {
  translate([LBR_HOLE_CX * t, 0, LBR_HOLE_CZ - SH1_OFF_R - LBR_DEPTH])
    rotate([90, 0, 0])
    cylinder(h=3 * SH1_HEIGHT, r=LBR_SCREW_R, center=true);
} // for t cylinder
} // diff::br
} // intersection

difference() {
// plate
translate([0, 0, -40])
//translate([0, 0, -SH1_OFF_R])
color("Burlywood", 1)
difference() {
  rotate([0, 0, 45])
    translate([0, 0, -PLATE_HEIGHT])
    linear_extrude(height=PLATE_HEIGHT) {
      offset(r=PLATE_RADIUS)
        square(PLATE_WDITH - 2 * PLATE_RADIUS, center=true);
    }
  cube([SH1_SINK_WIDTH + 2 * SH1_OFF_R + 2 * PLATE_LEEWAY, 
        SH1_HEIGHT + 2 * PLATE_LEEWAY, PLATE_SINK * 2], center=true);
  // for export svg for laser cutting
  *rotate([0, 0, 45]) square([SH1_WDITH + 2 * SH1_OFF_R, SH1_HEIGHT], center=true);
  translate([0, 0, 0]) 
    cube([LBR_WIDTH, LBR_HEIGHT_V * 2 + SH1_HEIGHT, 2 * LBR_DEPTH], center=true);
  // for export svg for laser cutting
  *rotate([0, 0, 45]) square([LBR_WIDTH, LBR_HEIGHT_V * 2 + SH1_HEIGHT], center=true);
  for(i = [-1, 1]) {
    for(j = [-1, 1]) {
      translate([LBR_HOLE_CX * i, (LBR_HOLE_CZ + SH1_HEIGHT / 2 - LBR_DEPTH) * j, 0])
        cylinder(h=3 * PLATE_HEIGHT, r=LBR_SCREW_R, center=true);
    }
  }
}
*translate([0, 0, -40 - PLATE_HEIGHT * .6 -2 * PLATE_SINK]) rotate([0, 0, 45])
  scale([1.6, 1.6, 1.6])
    cube([PLATE_WDITH, PLATE_WDITH, PLATE_HEIGHT], center=true);
} // difference
