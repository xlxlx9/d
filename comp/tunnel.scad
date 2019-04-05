
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
    path=bezier4(
        control_points[0]
      , control_points[1]
      , control_points[2]
      , control_points[3]
      , fn=fn
    );
    //echo(path);
    shape=[[-width / 2, -depth / 2], [-width / 2, depth / 2],
           [width / 2, depth / 2], [width / 2, -depth / 2]];
    path_extrude(exShape=shape, exPath=path, merge=false);
  }
}

tunnel_bezier(
    control_points=[[0, 0, 0], [15, 20, 30], [-40, 15, 50], [-90, -80, 115]]
  , fn=80
);
