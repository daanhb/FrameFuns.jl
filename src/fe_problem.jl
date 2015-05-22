# fe_problem.jl

abstract FE_Problem{N,T}

# This type groups the data corresponding to a FE problem.
immutable FE_DiscreteProblem{N,T} <: FE_Problem{N,T}
    domain          ::  AbstractDomain{N,T}
    fbasis1         ::  AbstractBasis
    fbasis2         ::  AbstractBasis

    tbasis1         ::  AbstractBasis
    tbasis2         ::  AbstractBasis

    tbasis_restricted   ::  AbstractBasis

    f_extension     ::  AbstractOperator
    f_restriction   ::  AbstractOperator

    t_extension     ::  AbstractOperator
    t_restriction   ::  AbstractOperator

    transform1      ::  AbstractOperator
    itransform1     ::  AbstractOperator

    transform2      ::  AbstractOperator
    itransform2     ::  AbstractOperator

    op              ::  AbstractOperator
    opt             ::  AbstractOperator

    function FE_DiscreteProblem(domain, fbasis1, fbasis2, tbasis1, tbasis2, tbasis_restricted, 
        f_extension, f_restriction, t_extension, t_restriction, 
        transform1, itransform1, transform2, itransform2)

        op  = t_restriction * itransform2 * f_extension
        opt = f_restriction * transform2 * t_extension

        new(domain, fbasis1, fbasis2, tbasis1, tbasis2, tbasis_restricted, 
            f_extension, f_restriction, t_extension, t_restriction, 
            transform1, itransform1, transform2, itransform2, 
            op, opt)
    end

end

FE_DiscreteProblem{N,T}(domain::AbstractDomain{N,T}, otherargs...) =
    FE_DiscreteProblem{N,T}(domain, otherargs...)

domain(p::FE_DiscreteProblem) = p.domain

numtype{N,T}(p::FE_DiscreteProblem{N,T}) = T

eltype(p::FE_DiscreteProblem) = eltype(operator(p))

dim{N}(p::FE_DiscreteProblem{N}) = N

operator(p::FE_DiscreteProblem) = p.op

operator_transpose(p::FE_DiscreteProblem) = p.opt

frequency_basis(p::FE_DiscreteProblem) = p.fbasis1

frequency_basis_ext(p::FE_DiscreteProblem) = p.fbasis2

time_basis(p::FE_DiscreteProblem) = p.tbasis1

time_basis_ext(p::FE_DiscreteProblem) = p.tbasis2

time_basis_restricted(p::FE_DiscreteProblem) = p.tbasis_restricted

size(p::FE_DiscreteProblem) = size(operator(p))

size(p::FE_DiscreteProblem, j) = size(operator(p), j)

size_ext(p::FE_DiscreteProblem) = size(frequency_basis_ext(p))

length_ext(p::FE_DiscreteProblem) = length(frequency_basis_ext(p))

size_ext(p::FE_DiscreteProblem, j) = size(frequency_basis_ext(p), j)

param_N(p::FE_DiscreteProblem) = length(time_basis(p))

param_L(p::FE_DiscreteProblem) = length(time_basis_ext(p))

param_M(p::FE_DiscreteProblem) = length(time_basis_restricted(p))

function rhs(p::FE_DiscreteProblem, f::Function, elt = eltype(p))
    grid1 = grid(time_basis_restricted(p))
    M = length(grid1)
    b = Array(elt, M)
    rhs!(p, b, f)
    b
end

function rhs!(p::FE_DiscreteProblem, b::Vector, f::Function)
    grid1 = grid(time_basis_restricted(p))
    M = length(grid1)

    @assert length(b) == M

    rhs!(grid1, b, f)
end

function rhs!(grid::AbstractGrid, b::Vector, f::Function)
    l = 0
    for i in eachindex(grid)
        l = l+1
        b[l] = f(grid[i])
    end
end

function rhs!(grid::MaskedGrid, b::Vector, f::Function)
    l = 0
    for i in eachindex_mask(grid)
        if in(i, grid)
            l = l+1
            b[l] = f(grid[i])
        end
    end
end


