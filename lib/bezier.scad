function bezier3(p0, p1, p2, close=true,fn=$fn) = [
  for (t=[0:1/fn:(1 + (close? (.5 / fn) : 0 ))])
    pow(1-t, 2) * p0 + 2 * (1 - t)* t * p1 + pow(t, 2) * p2
];

function bezier4(p0, p1, p2, p3, close=true,fn=$fn) = [
  for (t=[0:1/fn:(1 + (close? (.5 / fn) : 0 ))])
    pow(1 - t, 3) * p0 + 3 * (1 - t) * (1 - t)* t * p1 +
      3 * (1 - t) * pow(t, 2) * p2 + pow(t, 3) * p3
];
