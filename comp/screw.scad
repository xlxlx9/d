module screw_subtract(r0=2.5, h0=10, r1=1.25, h1=8) {
  cylinder(r=r0, h=h0);
  mirror([0, 0, 1]) cylinder(r=r1, h=h1);
}
