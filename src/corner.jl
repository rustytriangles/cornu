using FresnelIntegrals
using Plots

# reflect pt about a mirror line thru mpt in direction [1,-1]
function mirror(mpt, pt)
    dx = pt[1]-mpt[1]
    dy = pt[2]-mpt[2]

    [real(cx - dy), real(cy - dx)]
end


maxt = 0.5;

tstep = 0.025

x = zeros(0)
y = zeros(0)

# lead in
li = 0.5;
append!(x, [-li]);
append!(y, [ 0]);

sx = zeros(0);
sy = zeros(0);

# spiral in
for t = 0:tstep:maxt
    ptx = fresnelc(t)
    pty = fresnels(t)

    append!(sx,[ptx]);
    append!(sy,[pty]);
end
append!(x,sx);
append!(y,sy);

t = maxt
ptx = fresnelc(t)
pty = fresnels(t)
dx = cos(pi/2 * t^2);
dy = sin(pi/2 * t^2);
r = 1/(4*t);
cx = ptx - r*dy;
cy = pty + r*dx;

# arc
start_angle = atan(dy,-dx);
mirror_angle = 3*pi/4;
end_angle = 2*mirror_angle - start_angle;

a = start_angle:-0.05:end_angle;
append!(x,real(cx .+ r*sin.(a)));
append!(y,real(cy .+ r*cos.(a)));

# spiral out is reflection of spiral in
for i=length(sx):-1:1
    pt = mirror([cx,cy],[sx[i],sy[i]]);
    append!(x,pt[1]);
    append!(y,pt[2]);
end

# lead out is reflection of lead in
lastpt = mirror([cx,cy], [x[1], y[1]])
append!(x, lastpt[1]);
append!(y, lastpt[2]);

# draw that
pad = 0.1;
plot(x,y,legend=false,aspect_ratio=:equal,xlim=(-li,lastpt[1]+pad),ylim=(-pad,lastpt[2]))

# now draw a corner with a simple arc of the same radius
cx = lastpt[1] - r;
cy = r;
at = -pi/2:0.1:0;
ax = [-li];
ay = [0.];
append!(ax, cx .+ r*cos.(at));
append!(ay, cy .+ r*sin.(at));
append!(ax, [lastpt[1]]);
append!(ay, [lastpt[2]]);
plot!(ax, ay);

# add markers at the transition points
pt1 = [0,0];
pt2 = [sx[end], sy[end]];
pt3 = mirror([cx, cy], pt2);
pt4 = mirror([cx, cy], [pt1[1], pt1[2]]);

plot!([pt1[1], pt2[1], pt3[1], pt4[1]], [pt1[2], pt2[2], pt3[2], pt4[2]], seriestype=:scatter)

plot!([cx, lastpt[1]], [0, cy, lastpt[2]], seriestype=:scatter)
