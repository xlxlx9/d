module usbc_x(
    width=12
  , depth=6
  , xyr = 3
  , height=7
  , extend_top=0
  , tunnel_angle=90
  , tunnel_extend_top=5
  , tunnel_extend_bottom=3
  , tunnel_xy_padding=1
  ) {
  xyr = min(xyr, depth / 2);
  xyr = min(xyr, width / 2);
  linear_extrude(height=height + extend_top) {
    union() {
      if (depth > 2 * xyr)
        square([width, depth - 2 * xyr], center=true);
      if (width > 2 * xyr)
        square([width - 2 * xyr, depth], center=true);
      for (cxy = [[-1, -1], [-1, 1], [1, -1], [1, 1]]) 
        translate([cxy[0] * (width / 2 - xyr), cxy[1] * (depth / 2 - xyr)])
          circle(xyr);
    }
  }
}

usbc_x(xyr=3);
translate([0, 20, 0]) usbc_x(xyr=1, extend_top=2);
translate([0, -20, 0]) usbc_x(width=8, height=16, xyr=1);
translate([0, -40, 0]) usbc_x(width=8, depth=16, xyr=10);

