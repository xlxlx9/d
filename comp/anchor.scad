module anchor(
    width=80,
    height_above_surface=20, 
    rotate_radius=9,
    front_extension_depth=15,
    back_extension_depth=17,
    back_plate_sink=2,
    back_plate_height=2.2,
    r=3) {
  linear_extrude(height=width) 
  difference() {
    union() {
      // 1/4 pie
      r = min(height_above_surface / 2 - 0.01, r);
      difference() {
        circle(r=rotate_radius);
        translate([-1.5 * rotate_radius, 0.1 * rotate_radius]) 
          square(3 * rotate_radius, 1.5 * rotate_radius);
        translate([-1.6 * rotate_radius, -1.1 * rotate_radius]) 
          square(1.5 * rotate_radius, 1.5 * rotate_radius);
      }
      // top
      translate([r - back_extension_depth, r])
      offset(r=r) {
        square([
            back_extension_depth + rotate_radius + front_extension_depth - 2 * r, 
            height_above_surface - 2 * r
          ]);
      }

      // back bottom
      translate([r - back_extension_depth, r - rotate_radius])
        difference() {
          offset(r=r) {
            square([back_extension_depth * 1.25 - 0 * r, rotate_radius + r]);
          }
          translate([- 2 * r - 0.125 * back_extension_depth, rotate_radius]) 
            square([back_extension_depth * 1.5 + 4 * r, 2 * r + rotate_radius]);
          translate([-r + back_extension_depth, -r * 1.5]) 
            square([back_extension_depth + 2 * r, rotate_radius + 4 * r]);
        }
    }
    // plate insert
    translate([0, -back_plate_sink - back_plate_height])
      mirror([1, 0, 0])
    square([back_extension_depth + 10, back_plate_height]);
  }
}

translate([-50, 0, 0]) anchor(height_above_surface=2, r=1);
anchor(height_above_surface=8, r=2);
translate([50, 0, 0]) anchor(height_above_surface=25, r=4, rotate_radius=13);
