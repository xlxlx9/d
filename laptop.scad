use <comp/corner.scad>
use <comp/usbc.scad>
use <comp/tunnel.scad>

module case_ss(
    width=300
  , depth=500
  , thickness=14.5
  , height=30
  , edge_front=4.9
  , edge_back=3
  , corner_radius=9
  , al = 1.05
  , bl = 0.75
  , ar = 0.95
  , br = 0.66
  , ptt2 = 2
  , pth3 = 22
  , psink = 0.6
  , pdy = -6
  , usbc_1_width=10.3
  , usbc_1_depth=6
  , usbc_1_height=7
  , usbc_1_xyr=3
  , usbc_2_width=10.3
  , usbc_2_depth=6
  , usbc_2_height=17
  , usbc_2_xyr=3
  , usbc_1_dy=-33.175
  , usbc_1_dx=-0.2
  , usbc_2_dy=-48.175
  , usbc_2_dx=-0.2
  , usbc_extend_top=2
  , usbc_1_tunnel_extend_bottom=2
  , usbc_2_tunnel_extend_bottom=2
  , usbc_tunnel_xy_padding=0.2
  , tunnel_1=[[0, 0, 0], [0, 0, -20], [0, 30, -30], [30, 90, 0]]
  , tunnel_2=[[0, 0, 0], [0, 0, -30], [-10, 30, -40], [-30, 90, 0]]
  , delicate=false
  , fn = $fn
) {
  union() {
    //corner(
    corner_t(
        width=width
      , depth=depth
      , thickness=thickness
      , height=height
      , edge_front=edge_front
      , edge_back=edge_back
      , corner_radius=corner_radius
      , al=al
      , bl=bl
      , ar=ar
      , br=br
      , ptt2=ptt2
      , pth3=pth3
      , psink=psink
      , pdy=pdy
      , delicate=delicate
      , fn=fn
    );
    translate([usbc_1_dx, usbc_1_dy, -usbc_1_height]) {
      usbc_x(
          width=usbc_1_width
        , depth=usbc_1_depth
        , height=usbc_1_height
        , xyr=usbc_1_xyr
        , tunnel_extend_top=usbc_extend_top
        , tunnel_extend_bottom=usbc_1_tunnel_extend_bottom
        , tunnel_xy_padding=usbc_tunnel_xy_padding
      );
      tunnel_bezier(
          control_points=tunnel_1
        , width=usbc_1_width + usbc_tunnel_xy_padding * 2
        , depth=usbc_1_depth + usbc_tunnel_xy_padding * 2
        , fn=fn
      );
    }
    translate([usbc_2_dx, usbc_2_dy, -usbc_2_height]) {
      usbc_x(
          width=usbc_2_width
        , depth=usbc_2_depth
        , height=usbc_2_height
        , xyr=usbc_2_xyr
        , tunnel_extend_top=usbc_extend_top
        , tunnel_extend_bottom=usbc_2_tunnel_extend_bottom
        , tunnel_xy_padding=usbc_tunnel_xy_padding
      );
      tunnel_bezier(
          control_points=tunnel_2
        , width=usbc_2_width + usbc_tunnel_xy_padding * 2
        , depth=usbc_2_depth + usbc_tunnel_xy_padding * 2
        , fn=fn
      );
    }
  }
}


case_ss(fn=80);
