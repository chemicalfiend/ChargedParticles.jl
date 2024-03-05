export 
    Charge,
    Domain,
    System,
    distance,
    GetNeighbours

mutable struct Charge
    position::Vector{Float64}
    charge::Float64
    mass::Float64
    velocity::Vector{Float64}
end

struct Domain
    box::Vector{Float64}
end

mutable struct System{DL, CL}
    domains::DL
    charges::CL
end

function System(; domains, charges)
    DL = types(domains)
    CL = types(charges)
    return System{DL, CL}(domains, charges)
end

function distance(p1::Charge, p2::Charge)
    return sqrt(sum((p1.position - p2.position).^2))
end

function GetNeighbours(sys::System, p::Charge, cutoff::Float64)
    
    neighbour_list = []

    for particle in sys.charges
        d = distance(p, particle)
        if d < cutoff && d > 10^-15
            push!(neighbour_list, particle)
        end
    end
    return neighbour_list
end

