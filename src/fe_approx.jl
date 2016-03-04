# fe_fourier.jl


## "An ExpFun is a FrameFun based on Fourier series."
## ExpFun(f::Function; n=n, T=T, args...) = Fun(FourierBasis, f ; args...)
## # one of three things should be provided: n(tuple), domain or basis
## # only n
## ExpFun(f::Function, n::Int)
## ExpFun{N}(f::Function, n::Ntuple{N}) = Fun(FourierBasis, f, domain; args...)

## "A ChebyFun is a FrameFun based on Chebyshev polynomials."
## ChebyFun(f::Function; args...) = Fun(ChebyshevBasis, f; args...)
## ChebyFun(f::Function, domain; args...) = Fun(ChebyshevBasis, f, domain; args...)


function Fun(f::Function, basis::FunctionSet, domain::AbstractDomain; args...)
#    ELT = eltype(f, basis)
    frame = domainframe(domain, basis)
    A = approximation_operator(frame; args...)
    coef = A * f
    FrameFun(domain, dest(A), coef, A)
end


function eltype(f::Function, basis)
    ELT = eltype(basis)
    RT = Base.return_types(f,fill(ELT,dim(basis)))
    if (length(RT) > 0) && (RT[1] <: Complex)
        complexify(ELT)
    else
        ELT
    end
end



function approximation_operator(set::DomainFrame;
    sampling_factor = 2,
    solver = default_frame_solver(domain(set), basis(set)) )

    problem = FE_DiscreteProblem(domain(set), basis(set), sampling_factor)
    solver(problem)
end




######################
# Default parameters
######################

# The default parameters are:
# - n: number of degrees of freedom in the approximation
# - T: the extension parameter (size of the extended domain vs the original domain)
# - sampling: the (over)sampling factor
# - domain_nd: the domain
# - solver: the solver to use for solving the FE problem


default_frame_domain_1d(basis) = Interval()
default_frame_domain_2d(basis) = Interval() ⊗ Interval()
default_frame_domain_3d(basis) = Interval() ⊗ Interval() ⊗ Interval()


default_frame_n(domain::AbstractDomain1d, basis) = 61
default_frame_n(domain::AbstractDomain2d, basis) = (31, 31)
default_frame_n(domain::AbstractDomain3d, basis) = (7, 7, 7)


function default_frame_n(domain::TensorProductDomain, basis)
    s = [default_frame_n(domainlist(domain)[1], basis)...]
    for i = 2:tp_length(domain)
        s = [s; default_frame_n(domainlist(domain)[i], basis)...]
    end
    s = round(Int,s/dim(domain))
    tuple(s...)
end


default_frame_T{T}(domain::AbstractDomain{1,T}, basis) = 2*one(T)
default_frame_T{N,T}(domain::AbstractDomain{N,T}, basis) = ntuple(i->2*one(T),N)

default_frame_solver(domain, basis) = FE_ProjectionSolver

default_frame_solver{N}(domain::AbstractDomain, basis::FunctionSet{N,BigFloat}) = FE_DirectSolver
default_frame_solver{N}(domain::AbstractDomain, basis::FunctionSet{N,Complex{BigFloat}}) = FE_DirectSolver

