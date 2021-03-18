using FresnelIntegrals
using Plots

# https://mathworld.wolfram.com/CornuSpiral.html
plt = plot([],[],xlim=(-0.25,1),ylim=(0,0.8),aspect_ratio=:equal,legend=false)
maxt = 0;

@gif for ix=1:150
    maxt += 0.05
    x = zeros(0)
    y = zeros(0)
    tstep = 0.025
    maxr = 2
    veclen = tstep/2
    for t = 0:tstep:maxt
        ptx = fresnelc(t)
        pty = fresnels(t)

        append!(x,[ptx])
        append!(y,[pty])
    end

    plot(x,y,xlim=(-0.25,1),ylim=(0,0.8),aspect_ratio=:equal,legend=false)

    x = zeros(0)
    y = zeros(0)

    t = maxt
    kappa = t^2 * pi/2;
    ptx = real(fresnelc(t));
    pty = real(fresnels(t));
    dx = cos(kappa);
    dy = sin(kappa);
    r = 1/(4*t);
    cx = ptx - r*dy;
    cy = pty + r*dx;

    ticksize = 0.01;

    append!(x, [ptx-ticksize, ptx+ticksize,NaN,ptx,ptx,NaN]);
    append!(y ,[pty,pty,NaN,pty-ticksize,pty+ticksize,NaN]);
    ct = 0:0.01:2*pi;
    append!(x, cx .+ r*cos.(ct));
    append!(y, cy .+ r*sin.(ct));

    plot!(x,y)

    plot!([ptx, cx],[pty, cy])
end

