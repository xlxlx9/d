use <comp/anchor.scad>;
use <comp/corner.scad>;
include <consts.scad>;

$fn = 128;

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

  translate([0, CASE_DEPTH / 8 - 4, BASE_WIDTH / 2])
  rotate([0, -18, 0])
    difference() {
      minkowski() { 
        cube([2 * CASE_HEIGHT, CASE_DEPTH / 4, CASE_WIDTH / 4], center=true);
        sphere(4);
      }
      translate([0, -CASE_DEPTH / 4, 0])
      cube([2 * CASE_HEIGHT + 10, CASE_DEPTH / 4 + 10, CASE_WIDTH / 4 + 10], center=true);
    }
  }
  extra_deg = atan2(CASE_WIDTH, CASE_DEPTH);
  rotate([180 + extra_deg, -18, 0])
    translate([15, -66, -20])
      corner(depth=CASE_DEPTH, width=CASE_WIDTH);
}