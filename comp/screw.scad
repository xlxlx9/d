module screw_subtract(r0=2.5, h0=10, r1=1.25, h1=8, hc=2.5) {
  // 0 cap and above
  // 1 shaft
  // hc height of cap
  translate([0, 0, hc])
    cylinder(r=r0, h=h0);
  cylinder(r1=r1, r2=r0, h=hc);
  mirror([0, 0, 1]) cylinder(r=r1, h=h1);
}
