use <../lib/bezier.scad>;

function outline2d(
    thickness=14.5, 
    height=30, 
    edge_front=4.9, 
    edge_back=3, 
    al = 1.05,
    bl = 0.75,
    ar = 0.95,
    br = 0.66
    ) = 
  let (
      p0l = [-thickness / 2, 0]
    , p1l = [-thickness / 2 * al, height * bl]
    , p2l = [-edge_back, height]
    , p2r = [edge_front, height]
    , p1r = [thickness / 2 * ar, height * br]
    , p0r = [thickness / 2, 0]
  )
  concat(
      bezier3(p0l, p1l, p2l)
    , bezier3(p2r, p1r, p0r)
  );

$fn=150;
polygon(outline2d());
