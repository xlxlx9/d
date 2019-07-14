use <comp/anchor.scad>;
use <comp/cloud.scad>;
use <laptop.scad>;

include <consts.scad>;
include <variants/model_15in.scad>;
//include <variants/um3.scad>
include <variants/cr10vert15in.scad>
//include <variants/cr10_fc.scad>
//include <variants/power_cable_only.scad>

$fn = 128;
extra_deg = atan2(CASE_WIDTH, CASE_DEPTH);

// hollow for cable observing
HW_R = 6;
HW_DIST = 4;
FINGER_R = 9;

BASE_FRONT_EXT = 29.8;
BASE_BACK_EXT = 10;
BASE_BACK_UNDER = 10;

USBC_CABLE_R = 4.5 / 2;

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
      , back_height_under = 13.2
      , r = BASE_EDGE_RADIUS
    );

    // Use umbrella as closure
    difference() { 
      translate([9.8, 6, 0]) rotate([0, 0, -20])
      difference() {
        linear_extrude(height=BASE_WIDTH) {
          r0 = 61;
          r1 = 17.71;
          rh = 3.5;
          hull() {
            translate([0, r0 + rh]) circle(rh);
            translate([0, -rh * 4]) circle(rh);
          }
          // extra support
          *translate([r1 * 2 - 4.5, 0, 0]) square([rh, 10]);

          offset(r=2) difference() {
            circle(r0, $fn=200);
            for(t = [-1.5:1:1.5]) {
              translate([t * r1 * 1.8, (1.5 - abs(t)) * -2, 0]) circle(r1);
            }
            translate([0, -1.5 * r0, 0])
                square([3 * r0, 3 * r0], center=true);
          }
        }
        for (j=[0, 1]) {
          translate([0, 0, j * (BASE_WIDTH - 2) + (j * 2 - 1) * 1.2]) linear_extrude(height=2) {
            r0 = 59;
            r1 = 78;
            d1 = 43;
            r2 = 16;
            for(t = [0:1]) {
              mirror([t, 0, 0]) {
                offset(r=2) offset(r=-2) 
                  difference() {
                    circle(r0);
                    translate([d1, 0]) circle(r1);
                    translate([-1.5 * 2 * r2, 0]) circle(r2 + 5);
                  }
                offset(r=2) offset(r=-2) 
                  difference() {
                    translate([d1 + 7, 0]) circle(r1);
                    translate([-3.5, -200]) square([200, 400]);
                    translate([-0.5 * 2 * r2, 0]) circle(r2 + 3);
                  }
              }
            }
          }
        }
      }
      // do not intrude plate insert
      translate([-30, -BASE_PLATE_SINK - BASE_ROTATE_RADIUS, -BASE_WIDTH * 3]) 
        cube([30, BASE_ROTATE_RADIUS, 6 * BASE_WIDTH]);
    }
    // thickening
    hull() {
      translate([
          BASE_ROTATE_RADIUS + BASE_BUMP_DEPTH + BASE_BUMP_HEIGHT
          , 0, 0]) cylinder(h=BASE_WIDTH, r=BASE_BUMP_HEIGHT);
      translate([BASE_ROTATE_RADIUS + BASE_BUMP_DEPTH + BASE_BUMP_HEIGHT + 15
          , 0, 0]) cylinder(h=BASE_WIDTH, r=BASE_BUMP_HEIGHT);
    }
    hull() {
      translate([
          BASE_BUMP_HEIGHT - BASE_BACK_EXT
          , BASE_BUMP_HEIGHT / 2 , 0 ]) cylinder(h=BASE_WIDTH, r=BASE_BUMP_HEIGHT);
      translate([
          BASE_BUMP_HEIGHT - BASE_BACK_EXT
          , BASE_BUMP_HEIGHT / 3 + BASE_HEIGHT_ABOVE_SURFACE
          , 0 ]) cylinder(h=BASE_WIDTH, r=BASE_BUMP_HEIGHT);
      translate([
          BASE_ROTATE_RADIUS + BASE_BUMP_HEIGHT + BASE_FRONT_EXT - 1.8
          , BASE_BUMP_HEIGHT / 3 + BASE_HEIGHT_ABOVE_SURFACE
          , 0 ]) cylinder(h=BASE_WIDTH, r=BASE_BUMP_HEIGHT);
    }
  }

  // cable side clip exposed
  for (t=[0, BASE_WIDTH]) {
  translate([2, 0, t]) rotate([90, 0, 0]) hull() {
      translate([0, USBC_CABLE_R, 0])
        cylinder(center=true, h=BASE_WIDTH, r=USBC_CABLE_R);
      translate([0, -USBC_CABLE_R, 0])
        cylinder(center=true, h=BASE_WIDTH, r=USBC_CABLE_R);
    }
  }
  // laptop corner, cable support, and tunnel
  translate([-6.38, 0, 0]) rotate([180 + extra_deg, -90, 0])
    //translate([30, 0, 0])
    translate([15, 35, 37]) union() {
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
        , usbc_1_tunnel_extend_bottom=8
        , usbc_2_tunnel_extend_bottom=6.5
        , usbc_extend_top=6
        , tunnel_1=[]
        , tunnel_2=[]
        , delicate=true // cause lag in preview, switch before Render
        , fn=$fn);
      // oberserving cables
      translate([0, (USBC_2_DY + USBC_1_DY) / 2, HW_R]) rotate([0, 90, 0])
      hull() {
        translate([0, -HW_DIST, 0]) cylinder(h=2 * BASE_WIDTH, r=HW_R, center=false);
        translate([0,  HW_DIST, 0]) cylinder(h=2 * BASE_WIDTH, r=HW_R, center=false);
      }
      // widen tunnel
*      translate([USBC_1_DX, -20, -22]) rotate([0, 90, 0]) 
        linear_extrude(height=USBC_WIDTH + USBC_TUNNEL_XY_PADDING * 2, center=true) union() {
          union() {
            difference() {
              circle(30 - 4);
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
            mirror([0, 1, 0]) square([65, 19.7 - 4]);
        }
      // push by finger
      *translate([USBC_1_DX , (USBC_1_DY + USBC_2_DY) / 2, -8 - 5]) intersection() {
        mirror([0, 0, 1])
          cylinder(r=FINGER_R, h=USBC_1_HEIGHT + 18);
        translate([0, -2, -4.32 + 5 + 9]) rotate([0, 90, 0])
          cylinder(r=30, h=FINGER_R * 2 + 5, center=true);
      }
    }
  // make room for bump
  translate([BASE_ROTATE_RADIUS - 0.05, -BASE_BUMP_HEIGHT - 10, -5])
    cube([BASE_BUMP_DEPTH + 0.05, BASE_BUMP_HEIGHT + 10, BASE_WIDTH + 10]);
  // test cable alignment
*    rotate([0, 0, extra_deg])
      cube([40, 70, 2 * BASE_WIDTH], center=true);
*    rotate([0, 0, extra_deg])
      translate([65, 0, BASE_WIDTH / 2])
      cube([30, 150, 2 * BASE_WIDTH], center=true);
}

// test cable reach
*rotate([0, 0, extra_deg])
  cube([74, 60, 2 * BASE_WIDTH], center=true);
*translate([-9, 10, 0])
  cube([56, 56, 2 * BASE_WIDTH], center=true);
}
