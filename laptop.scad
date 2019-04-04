use <comp/corner.scad>
use <comp/usbc.scad>

module case_ss(
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
  , usbc_width=10.3
  , usbc_depth=6
  , usbc_height=7
  , usbc_xyr=3
  , usbc_1_dy=-26.5
  , usbc_1_dx=-1.6
  , usbc_2_dy=-39
  , usbc_2_dx=-1.6
  , usbc_extend_top=2
  , fn = $fn
) {
  union() {
    corner(
        width=width
      , depth=depth
      , thickness=thickness
      , height=height
      , edge_front=edge_front
      , edge_back=edge_back
      , al=al
      , bl=bl
      , ar=ar
      , br=br
      , ptt2=ptt2
      , pth3=pth3
      , psink=psink
      , pdy=pdy
      , fn=fn
    );
    translate([0, 0, -usbc_height]) {
      translate([usbc_1_dx, usbc_1_dy, 0])
        usbc_x(
            width=usbc_width
          , depth=usbc_depth
          , xyr=usbc_xyr
          , extend_top=usbc_extend_top
          , use_tunnel=false
        );
      translate([usbc_2_dx, usbc_2_dy, 0])
        usbc_x(
            width=usbc_width
          , depth=usbc_depth
          , xyr=usbc_xyr
          , extend_top=usbc_extend_top
          , use_tunnel=false
        );
    }
  }
}


case_ss(fn=80);
