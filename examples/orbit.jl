using ChargedParticles
using GLMakie

a = Charge([0.0, 0.0, 0.0], 1e-3, 100.0, [0.0, 0.0, 0.0])
b = Charge([100.0, 0.0, 0.0], -1e-3, 0.1, [0.0, 30.0, 0.0])
d = Domain([10.0])
sys = System([d], [a, b])
sim = Simulation(sys, 0.1, 1000, 10000.0)

simulate!(sys, sim)

pos1 = sim.trajectory[:, 1, :]
pos2 = sim.trajectory[:, 2, :]


x = [pos1[1, 1], pos2[1, 1]]
y = [pos1[2, 1], pos2[2, 1]]
z = [pos1[3, 1], pos2[3, 1]]


fig, ax, scat = scatter(x, y, z)

fps = 30

record(fig, "animate.mp4", 1:1000) do i
    _x = [pos1[1, i], pos2[1, i]]
    _y = [pos1[2, i], pos2[2, i]]
    _z = [pos1[3, i], pos2[3, i]]

    scat[1] = _x
    scat[2] = _y
    scat[3] = _z
end

