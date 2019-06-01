include <consts.scad>
use <comp/anchor.scad>

BASE_FRONT_EXT = 10;
BASE_BACK_EXT = 15;
BASE_HEIGHT_ABOVE_SURFACE = 0;

FLIP_EDGE_HEIGHT = 1.9;
FLIP_EDGE_EXT = 2.6;

FLIP_FRONT_HEIGHT = 1.9;
CLIP_HEIGHT = 3;
CLIP_WIDTH = BASE_WIDTH / 4;

USB_WIDTH = 7.7;
USB_DEPTH = 5.1;
USB_HEIGHT = 11.9;
USB_R = 3;
USB_TOP_EXT = 5;
USB_PADDING = 0;
USB_TUNNEL_BOTTOM_EXT = 20;
USB_CABLE_R1 = 2.45;
USB_CABLE_R2 = 1.5;

BASE_WIDTH = 46;
$fn=128;

difference() {
  union() {
    anchor(
        width=BASE_WIDTH / 2
      , height_above_surface = BASE_HEIGHT_ABOVE_SURFACE
      , rotate_radius = BASE_ROTATE_RADIUS
      , front_extension_depth = BASE_FRONT_EXT - FLIP_EDGE_EXT
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
    // emboss to support cable
    translate([0, -6, 0]) mirror([0, 1, 0])
    minkowski() {
      cube([1.6 * USB_DEPTH, USB_HEIGHT - 4.5, 0.6 * BASE_WIDTH / 2 - 1]);
      cylinder(r=r, h=1);
    }
  }
  translate([BASE_ROTATE_RADIUS - FLIP_EDGE_EXT, -FLIP_EDGE_HEIGHT, -5])
    cube([FLIP_EDGE_EXT + 5, FLIP_EDGE_HEIGHT, BASE_WIDTH + 10]);
  translate([4, BASE_HEIGHT_ABOVE_SURFACE - USB_HEIGHT, 7]) rotate([-90, 90, 0]) union() {
    linear_extrude(height=USB_HEIGHT + USB_TOP_EXT) {
      r = min(USB_WIDTH / 2, USB_DEPTH / 2, USB_R);
      echo(r);
      hull() {
        translate([-USB_WIDTH / 2 + r, -USB_DEPTH / 2 + r, 0]) circle(r);
        translate([USB_WIDTH / 2 - r,  -USB_DEPTH / 2 + r, 0]) circle(r);
        translate([USB_WIDTH / 2 - r,  USB_DEPTH / 2 - r, 0]) circle(r);
        translate([-USB_WIDTH / 2 + r,  USB_DEPTH / 2 - r, 0]) circle(r);
      }
    }
    translate([0, 0, -USB_TUNNEL_BOTTOM_EXT])
      cylinder(r=USB_CABLE_R1, h=USB_TUNNEL_BOTTOM_EXT + 5);
    hull() {
      translate([0, 0, -USB_TUNNEL_BOTTOM_EXT])
        cylinder(r=USB_CABLE_R2, h=USB_TUNNEL_BOTTOM_EXT + USB_HEIGHT + USB_TOP_EXT);
      translate([20, 0, -USB_TUNNEL_BOTTOM_EXT])
        cylinder(r=USB_CABLE_R2, h=USB_TUNNEL_BOTTOM_EXT + USB_HEIGHT + USB_TOP_EXT);
    }
  }
}
