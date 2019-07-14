include <consts.scad>
use <comp/anchor.scad>

BASE_FRONT_EXT = 10;
BASE_BACK_EXT = 15;
BASE_HEIGHT_ABOVE_SURFACE = 0;

FLIP_EDGE_HEIGHT = 1.9;
FLIP_EDGE_EXT = 2.6;

FLIP_FRONT_HEIGHT = 1.9;
CLIP_HEIGHT = 3;
// CLIP_WIDTH = BASE_WIDTH / 4;
CLIP_WIDTH = 10;

BASE_PLATE_HEIGHT = 2.12;

USB_WIDTH = 7.78;
USB_DEPTH = 5.18;
USB_HEIGHT = 13.62;
USB_R = 3;
USB_TOP_EXT = 5;
USB_PADDING = 0;
USB_TUNNEL_BOTTOM_EXT = 20;
USB_CABLE_R1 = 3.8 / 2;
USB_CABLE_R2 = 2.5 / 2;
USB_CABLE_R0 = 5.1 / 2;

SHF_WIDTH = 18;
SHF_DEPTH = 5.6;

BASE_WIDTH = 16;
//BASE_WIDTH = 104;
$fn=128;

module shuffle_base(zh=4) {
  hull() {
    translate([0, -SHF_WIDTH / 2 + SHF_DEPTH / 2, 0])
      cylinder(h=zh, r=SHF_DEPTH / 2);
    translate([0, SHF_WIDTH / 2 - SHF_DEPTH / 2, 0])
      cylinder(h=zh, r=SHF_DEPTH / 2);
  }
}

mirror([0, 1, 0]) translate([40, 0, 0])
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
    em_height = min(12, BASE_WIDTH / 2);
    translate([1, -6, 0]) mirror([0, 1, 0])
    minkowski() {
      cube([1.4 * USB_DEPTH, USB_HEIGHT - 4.5, em_height - 1]);
      cylinder(r=r, h=1);
    }
  }
  translate([BASE_ROTATE_RADIUS - FLIP_EDGE_EXT, -FLIP_EDGE_HEIGHT, -5])
    cube([FLIP_EDGE_EXT + 5, FLIP_EDGE_HEIGHT, BASE_WIDTH + 10]);
  translate([5, BASE_HEIGHT_ABOVE_SURFACE - USB_HEIGHT, 4]) rotate([-90, 90, 0]) union() {
    //rotate([0, 0, 111]) // uncomment if you wanna a different direction
    cylinder(h=USB_HEIGHT + USB_TOP_EXT, r=USB_CABLE_R0);

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

BASE_WIDTH_2 = 92;
difference() {
  union() {
    anchor(
        width=BASE_WIDTH_2 / 2
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
  }
  translate([BASE_ROTATE_RADIUS - FLIP_EDGE_EXT, -FLIP_EDGE_HEIGHT, -5])
    cube([FLIP_EDGE_EXT + 5, FLIP_EDGE_HEIGHT, BASE_WIDTH_2 + 10]);

  translate([-1, 1, 5]) {
    for(t=[0:4]) {
      translate([0, 0, 9 * t])
        rotate([90, 90, 0]) shuffle_base(3.15);
    }
  }
}
