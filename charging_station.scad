include <consts.scad>
use <comp/anchor.scad>

BASE_FRONT_EXT = 10;
BASE_BACK_EXT = 12;
BASE_HEIGHT_ABOVE_SURFACE = 1.4;

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

BASE_WIDTH = 40;
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
      , back_height_under = 13
      , r = BASE_EDGE_RADIUS
    );
    translate([
        BASE_ROTATE_RADIUS * 0.6, 
        -CLIP_HEIGHT- BASE_PLATE_SINK - BASE_PLATE_HEIGHT - FLIP_FRONT_HEIGHT, 
        0
    ])
      mirror([1, 0, 0])
        cube([
            BASE_BACK_UNDER + BASE_ROTATE_RADIUS * 0.6, 
            CLIP_HEIGHT, 
            BASE_WIDTH / 2 + CLIP_WIDTH
        ]);
  }
  translate([BASE_ROTATE_RADIUS - FLIP_EDGE_EXT, -FLIP_EDGE_HEIGHT, -5])
    cube([FLIP_EDGE_EXT + 5, FLIP_EDGE_HEIGHT, BASE_WIDTH + 10]);
  translate([
      0, 
      -CLIP_HEIGHT- BASE_PLATE_SINK - BASE_PLATE_HEIGHT - FLIP_FRONT_HEIGHT - BASE_ROTATE_RADIUS,
      0
  ])
*  translate([-BASE_BACK_UNDER - 5, 0, -5])
    cube([BASE_BACK_UNDER + BASE_ROTATE_RADIUS + 10, BASE_ROTATE_RADIUS, BASE_WIDTH + 10]);
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
