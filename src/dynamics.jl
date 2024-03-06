export
    k,
    Simulation,
    simulate!


const k = 9.0 * 10^9

mutable struct Simulation{P, V}
    trajectory::P
    velocities::V
    dt::Float64
    nsteps::Int
    cutoff::Float64
end

function Simulation(sys::System, dt::Float64, nsteps::Int, cutoff::Float64)
    trajectory = zeros(3, length(sys.charges), nsteps)
    velocities = zeros(3, length(sys.charges), nsteps)
    
    P = typeof(trajectory)
    V = typeof(velocities)
    return Simulation{P, V}(trajectory, velocities, dt, nsteps, cutoff)
end

function simulate!(sys::System, sim::Simulation)
    for i in 1:sim.nsteps
        for (j, particle) in enumerate(sys.charges)
            neighbours = GetNeighbours(sys, particle, sim.cutoff)

            F = zeros(3)
            for n in neighbours
                F += (k * particle.charge * n.charge / (distance(particle, n))^3)*(particle.position - n.position)
            end
            particle.velocity += (F/particle.mass)*sim.dt
            particle.position += particle.velocity * sim.dt

            sim.trajectory[:, j, i] = particle.position
            sim.velocities[:, j, i] = particle.velocity
        end
    end
end


