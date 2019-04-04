use <../lib/bezier.scad>;

function outline2d(
    thickness=14.5, 
    height=30, 
    edge_front=4.9, 
    edge_back=3, 
    al = 1.05,
    bl = 0.75,
    ar = 0.95,
    br = 0.66,
    fn = $fn
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
      bezier3(p0l, p1l, p2l, fn=fn)
    , bezier3(p2r, p1r, p0r, fn=fn)
  );

function outline2d_ext(
    ext=10
  , thickness=14.5
  , height=30
  , edge_front=4.9
  , edge_back=3
  , al = 1.05
  , bl = 0.75
  , ar = 0.95
  , br = 0.66
  , fn = $fn
) =
  concat(
    [[-thickness / 2, -ext]],
    outline2d(thickness, height, edge_front, edge_back,
      al, bl, ar, br, fn),
    [[thickness / 2, -ext]]
  );

module pad_track(height=200, ptt2=2, pth3=22, fn=$fn) {
  linear_extrude(height=height) {
    polygon(bezier3([0, 0], [-ptt2, pth3 / 2], [0, pth3], fn=fn));
  }
}

module corner(
    width=300
  , depth=500
  , thickness=14.5
  , height=30
  , edge_front=4.9
  , edge_back=3
  , al = 1.05
  , bl = 0.75
  , ar = 0.95
  , br = 0.66
  , ptt2 = 2
  , pth3 = 22
  , psink = 0.6
  , pdy = -6
  , fn = $fn
) {
  translate([0, -height, 0])  // move edge of corner to y=0
  union() {
    linear_extrude(height=width)
      polygon(outline2d_ext(ext=depth- height, fn=fn));
    translate([-thickness / 2 + psink, pdy, 0])
      pad_track(height=width, ptt2=ptt2, pth3=pth3, fn=fn);
  }
}

corner(fn=80);
