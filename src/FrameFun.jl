module FrameFun

using Base.Cartesian, StaticArrays, RecipesBase

using DomainSets
using BasisFunctions

using LinearAlgebra
using Printf
import LinearAlgebra: adjoint

###############################
## Exhaustive list of imports
###############################

## - Imports from Base
import Base: +, *, /, ^, ==, |, &, -, \, <, <=, >, >=

import Base: intersect, union, isapprox, setdiff, in

# Array interface
import Base: length, eltype, size, push!, similar
import Base: inv

# Iteration and indexing
import Base: eachindex, getindex, unsafe_getindex,
    checkbounds

# Display
import Base: show

import Base: promote, promote_rule, convert, promote_eltype

import Base: broadcast

import Base: minimum, maximum

## - Imports from DomainSets
import DomainSets: indomain, dimension
# - for mapped domains
import DomainSets: domain
# - for composite structures
import DomainSets: element, elements, numelements
# - for cartesian products
import DomainSets: cartesianproduct, ×


## - Imports from BasisFunctions
import BasisFunctions: src, dest, matrix, matrix!, apply, apply!, apply_inplace!,
    dimension, codomaintype, domaintype, apply_multiple
import BasisFunctions: Domain1d, Domain2d, Domain3d, Domain4d

import BasisFunctions: tensorproduct, ⊗, productelements, productelement

import BasisFunctions: interpolation_grid, left, right, stepsize, sample, support

import BasisFunctions: isbasis, isframe, isorthogonal, isorthonormal, isbiorthogonal,
    hastransform, hasinterpolationgrid, hasderivative,
    hasantiderivative, hasextension, hasgrid_transform

import BasisFunctions: hasmeasure, measure, gramoperator, dualdictionary, Measure, weights, grid, restrict

import BasisFunctions: operator, matrix, isdiag, isinplace, ⊕

import BasisFunctions: coefficients, dictionary,
    evaluation_operator, interpolation_operator,
    differentiation_operator, antidifferentiation_operator, approximation_operator,
    extension_size, extension_operator, restriction_operator, approximate,
    default_approximation_operator, hasextension, wrap_operator, grid_evaluation_operator

import BasisFunctions: superdict, similar_dictionary,
    promote_domaintype, promote_domainsubtype, promote_coefficienttype

import BasisFunctions: eval_element, eval_element_derivative, eval_expansion,
    unsafe_eval_element, unsafe_eval_element_derivative,
    name, in_support, dict_in_support, domain

import BasisFunctions: differentiate, ∂x, ∂y, ∂z, ∫∂x, ∫∂y, ∫∂z, ∫, iscompatible

import BasisFunctions: resize, promote_eltype

import BasisFunctions: show_setexpansion

import BasisFunctions: postprocess, plotgrid

import BasisFunctions: flatten

import BasisFunctions: Span, expansion

import BasisFunctions: coefficienttype, coefficienttype

# about subgrids
import BasisFunctions: AbstractSubGrid, IndexSubGrid, issubindex, supergrid,
    similar_subgrid, mask, subindices, grid

import BasisFunctions: discrete_approximation_operator, continuous_approximation_operator

import BasisFunctions: DictionarySolverOperator, GridSampling, ProjectionSampling,
            AbstractSolverOperator, SamplingOperator

# Function spaces
import BasisFunctions: quadraturenormalization
import BasisFunctions: L2


###############################
## Exhaustive list of exports
###############################

# TODO: where does this come from?
export ×

# from fun/funs.jl
export Fun, DictFun, sampling_grid, domain
# from fun/error.jl
export residual, abserror, maxerror, L2error

# from subgrid.jl
export MaskedGrid

# from domains/boundingbox.jl
export BoundingBox, BBox, BBox1, BBox2, BBox3, BBox4
export boundingbox

# from domains/extensions.jl
export distance, normal, volume

# from frames/extensionframe.jl
export ExtensionFrame, extensionframe, basis
export extension_frame_platform

# from frames/weighted_sum_frame.jl
export WeightedSumPlatform

# from frames/augmentation.jl
export AugmentationPlatform, ONB_plus_K

# from DiffEquation.jl
export DirichletBC, NeumannBC, DiffEquation, solve

# from randomgrid.jl
export randomgrid, randompoint

# from domains/fractals.jl
export mandelbrot, juliaset

# from domains/*.jl
export atomium, polardomain, characteristic

export FeFun, FeFunNd

# from diffequation.jl
export operator

# from approximation
export AZSolver, AZSmoothSolver, TridiagonalSolver, GenericAZSolver

# from platform/platform.jl
export SamplingStyle, SolverStyle, ProblemStyle
export InterpolationStyle, OversamplingStyle, GridStyle, GramStyle,
    RectangularGramStyle, GenericSamplingStyle, ProductSamplingStyle, DiscreteGramStyle
export DirectStyle, InverseStyle, DualStyle, IterativeStyle, AZStyle,
    AZSmoothStyle, TridiagonalProlateStyle, ProductSolverStyle
export GenericOperatorStyle, DictionaryOperatorStyle

# from platform/interface.jl
export approximate
export samplingoperator, dualsamplingoperator, samplingparameter,
    dictionary, dualplatformdictionary, solver, measure,
    discretization, dualdiscretization,
    smoothingoperator,
    plungeoperator, plungematrix, plungerank,
    AZ_A, AZ_Z, AZ_Zt
export interpolation_grid, oversampling_grid

# from platform/model.jl
export ModelPlatform

# from platform/bases.jl
export FourierPlatform, ChebyshevPlatform, FourierExtensionPlatform

# from platform/adaptive.jl
export GreedyStyle, SimpleStyle, OptimalStyle
export ResidualStyle, OversampledResidual, RandomPoints, FNAStyle


include("util/prettyprint.jl")

include("sampling/subgrid.jl")
include("sampling/boundary.jl")


include("domains/extensions.jl")

## Platforms
include("platform/platform.jl")
include("platform/interface.jl")
include("platform/productplatform.jl")
include("platform/model.jl")
include("platform/approximate.jl")
include("platform/adaptive.jl")
include("platform/bases.jl")

include("frames/extensionframe.jl")
include("frames/weighted_sum_frame.jl")
include("frames/augmentation.jl")

include("platform/duality.jl")

include("fun/funs.jl")
include("fun/error.jl")

include("approximation/randomized.jl")

include("approximation/lowranksolver.jl")
include("approximation/azsolver.jl")
include("approximation/generic_azsolver.jl")
include("approximation/tridiagonalsolver.jl")
include("approximation/smoothsolver.jl")

include("recipes.jl")

include("applications/diffequation.jl")

include("domains/fourierdomains.jl")
include("domains/fractals.jl")
include("domains/atomium.jl")
include("domains/characteristic.jl")
include("domains/polardomain.jl")

include("sampling/randomgrid.jl")
include("sampling/oversampledgrid.jl")

include("applications/weighted.jl")


end # module
