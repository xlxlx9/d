use <../lib/bezier.scad>;

module wing(a=50, fn=$fn) {
    seq = [
      [0, 0],
      [0,5, 0.4],
      [1.15, -0.7],
      [0.5, -1]
    ];
    polygon(
      concat(
        bezier4(
          [0, 0],
          [0.85 * a, 1.45 * a],
          [1.6 * a, -0.5 * a],
          [1.1 * a, -1.05 * a],
          fn=fn
        ),
        bezier4(
          [1.1 * a, -1.05 * a],
          [0.6 * a, -1.5 * a],
          [0.3 * a, -0.4 * a],
          [0, 0],
          fn=fn
        )
      )
    );
}

module hollow(a=50, w=3, fn=$fn) {
  difference() {
    wing(a=a, fn=fn);
    offset(r=-w)
      wing(a=a, fn=fn);
  }
}


linear_extrude(height=25)
scale(2) {
  translate([-3.25, 0, 0])
    hollow(w=6);
  translate([3.25, 0, 0]) mirror([-1, 0, 0])
    hollow(w=6);
}

$fn = 128;
