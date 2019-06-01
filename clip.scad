include <consts.scad>
use <comp/anchor.scad>

BASE_FRONT_EXT = 10 - 2;
BASE_BACK_EXT = 15;
BASE_HEIGHT_ABOVE_SURFACE = 0;

FLIP_EDGE_HEIGHT = 1.9;
FLIP_EDGE_EXT = 2.6;

FLIP_FRONT_HEIGHT = 1.9;
CLIP_HEIGHT = 3;
CLIP_WIDTH = BASE_WIDTH / 4;

$fn=128;
difference() {
  union() {
    anchor(
        width=BASE_WIDTH / 2
      , height_above_surface = BASE_HEIGHT_ABOVE_SURFACE
      , rotate_radius = BASE_ROTATE_RADIUS
      , front_extension_depth = BASE_FRONT_EXT
      , back_extension_depth = BASE_BACK_EXT
      , back_extension_under = BASE_BACK_UNDER
      , back_plate_height = BASE_PLATE_HEIGHT
      , back_plate_sink = BASE_PLATE_SINK
      , back_height_under = CLIP_HEIGHT + BASE_PLATE_SINK + BASE_PLATE_HEIGHT + FLIP_FRONT_HEIGHT
      , r = BASE_EDGE_RADIUS
    );
    r = BASE_EDGE_RADIUS;
    side_front_ext = BASE_ROTATE_RADIUS * 0.6;
    side_ext_depth = BASE_BACK_UNDER + side_front_ext;
    translate([
        side_front_ext,
        -CLIP_HEIGHT- BASE_PLATE_SINK - BASE_PLATE_HEIGHT - FLIP_FRONT_HEIGHT, 
        0
    ])
      mirror([1, 0, 0])
        hull() {
          translate([r, r, 0])
            cylinder(r=r, h=BASE_WIDTH / 2 + CLIP_WIDTH);
          translate([r, CLIP_HEIGHT - r, 0])
            cylinder(r=r, h=BASE_WIDTH / 2 + CLIP_WIDTH);
          translate([side_ext_depth - r, CLIP_HEIGHT - r, 0])
            cylinder(r=r, h=BASE_WIDTH / 2 + CLIP_WIDTH);
          translate([side_ext_depth - r, r, 0])
            cylinder(r=r, h=BASE_WIDTH / 2 + CLIP_WIDTH);
        }
  }
  translate([BASE_ROTATE_RADIUS - FLIP_EDGE_EXT, -FLIP_EDGE_HEIGHT, -5])
    cube([FLIP_EDGE_EXT + 5, FLIP_EDGE_HEIGHT, BASE_WIDTH + 10]);
}
