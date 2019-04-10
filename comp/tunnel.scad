
use <../lib/bezier.scad>
use <../lib/path_extrude.scad>

module tunnel_bezier(
    control_points 
  , width=10.7
  , depth=6.4
  , rotation=90
  , fn=$fn
) {
  if(4 > len(control_points)) {
    echo("Please pass at least 4 distinct points");
  } else {
    shape=[[-width / 2, -depth / 2], [-width / 2, depth / 2],
           [width / 2, depth / 2], [width / 2, -depth / 2]];
    for (i=[0:4:len(control_points) - len(control_points) % 4 - 1]) {
      path_extrude(
          exPath=bezier4(
            control_points[i]
          , control_points[i + 1]
          , control_points[i + 2]
          , control_points[i + 3]
          , fn=fn
          )
        , exShape=shape
        , merge=false
      );
    }
  }
}

tunnel_bezier(
    control_points=[[0, 0, 0], [15, 20, 30], [-40, 15, 50], [-90, -80, 115]]
  , fn=80
);
