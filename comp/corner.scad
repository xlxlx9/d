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
  , psink = 0.75
  , pdy = -5.3
  , pdz = 17
  , fn = $fn
) {
  translate([0, -height, 0])  // move edge of corner to y=0
  union() {
    linear_extrude(height=width)
      polygon(outline2d_ext(
            ext=depth - height,
          , thickness=thickness
          , height=height
          , edge_front=edge_front
          , edge_back=edge_back
          , al=al
          , bl=bl
          , ar=ar
          , br=br
          , fn=fn
      ));
    translate([-thickness / 2 + psink, pdy, pdz])
      pad_track(height=width - pdz, ptt2=ptt2, pth3=pth3, fn=fn);
  }
}

module corner_t(
    width=300
  , depth=500
  , thickness=14.5
  , height=30
  , edge_front=4.9
  , edge_back=3
  , corner_radius=9
  , delicate=false
  , al = 1.05
  , bl = 0.75
  , ar = 0.95
  , br = 0.66
  , ptt2 = 2
  , pth3 = 22
  , psink = 0.75
  , pdy = -5.3
  , pdz = 17
  , fn = $fn
) {
  translate([0, -height, 0])  // move edge of corner to y=0
  union() {
    intersection() {
      union() {
        difference() {
          intersection() {
            linear_extrude(height=width)
              polygon(outline2d_ext(
                    ext=depth - height,
                  , thickness=thickness
                  , height=height
                  , edge_front=edge_front
                  , edge_back=edge_back
                  , al=al
                  , bl=bl
                  , ar=ar
                  , br=br
                  , fn=fn
              ));
            translate([0, -depth + height, height])
            rotate([-90, 0, 0])
            linear_extrude(height=depth)
              polygon(outline2d_ext(
                    ext=width- height,
                  , thickness=thickness
                  , height=height
                  , edge_front=edge_front
                  , edge_back=edge_back
                  , al=al
                  , bl=bl
                  , ar=ar
                  , br=br
                  , fn=fn
              ));
          }
          if(delicate) {
            ovl = -1;
            translate([0, height, 0])
            rotate([0, 90, 0])
            cube([corner_radius * 2 + ovl, corner_radius * 2 + ovl, thickness * 2], center=true);
          }
        }
        if(delicate) {
          edge_crh = [for (p=outline2d(
              thickness=thickness
            , height=height
            , edge_front=edge_front
            , edge_back=edge_back
            , al=al
            , bl=bl
            , ar=ar
            , br=br
            , fn=fn
          )) if(p[1] > height - corner_radius)
            [p[1] - (height - corner_radius), p[0]]
          ];
          all_points = concat(
                [[0, edge_crh[0][1]]]
              , edge_crh
              , [[0, edge_crh[len(edge_crh) - 1][1]]]
          );
          //echo(all_points);
          translate([0, -corner_radius, corner_radius])
          translate([0, height, 0])
            rotate([0, 90, 0])
              rotate_extrude() {
                  polygon(all_points);
              }
        }
      }
      translate([thickness, -depth + height + corner_radius, corner_radius])
        rotate([0, -90, 0])
          linear_extrude(height=thickness * 2) {
            offset(r=corner_radius) {
              square([width - 2 * corner_radius, depth - 2 * corner_radius]);
            }
          }
    }
    translate([-thickness / 2 + psink, pdy, pdz])
      pad_track(height=width - pdz, ptt2=ptt2, pth3=pth3, fn=fn);
  }
}

corner(fn=80);
translate([40, 0, 0]) corner_t(fn=80);
translate([80, 0, 0]) corner_t(fn=80, delicate=true);
