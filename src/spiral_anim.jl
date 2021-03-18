using FresnelIntegrals
using Plots

# Create animated GIF of growing Cornu spiral along with tangent circle of
# same radius of curvature.
plt = plot([],[],xlim=(-0.25,1),ylim=(0,0.8),aspect_ratio=:equal,legend=false)
maxt = 0;

@gif for ix=1:100
    maxt += 0.05
    x = zeros(0)
    y = zeros(0)
    tstep = 0.0125
    maxr = 2
    veclen = tstep/2
    for t = 0:tstep:maxt
        # P(t) is [C(t), S(t)], where those are the Fresnel integrals. For more
        # info see - https://en.wikipedia.org/wiki/Fresnel_integral
        ptx = real(fresnelc(t));
        pty = real(fresnels(t));

        append!(x,[ptx])
        append!(y,[pty])
    end

    plot(x,y,xlim=(-0.25,1),ylim=(0,0.8),aspect_ratio=:equal,legend=false)

    t = maxt
    ptx = real(fresnelc(t));
    pty = real(fresnels(t));
    dx = cos(pi/2 * t^2);
    dy = sin(pi/2 * t^2);

    # curvature is linear function of t
    r = 1/(4*t);
    cx = ptx - r*dy;
    cy = pty + r*dx;

    # draw circle
    x = zeros(0)
    y = zeros(0)
    ct = 0:0.01:2*pi;
    append!(x, cx .+ r*cos.(ct));
    append!(y, cy .+ r*sin.(ct));
    plot!(x,y)

    # add line from tangent point to center of circle
    plot!([ptx, cx],[pty, cy])
end
