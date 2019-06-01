module anchor(
    width=80,
    height_above_surface=20, 
    rotate_radius=9,
    front_extension_depth=15,
    back_extension_depth=17,
    back_extension_under=12,
    back_plate_sink=2,
    back_plate_height=2.2,
    back_plate_depth=50,
    back_height_under=10,
    r=3) {
  linear_extrude(height=width) 
  difference() {
    union() {
      // 1/4 pie
      r = min(height_above_surface / 2 - 0.01, r);
*      difference() {
        circle(r=rotate_radius);
        translate([-1.5 * rotate_radius, 0.1 * rotate_radius]) 
          square(3 * rotate_radius, 1.5 * rotate_radius);
        translate([-1.6 * rotate_radius, -1.1 * rotate_radius]) 
          square(1.5 * rotate_radius, 1.5 * rotate_radius);
      }
     intersection() {
        translate([-back_plate_depth, 0])
          circle(back_plate_depth + rotate_radius);
        translate([-height_above_surface / 4, height_above_surface / 4]) mirror([0, 1, 0])
        square([rotate_radius + height_above_surface / 4, back_height_under + height_above_surface / 4]);
      }
      // top
      translate([r - back_extension_depth, r])
      offset(r=r) {
        square([
            back_extension_depth + rotate_radius + front_extension_depth - 2 * r, 
            height_above_surface - 2 * r
          ]);
      }

      // back surface, domanated by back_extension_depth
      translate([r - back_extension_depth, r - (back_plate_sink + back_plate_height / 2)])
        difference() {
          offset(r=r) {
            square([back_extension_depth * 1.25 - 0 * r, back_plate_sink + back_plate_height / 2 + r]);
          }
          translate([- 2 * r - 0.125 * back_extension_depth, back_plate_sink + back_plate_height / 2 - r + height_above_surface / 2]) 
            square([back_extension_depth * 1.5 + 4 * r, 2 * r + rotate_radius]);
          translate([-r + back_extension_depth, -r * 1.5]) 
            square([back_extension_depth + 2 * r, rotate_radius + 4 * r]);
        }
      // back bottom,  domanated by back_extension_under
      translate([r - back_extension_under, r - back_height_under])
        difference() {
          offset(r=r) {
            square([back_extension_under * 1.25 - 0 * r, back_height_under + r]);
          }
          translate([- 2 * r - 0.125 * back_extension_under, back_height_under - r - back_plate_sink - back_plate_height / 2]) 
            square([back_extension_under * 1.5 + 4 * r, 2 * r + back_height_under]);
          translate([-r + back_extension_under, -r * 1.5]) 
            square([back_extension_under + 2 * r, back_height_under + 4 * r]);
        }
    }
    // plate insert
    translate([0, -back_plate_sink - back_plate_height])
      mirror([1, 0, 0])
    square([max(back_extension_depth, back_extension_under) + 10, back_plate_height]);
  }
}

translate([-50, 0, 0]) anchor(height_above_surface=2, r=1, back_extension_depth=2, $fn=120);
anchor(height_above_surface=8, r=2, back_extension_under=7, back_height_under= 7, $fn=120);
translate([50, 0, 0]) anchor(height_above_surface=25, r=4, rotate_radius=13, back_extension_under=15, back_extension_depth=15, $fn=120);

