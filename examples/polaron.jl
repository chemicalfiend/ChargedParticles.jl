using ChargedParticles
using GLMakie


lattice = []

for i in 1:10
    push!(lattice, Charge([200.0*i, 200.0, 0.0], 0.40*1e-3, 1.0, [0.0, 0.0, 0.0]))
    push!(lattice, Charge([200.0*i, 0.0, 0.0], 0.40*1e-3, 1.0, [0.0, 0.0, 0.0]))
end

nsteps = 1500

e = Charge([300.0, 100.0, 0.0], -0.25*1e-3, 0.1, [14.0, 0.0, 0.0])
d = Domain([10.0])
sys = System([d], [lattice..., e])
sim = Simulation(sys, 0.1, nsteps, 141.4)

colours = Int.([ones(20)..., 2.0])

simulate!(sys, sim)

x = sim.trajectory[1, :, 1]
y = sim.trajectory[2, :, 1]
z = sim.trajectory[3, :, 1]


fig, ax, scat = scatter(x, y, z, color=colours)

record(fig, "animate.mp4", 1:4:nsteps, size=(400, 800)) do i
    _x = sim.trajectory[1, :, i]
    _y = sim.trajectory[2, :, i]
    _z = sim.trajectory[3, :, i]

    scat[1] = _x
    scat[2] = _y
    scat[3] = _z
end

