using ChargedParticles
using Gnuplot

a = Charge([0.0, 0.0, 0.0], 1e-3, 100.0, [0.0, 0.0, 0.0])
b = Charge([100.0, 0.0, 0.0], -1e-3, 0.1, [0.0, 5, 0.0])
d = Domain([10.0])
sys = System([d], [a, b])
sim = Simulation(sys, 0.1, 1000, 10000.0)

simulate!(sys, sim)

pos1 = [sim.trajectory[:, 1, :]]
pos2 = [sim.trajectory[:, 2, :]]

x1 = [pos1[1][1], pos2[1][1]]
y1 = [pos1[1][2], pos2[1][2]]
z1 = [pos1[1][3], pos2[1][3]]

#@gsp :- "set title '2 charges'" 
#@gsp "set size ratio -1" "set xyplane at 0" xlab="X" ylab="Y" :-
#@gsp :-  x1  y1  z1 "w p t 'Scattered data' lc pal"
#@gsp :-  x2  y2  z2 "w p t 'Scattered data' lc pal"

x = (rand(200) .- 0.5) .* 3;
y = (rand(200) .- 0.5) .* 3;
z = exp.(-(x.^2 .+ y.^2));

# Interpolate on a 20x30 regular grid with splines
gx, gy, gz = dgrid3d(x, y, z, "20,30 splines")

@gsp "set size ratio -1" "set xyplane at 0" xlab="X" ylab="Y" :-
@gsp :-  x1  y1  z1 "w p t 'Scattered data' lc pal"

