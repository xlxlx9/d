
module cloud_xy(
    thickness=30
  , offset_r=4
  , r1=30
  , r2=25
  , r3=35
) {
  linear_extrude(height=thickness) {
    translate([0, offset_r])
    offset(r=offset_r) difference() {
      union() {
        translate([-r1 * 0.7, r1 * 0.9]) circle(r1);
        translate([r2 + 0.4 * r3, r2 * 0.75]) circle(r2);
        translate([r3 * 0.45, r3 * 1.25]) circle(r3);
        translate([r3 * 0.25, r3 * 0.75]) circle(r3);
      }
      translate([-(r1 * 2 + r2 + r3), -2 * (r1 + r2 + r3)]) 
        square([2 * (r1 * 2 + r2 + r3), 2 * (r1 + r2 + r3)]);
    }
  }
}

cloud_xy();