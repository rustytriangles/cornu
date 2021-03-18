Julia sketches for exploring how Cornu spirals are used in reducing jerk in railway corners.

A [Cornu (or Euler) spiral](https://mathworld.wolfram.com/CornuSpiral.html) has a radius of curvature which decreases smoothly, as you can see in
this animation:

![screenshot](images/animated.gif)

This is useful in interpolating between a straight section of track (with infinite radius of curvature)
and a circular section of track (with constant radius of curvature).

This is what it looks like when used in a corner.

![screenshot](images/corner.png)

The red curve is a simple straight-arc-straight corner. The blue one has Cornu spiral transitions
between the straights and the arc. The arcs in each corner have the same radius. The markers highlight
where the different segments meet.
