module test_suite_applications
using BasisFunctions
using FrameFun
using FrameFun: overlapping_elements, boundary_support_grid, relative_indices, restriction_operator, boundary_element_indices, FrameFun.spline_util_restriction_operators
using Base.Test
using StaticArrays
using Domains
# Select the frame functions that overlap with the boundary


function delimit(s::AbstractString)
    println()
    println("############")
    println("# ",s)
    println("############")
end
delimit("Spline approximation")
@testset "Util" begin
    # center = @SVector [.5,.5]
    # domain  = disk(.3,center)
    # N1 = 40; N2 = 40;
    # degr1 = 2; degr2 = 3;
    degree = [2,3]
    init = [40,40]
    i = 1
    oversampling = 2
    center = @SVector [.5,.5]
    domain  = disk(.3,center)
    T = Float64
    platform=bspline_platform(T, init, degree, oversampling)
    fplatform = extension_frame_platform(platform, domain)

    B = superdict(primal(fplatform, i))
    S, R = spline_util_restriction_operators(fplatform, i)
    @test size(S)==(476, 1600)
    @test size(R)==(988 , 1808)

    omega_grid = BasisFunctions.grid(sampler(fplatform, 1))
    g = supergrid(omega_grid)

    g1 = boundary_grid(g, domain);
    g2 = boundary_support_grid(B,g1,omega_grid)
    @test g2.indices == CartesianIndex{2}[CartesianIndex{2}((34, 18)), CartesianIndex{2}((35, 18)), CartesianIndex{2}((36, 18)), CartesianIndex{2}((37, 18)), CartesianIndex{2}((38, 18)), CartesianIndex{2}((39, 18)), CartesianIndex{2}((40, 18)), CartesianIndex{2}((41, 18)), CartesianIndex{2}((42, 18)), CartesianIndex{2}((43, 18)), CartesianIndex{2}((44, 18)), CartesianIndex{2}((45, 18)), CartesianIndex{2}((46, 18)), CartesianIndex{2}((47, 18)), CartesianIndex{2}((31, 19)), CartesianIndex{2}((32, 19)), CartesianIndex{2}((33, 19)), CartesianIndex{2}((34, 19)), CartesianIndex{2}((35, 19)), CartesianIndex{2}((36, 19)), CartesianIndex{2}((37, 19)), CartesianIndex{2}((38, 19)), CartesianIndex{2}((39, 19)), CartesianIndex{2}((40, 19)), CartesianIndex{2}((41, 19)), CartesianIndex{2}((42, 19)), CartesianIndex{2}((43, 19)), CartesianIndex{2}((44, 19)), CartesianIndex{2}((45, 19)), CartesianIndex{2}((46, 19)), CartesianIndex{2}((47, 19)), CartesianIndex{2}((48, 19)), CartesianIndex{2}((49, 19)), CartesianIndex{2}((50, 19)), CartesianIndex{2}((29, 20)), CartesianIndex{2}((30, 20)), CartesianIndex{2}((31, 20)), CartesianIndex{2}((32, 20)), CartesianIndex{2}((33, 20)), CartesianIndex{2}((34, 20)), CartesianIndex{2}((35, 20)), CartesianIndex{2}((36, 20)), CartesianIndex{2}((37, 20)), CartesianIndex{2}((38, 20)), CartesianIndex{2}((39, 20)), CartesianIndex{2}((40, 20)), CartesianIndex{2}((41, 20)), CartesianIndex{2}((42, 20)), CartesianIndex{2}((43, 20)), CartesianIndex{2}((44, 20)), CartesianIndex{2}((45, 20)), CartesianIndex{2}((46, 20)), CartesianIndex{2}((47, 20)), CartesianIndex{2}((48, 20)), CartesianIndex{2}((49, 20)), CartesianIndex{2}((50, 20)), CartesianIndex{2}((51, 20)), CartesianIndex{2}((52, 20)), CartesianIndex{2}((28, 21)), CartesianIndex{2}((29, 21)), CartesianIndex{2}((30, 21)), CartesianIndex{2}((31, 21)), CartesianIndex{2}((32, 21)), CartesianIndex{2}((33, 21)), CartesianIndex{2}((34, 21)), CartesianIndex{2}((35, 21)), CartesianIndex{2}((36, 21)), CartesianIndex{2}((37, 21)), CartesianIndex{2}((38, 21)), CartesianIndex{2}((39, 21)), CartesianIndex{2}((40, 21)), CartesianIndex{2}((41, 21)), CartesianIndex{2}((42, 21)), CartesianIndex{2}((43, 21)), CartesianIndex{2}((44, 21)), CartesianIndex{2}((45, 21)), CartesianIndex{2}((46, 21)), CartesianIndex{2}((47, 21)), CartesianIndex{2}((48, 21)), CartesianIndex{2}((49, 21)), CartesianIndex{2}((50, 21)), CartesianIndex{2}((51, 21)), CartesianIndex{2}((52, 21)), CartesianIndex{2}((53, 21)), CartesianIndex{2}((26, 22)), CartesianIndex{2}((27, 22)), CartesianIndex{2}((28, 22)), CartesianIndex{2}((29, 22)), CartesianIndex{2}((30, 22)), CartesianIndex{2}((31, 22)), CartesianIndex{2}((32, 22)), CartesianIndex{2}((33, 22)), CartesianIndex{2}((34, 22)), CartesianIndex{2}((35, 22)), CartesianIndex{2}((36, 22)), CartesianIndex{2}((37, 22)), CartesianIndex{2}((38, 22)), CartesianIndex{2}((39, 22)), CartesianIndex{2}((40, 22)), CartesianIndex{2}((41, 22)), CartesianIndex{2}((42, 22)), CartesianIndex{2}((43, 22)), CartesianIndex{2}((44, 22)), CartesianIndex{2}((45, 22)), CartesianIndex{2}((46, 22)), CartesianIndex{2}((47, 22)), CartesianIndex{2}((48, 22)), CartesianIndex{2}((49, 22)), CartesianIndex{2}((50, 22)), CartesianIndex{2}((51, 22)), CartesianIndex{2}((52, 22)), CartesianIndex{2}((53, 22)), CartesianIndex{2}((54, 22)), CartesianIndex{2}((55, 22)), CartesianIndex{2}((25, 23)), CartesianIndex{2}((26, 23)), CartesianIndex{2}((27, 23)), CartesianIndex{2}((28, 23)), CartesianIndex{2}((29, 23)), CartesianIndex{2}((30, 23)), CartesianIndex{2}((31, 23)), CartesianIndex{2}((32, 23)), CartesianIndex{2}((33, 23)), CartesianIndex{2}((34, 23)), CartesianIndex{2}((35, 23)), CartesianIndex{2}((36, 23)), CartesianIndex{2}((37, 23)), CartesianIndex{2}((38, 23)), CartesianIndex{2}((39, 23)), CartesianIndex{2}((40, 23)), CartesianIndex{2}((41, 23)), CartesianIndex{2}((42, 23)), CartesianIndex{2}((43, 23)), CartesianIndex{2}((44, 23)), CartesianIndex{2}((45, 23)), CartesianIndex{2}((46, 23)), CartesianIndex{2}((47, 23)), CartesianIndex{2}((48, 23)), CartesianIndex{2}((49, 23)), CartesianIndex{2}((50, 23)), CartesianIndex{2}((51, 23)), CartesianIndex{2}((52, 23)), CartesianIndex{2}((53, 23)), CartesianIndex{2}((54, 23)), CartesianIndex{2}((55, 23)), CartesianIndex{2}((56, 23)), CartesianIndex{2}((24, 24)), CartesianIndex{2}((25, 24)), CartesianIndex{2}((26, 24)), CartesianIndex{2}((27, 24)), CartesianIndex{2}((28, 24)), CartesianIndex{2}((29, 24)), CartesianIndex{2}((30, 24)), CartesianIndex{2}((31, 24)), CartesianIndex{2}((32, 24)), CartesianIndex{2}((33, 24)), CartesianIndex{2}((34, 24)), CartesianIndex{2}((35, 24)), CartesianIndex{2}((36, 24)), CartesianIndex{2}((37, 24)), CartesianIndex{2}((38, 24)), CartesianIndex{2}((39, 24)), CartesianIndex{2}((40, 24)), CartesianIndex{2}((41, 24)), CartesianIndex{2}((42, 24)), CartesianIndex{2}((43, 24)), CartesianIndex{2}((44, 24)), CartesianIndex{2}((45, 24)), CartesianIndex{2}((46, 24)), CartesianIndex{2}((47, 24)), CartesianIndex{2}((48, 24)), CartesianIndex{2}((49, 24)), CartesianIndex{2}((50, 24)), CartesianIndex{2}((51, 24)), CartesianIndex{2}((52, 24)), CartesianIndex{2}((53, 24)), CartesianIndex{2}((54, 24)), CartesianIndex{2}((55, 24)), CartesianIndex{2}((56, 24)), CartesianIndex{2}((57, 24)), CartesianIndex{2}((23, 25)), CartesianIndex{2}((24, 25)), CartesianIndex{2}((25, 25)), CartesianIndex{2}((26, 25)), CartesianIndex{2}((27, 25)), CartesianIndex{2}((28, 25)), CartesianIndex{2}((29, 25)), CartesianIndex{2}((30, 25)), CartesianIndex{2}((31, 25)), CartesianIndex{2}((32, 25)), CartesianIndex{2}((33, 25)), CartesianIndex{2}((34, 25)), CartesianIndex{2}((35, 25)), CartesianIndex{2}((36, 25)), CartesianIndex{2}((45, 25)), CartesianIndex{2}((46, 25)), CartesianIndex{2}((47, 25)), CartesianIndex{2}((48, 25)), CartesianIndex{2}((49, 25)), CartesianIndex{2}((50, 25)), CartesianIndex{2}((51, 25)), CartesianIndex{2}((52, 25)), CartesianIndex{2}((53, 25)), CartesianIndex{2}((54, 25)), CartesianIndex{2}((55, 25)), CartesianIndex{2}((56, 25)), CartesianIndex{2}((57, 25)), CartesianIndex{2}((58, 25)), CartesianIndex{2}((22, 26)), CartesianIndex{2}((23, 26)), CartesianIndex{2}((24, 26)), CartesianIndex{2}((25, 26)), CartesianIndex{2}((26, 26)), CartesianIndex{2}((27, 26)), CartesianIndex{2}((28, 26)), CartesianIndex{2}((29, 26)), CartesianIndex{2}((30, 26)), CartesianIndex{2}((31, 26)), CartesianIndex{2}((32, 26)), CartesianIndex{2}((33, 26)), CartesianIndex{2}((34, 26)), CartesianIndex{2}((35, 26)), CartesianIndex{2}((36, 26)), CartesianIndex{2}((45, 26)), CartesianIndex{2}((46, 26)), CartesianIndex{2}((47, 26)), CartesianIndex{2}((48, 26)), CartesianIndex{2}((49, 26)), CartesianIndex{2}((50, 26)), CartesianIndex{2}((51, 26)), CartesianIndex{2}((52, 26)), CartesianIndex{2}((53, 26)), CartesianIndex{2}((54, 26)), CartesianIndex{2}((55, 26)), CartesianIndex{2}((56, 26)), CartesianIndex{2}((57, 26)), CartesianIndex{2}((58, 26)), CartesianIndex{2}((59, 26)), CartesianIndex{2}((22, 27)), CartesianIndex{2}((23, 27)), CartesianIndex{2}((24, 27)), CartesianIndex{2}((25, 27)), CartesianIndex{2}((26, 27)), CartesianIndex{2}((27, 27)), CartesianIndex{2}((28, 27)), CartesianIndex{2}((29, 27)), CartesianIndex{2}((30, 27)), CartesianIndex{2}((31, 27)), CartesianIndex{2}((32, 27)), CartesianIndex{2}((49, 27)), CartesianIndex{2}((50, 27)), CartesianIndex{2}((51, 27)), CartesianIndex{2}((52, 27)), CartesianIndex{2}((53, 27)), CartesianIndex{2}((54, 27)), CartesianIndex{2}((55, 27)), CartesianIndex{2}((56, 27)), CartesianIndex{2}((57, 27)), CartesianIndex{2}((58, 27)), CartesianIndex{2}((59, 27)), CartesianIndex{2}((21, 28)), CartesianIndex{2}((22, 28)), CartesianIndex{2}((23, 28)), CartesianIndex{2}((24, 28)), CartesianIndex{2}((25, 28)), CartesianIndex{2}((26, 28)), CartesianIndex{2}((27, 28)), CartesianIndex{2}((28, 28)), CartesianIndex{2}((29, 28)), CartesianIndex{2}((30, 28)), CartesianIndex{2}((31, 28)), CartesianIndex{2}((32, 28)), CartesianIndex{2}((49, 28)), CartesianIndex{2}((50, 28)), CartesianIndex{2}((51, 28)), CartesianIndex{2}((52, 28)), CartesianIndex{2}((53, 28)), CartesianIndex{2}((54, 28)), CartesianIndex{2}((55, 28)), CartesianIndex{2}((56, 28)), CartesianIndex{2}((57, 28)), CartesianIndex{2}((58, 28)), CartesianIndex{2}((59, 28)), CartesianIndex{2}((60, 28)), CartesianIndex{2}((20, 29)), CartesianIndex{2}((21, 29)), CartesianIndex{2}((22, 29)), CartesianIndex{2}((23, 29)), CartesianIndex{2}((24, 29)), CartesianIndex{2}((25, 29)), CartesianIndex{2}((26, 29)), CartesianIndex{2}((27, 29)), CartesianIndex{2}((28, 29)), CartesianIndex{2}((29, 29)), CartesianIndex{2}((30, 29)), CartesianIndex{2}((51, 29)), CartesianIndex{2}((52, 29)), CartesianIndex{2}((53, 29)), CartesianIndex{2}((54, 29)), CartesianIndex{2}((55, 29)), CartesianIndex{2}((56, 29)), CartesianIndex{2}((57, 29)), CartesianIndex{2}((58, 29)), CartesianIndex{2}((59, 29)), CartesianIndex{2}((60, 29)), CartesianIndex{2}((61, 29)), CartesianIndex{2}((20, 30)), CartesianIndex{2}((21, 30)), CartesianIndex{2}((22, 30)), CartesianIndex{2}((23, 30)), CartesianIndex{2}((24, 30)), CartesianIndex{2}((25, 30)), CartesianIndex{2}((26, 30)), CartesianIndex{2}((27, 30)), CartesianIndex{2}((28, 30)), CartesianIndex{2}((29, 30)), CartesianIndex{2}((30, 30)), CartesianIndex{2}((51, 30)), CartesianIndex{2}((52, 30)), CartesianIndex{2}((53, 30)), CartesianIndex{2}((54, 30)), CartesianIndex{2}((55, 30)), CartesianIndex{2}((56, 30)), CartesianIndex{2}((57, 30)), CartesianIndex{2}((58, 30)), CartesianIndex{2}((59, 30)), CartesianIndex{2}((60, 30)), CartesianIndex{2}((61, 30)), CartesianIndex{2}((19, 31)), CartesianIndex{2}((20, 31)), CartesianIndex{2}((21, 31)), CartesianIndex{2}((22, 31)), CartesianIndex{2}((23, 31)), CartesianIndex{2}((24, 31)), CartesianIndex{2}((25, 31)), CartesianIndex{2}((26, 31)), CartesianIndex{2}((27, 31)), CartesianIndex{2}((28, 31)), CartesianIndex{2}((53, 31)), CartesianIndex{2}((54, 31)), CartesianIndex{2}((55, 31)), CartesianIndex{2}((56, 31)), CartesianIndex{2}((57, 31)), CartesianIndex{2}((58, 31)), CartesianIndex{2}((59, 31)), CartesianIndex{2}((60, 31)), CartesianIndex{2}((61, 31)), CartesianIndex{2}((62, 31)), CartesianIndex{2}((19, 32)), CartesianIndex{2}((20, 32)), CartesianIndex{2}((21, 32)), CartesianIndex{2}((22, 32)), CartesianIndex{2}((23, 32)), CartesianIndex{2}((24, 32)), CartesianIndex{2}((25, 32)), CartesianIndex{2}((26, 32)), CartesianIndex{2}((27, 32)), CartesianIndex{2}((28, 32)), CartesianIndex{2}((53, 32)), CartesianIndex{2}((54, 32)), CartesianIndex{2}((55, 32)), CartesianIndex{2}((56, 32)), CartesianIndex{2}((57, 32)), CartesianIndex{2}((58, 32)), CartesianIndex{2}((59, 32)), CartesianIndex{2}((60, 32)), CartesianIndex{2}((61, 32)), CartesianIndex{2}((62, 32)), CartesianIndex{2}((18, 33)), CartesianIndex{2}((19, 33)), CartesianIndex{2}((20, 33)), CartesianIndex{2}((21, 33)), CartesianIndex{2}((22, 33)), CartesianIndex{2}((23, 33)), CartesianIndex{2}((24, 33)), CartesianIndex{2}((25, 33)), CartesianIndex{2}((26, 33)), CartesianIndex{2}((55, 33)), CartesianIndex{2}((56, 33)), CartesianIndex{2}((57, 33)), CartesianIndex{2}((58, 33)), CartesianIndex{2}((59, 33)), CartesianIndex{2}((60, 33)), CartesianIndex{2}((61, 33)), CartesianIndex{2}((62, 33)), CartesianIndex{2}((63, 33)), CartesianIndex{2}((18, 34)), CartesianIndex{2}((19, 34)), CartesianIndex{2}((20, 34)), CartesianIndex{2}((21, 34)), CartesianIndex{2}((22, 34)), CartesianIndex{2}((23, 34)), CartesianIndex{2}((24, 34)), CartesianIndex{2}((25, 34)), CartesianIndex{2}((26, 34)), CartesianIndex{2}((55, 34)), CartesianIndex{2}((56, 34)), CartesianIndex{2}((57, 34)), CartesianIndex{2}((58, 34)), CartesianIndex{2}((59, 34)), CartesianIndex{2}((60, 34)), CartesianIndex{2}((61, 34)), CartesianIndex{2}((62, 34)), CartesianIndex{2}((63, 34)), CartesianIndex{2}((18, 35)), CartesianIndex{2}((19, 35)), CartesianIndex{2}((20, 35)), CartesianIndex{2}((21, 35)), CartesianIndex{2}((22, 35)), CartesianIndex{2}((23, 35)), CartesianIndex{2}((24, 35)), CartesianIndex{2}((57, 35)), CartesianIndex{2}((58, 35)), CartesianIndex{2}((59, 35)), CartesianIndex{2}((60, 35)), CartesianIndex{2}((61, 35)), CartesianIndex{2}((62, 35)), CartesianIndex{2}((63, 35)), CartesianIndex{2}((18, 36)), CartesianIndex{2}((19, 36)), CartesianIndex{2}((20, 36)), CartesianIndex{2}((21, 36)), CartesianIndex{2}((22, 36)), CartesianIndex{2}((23, 36)), CartesianIndex{2}((24, 36)), CartesianIndex{2}((57, 36)), CartesianIndex{2}((58, 36)), CartesianIndex{2}((59, 36)), CartesianIndex{2}((60, 36)), CartesianIndex{2}((61, 36)), CartesianIndex{2}((62, 36)), CartesianIndex{2}((63, 36)), CartesianIndex{2}((17, 37)), CartesianIndex{2}((18, 37)), CartesianIndex{2}((19, 37)), CartesianIndex{2}((20, 37)), CartesianIndex{2}((21, 37)), CartesianIndex{2}((22, 37)), CartesianIndex{2}((23, 37)), CartesianIndex{2}((24, 37)), CartesianIndex{2}((57, 37)), CartesianIndex{2}((58, 37)), CartesianIndex{2}((59, 37)), CartesianIndex{2}((60, 37)), CartesianIndex{2}((61, 37)), CartesianIndex{2}((62, 37)), CartesianIndex{2}((63, 37)), CartesianIndex{2}((64, 37)), CartesianIndex{2}((17, 38)), CartesianIndex{2}((18, 38)), CartesianIndex{2}((19, 38)), CartesianIndex{2}((20, 38)), CartesianIndex{2}((21, 38)), CartesianIndex{2}((22, 38)), CartesianIndex{2}((23, 38)), CartesianIndex{2}((24, 38)), CartesianIndex{2}((57, 38)), CartesianIndex{2}((58, 38)), CartesianIndex{2}((59, 38)), CartesianIndex{2}((60, 38)), CartesianIndex{2}((61, 38)), CartesianIndex{2}((62, 38)), CartesianIndex{2}((63, 38)), CartesianIndex{2}((64, 38)), CartesianIndex{2}((17, 39)), CartesianIndex{2}((18, 39)), CartesianIndex{2}((19, 39)), CartesianIndex{2}((20, 39)), CartesianIndex{2}((21, 39)), CartesianIndex{2}((22, 39)), CartesianIndex{2}((59, 39)), CartesianIndex{2}((60, 39)), CartesianIndex{2}((61, 39)), CartesianIndex{2}((62, 39)), CartesianIndex{2}((63, 39)), CartesianIndex{2}((64, 39)), CartesianIndex{2}((17, 40)), CartesianIndex{2}((18, 40)), CartesianIndex{2}((19, 40)), CartesianIndex{2}((20, 40)), CartesianIndex{2}((21, 40)), CartesianIndex{2}((22, 40)), CartesianIndex{2}((59, 40)), CartesianIndex{2}((60, 40)), CartesianIndex{2}((61, 40)), CartesianIndex{2}((62, 40)), CartesianIndex{2}((63, 40)), CartesianIndex{2}((64, 40)), CartesianIndex{2}((17, 41)), CartesianIndex{2}((18, 41)), CartesianIndex{2}((19, 41)), CartesianIndex{2}((20, 41)), CartesianIndex{2}((21, 41)), CartesianIndex{2}((22, 41)), CartesianIndex{2}((59, 41)), CartesianIndex{2}((60, 41)), CartesianIndex{2}((61, 41)), CartesianIndex{2}((62, 41)), CartesianIndex{2}((63, 41)), CartesianIndex{2}((64, 41)), CartesianIndex{2}((17, 42)), CartesianIndex{2}((18, 42)), CartesianIndex{2}((19, 42)), CartesianIndex{2}((20, 42)), CartesianIndex{2}((21, 42)), CartesianIndex{2}((22, 42)), CartesianIndex{2}((59, 42)), CartesianIndex{2}((60, 42)), CartesianIndex{2}((61, 42)), CartesianIndex{2}((62, 42)), CartesianIndex{2}((63, 42)), CartesianIndex{2}((64, 42)), CartesianIndex{2}((17, 43)), CartesianIndex{2}((18, 43)), CartesianIndex{2}((19, 43)), CartesianIndex{2}((20, 43)), CartesianIndex{2}((21, 43)), CartesianIndex{2}((22, 43)), CartesianIndex{2}((59, 43)), CartesianIndex{2}((60, 43)), CartesianIndex{2}((61, 43)), CartesianIndex{2}((62, 43)), CartesianIndex{2}((63, 43)), CartesianIndex{2}((64, 43)), CartesianIndex{2}((17, 44)), CartesianIndex{2}((18, 44)), CartesianIndex{2}((19, 44)), CartesianIndex{2}((20, 44)), CartesianIndex{2}((21, 44)), CartesianIndex{2}((22, 44)), CartesianIndex{2}((23, 44)), CartesianIndex{2}((24, 44)), CartesianIndex{2}((57, 44)), CartesianIndex{2}((58, 44)), CartesianIndex{2}((59, 44)), CartesianIndex{2}((60, 44)), CartesianIndex{2}((61, 44)), CartesianIndex{2}((62, 44)), CartesianIndex{2}((63, 44)), CartesianIndex{2}((64, 44)), CartesianIndex{2}((17, 45)), CartesianIndex{2}((18, 45)), CartesianIndex{2}((19, 45)), CartesianIndex{2}((20, 45)), CartesianIndex{2}((21, 45)), CartesianIndex{2}((22, 45)), CartesianIndex{2}((23, 45)), CartesianIndex{2}((24, 45)), CartesianIndex{2}((57, 45)), CartesianIndex{2}((58, 45)), CartesianIndex{2}((59, 45)), CartesianIndex{2}((60, 45)), CartesianIndex{2}((61, 45)), CartesianIndex{2}((62, 45)), CartesianIndex{2}((63, 45)), CartesianIndex{2}((64, 45)), CartesianIndex{2}((18, 46)), CartesianIndex{2}((19, 46)), CartesianIndex{2}((20, 46)), CartesianIndex{2}((21, 46)), CartesianIndex{2}((22, 46)), CartesianIndex{2}((23, 46)), CartesianIndex{2}((24, 46)), CartesianIndex{2}((57, 46)), CartesianIndex{2}((58, 46)), CartesianIndex{2}((59, 46)), CartesianIndex{2}((60, 46)), CartesianIndex{2}((61, 46)), CartesianIndex{2}((62, 46)), CartesianIndex{2}((63, 46)), CartesianIndex{2}((18, 47)), CartesianIndex{2}((19, 47)), CartesianIndex{2}((20, 47)), CartesianIndex{2}((21, 47)), CartesianIndex{2}((22, 47)), CartesianIndex{2}((23, 47)), CartesianIndex{2}((24, 47)), CartesianIndex{2}((57, 47)), CartesianIndex{2}((58, 47)), CartesianIndex{2}((59, 47)), CartesianIndex{2}((60, 47)), CartesianIndex{2}((61, 47)), CartesianIndex{2}((62, 47)), CartesianIndex{2}((63, 47)), CartesianIndex{2}((18, 48)), CartesianIndex{2}((19, 48)), CartesianIndex{2}((20, 48)), CartesianIndex{2}((21, 48)), CartesianIndex{2}((22, 48)), CartesianIndex{2}((23, 48)), CartesianIndex{2}((24, 48)), CartesianIndex{2}((25, 48)), CartesianIndex{2}((26, 48)), CartesianIndex{2}((55, 48)), CartesianIndex{2}((56, 48)), CartesianIndex{2}((57, 48)), CartesianIndex{2}((58, 48)), CartesianIndex{2}((59, 48)), CartesianIndex{2}((60, 48)), CartesianIndex{2}((61, 48)), CartesianIndex{2}((62, 48)), CartesianIndex{2}((63, 48)), CartesianIndex{2}((18, 49)), CartesianIndex{2}((19, 49)), CartesianIndex{2}((20, 49)), CartesianIndex{2}((21, 49)), CartesianIndex{2}((22, 49)), CartesianIndex{2}((23, 49)), CartesianIndex{2}((24, 49)), CartesianIndex{2}((25, 49)), CartesianIndex{2}((26, 49)), CartesianIndex{2}((55, 49)), CartesianIndex{2}((56, 49)), CartesianIndex{2}((57, 49)), CartesianIndex{2}((58, 49)), CartesianIndex{2}((59, 49)), CartesianIndex{2}((60, 49)), CartesianIndex{2}((61, 49)), CartesianIndex{2}((62, 49)), CartesianIndex{2}((63, 49)), CartesianIndex{2}((19, 50)), CartesianIndex{2}((20, 50)), CartesianIndex{2}((21, 50)), CartesianIndex{2}((22, 50)), CartesianIndex{2}((23, 50)), CartesianIndex{2}((24, 50)), CartesianIndex{2}((25, 50)), CartesianIndex{2}((26, 50)), CartesianIndex{2}((27, 50)), CartesianIndex{2}((28, 50)), CartesianIndex{2}((53, 50)), CartesianIndex{2}((54, 50)), CartesianIndex{2}((55, 50)), CartesianIndex{2}((56, 50)), CartesianIndex{2}((57, 50)), CartesianIndex{2}((58, 50)), CartesianIndex{2}((59, 50)), CartesianIndex{2}((60, 50)), CartesianIndex{2}((61, 50)), CartesianIndex{2}((62, 50)), CartesianIndex{2}((19, 51)), CartesianIndex{2}((20, 51)), CartesianIndex{2}((21, 51)), CartesianIndex{2}((22, 51)), CartesianIndex{2}((23, 51)), CartesianIndex{2}((24, 51)), CartesianIndex{2}((25, 51)), CartesianIndex{2}((26, 51)), CartesianIndex{2}((27, 51)), CartesianIndex{2}((28, 51)), CartesianIndex{2}((53, 51)), CartesianIndex{2}((54, 51)), CartesianIndex{2}((55, 51)), CartesianIndex{2}((56, 51)), CartesianIndex{2}((57, 51)), CartesianIndex{2}((58, 51)), CartesianIndex{2}((59, 51)), CartesianIndex{2}((60, 51)), CartesianIndex{2}((61, 51)), CartesianIndex{2}((62, 51)), CartesianIndex{2}((20, 52)), CartesianIndex{2}((21, 52)), CartesianIndex{2}((22, 52)), CartesianIndex{2}((23, 52)), CartesianIndex{2}((24, 52)), CartesianIndex{2}((25, 52)), CartesianIndex{2}((26, 52)), CartesianIndex{2}((27, 52)), CartesianIndex{2}((28, 52)), CartesianIndex{2}((29, 52)), CartesianIndex{2}((30, 52)), CartesianIndex{2}((51, 52)), CartesianIndex{2}((52, 52)), CartesianIndex{2}((53, 52)), CartesianIndex{2}((54, 52)), CartesianIndex{2}((55, 52)), CartesianIndex{2}((56, 52)), CartesianIndex{2}((57, 52)), CartesianIndex{2}((58, 52)), CartesianIndex{2}((59, 52)), CartesianIndex{2}((60, 52)), CartesianIndex{2}((61, 52)), CartesianIndex{2}((20, 53)), CartesianIndex{2}((21, 53)), CartesianIndex{2}((22, 53)), CartesianIndex{2}((23, 53)), CartesianIndex{2}((24, 53)), CartesianIndex{2}((25, 53)), CartesianIndex{2}((26, 53)), CartesianIndex{2}((27, 53)), CartesianIndex{2}((28, 53)), CartesianIndex{2}((29, 53)), CartesianIndex{2}((30, 53)), CartesianIndex{2}((51, 53)), CartesianIndex{2}((52, 53)), CartesianIndex{2}((53, 53)), CartesianIndex{2}((54, 53)), CartesianIndex{2}((55, 53)), CartesianIndex{2}((56, 53)), CartesianIndex{2}((57, 53)), CartesianIndex{2}((58, 53)), CartesianIndex{2}((59, 53)), CartesianIndex{2}((60, 53)), CartesianIndex{2}((61, 53)), CartesianIndex{2}((21, 54)), CartesianIndex{2}((22, 54)), CartesianIndex{2}((23, 54)), CartesianIndex{2}((24, 54)), CartesianIndex{2}((25, 54)), CartesianIndex{2}((26, 54)), CartesianIndex{2}((27, 54)), CartesianIndex{2}((28, 54)), CartesianIndex{2}((29, 54)), CartesianIndex{2}((30, 54)), CartesianIndex{2}((31, 54)), CartesianIndex{2}((32, 54)), CartesianIndex{2}((49, 54)), CartesianIndex{2}((50, 54)), CartesianIndex{2}((51, 54)), CartesianIndex{2}((52, 54)), CartesianIndex{2}((53, 54)), CartesianIndex{2}((54, 54)), CartesianIndex{2}((55, 54)), CartesianIndex{2}((56, 54)), CartesianIndex{2}((57, 54)), CartesianIndex{2}((58, 54)), CartesianIndex{2}((59, 54)), CartesianIndex{2}((60, 54)), CartesianIndex{2}((22, 55)), CartesianIndex{2}((23, 55)), CartesianIndex{2}((24, 55)), CartesianIndex{2}((25, 55)), CartesianIndex{2}((26, 55)), CartesianIndex{2}((27, 55)), CartesianIndex{2}((28, 55)), CartesianIndex{2}((29, 55)), CartesianIndex{2}((30, 55)), CartesianIndex{2}((31, 55)), CartesianIndex{2}((32, 55)), CartesianIndex{2}((49, 55)), CartesianIndex{2}((50, 55)), CartesianIndex{2}((51, 55)), CartesianIndex{2}((52, 55)), CartesianIndex{2}((53, 55)), CartesianIndex{2}((54, 55)), CartesianIndex{2}((55, 55)), CartesianIndex{2}((56, 55)), CartesianIndex{2}((57, 55)), CartesianIndex{2}((58, 55)), CartesianIndex{2}((59, 55)), CartesianIndex{2}((22, 56)), CartesianIndex{2}((23, 56)), CartesianIndex{2}((24, 56)), CartesianIndex{2}((25, 56)), CartesianIndex{2}((26, 56)), CartesianIndex{2}((27, 56)), CartesianIndex{2}((28, 56)), CartesianIndex{2}((29, 56)), CartesianIndex{2}((30, 56)), CartesianIndex{2}((31, 56)), CartesianIndex{2}((32, 56)), CartesianIndex{2}((33, 56)), CartesianIndex{2}((34, 56)), CartesianIndex{2}((35, 56)), CartesianIndex{2}((36, 56)), CartesianIndex{2}((45, 56)), CartesianIndex{2}((46, 56)), CartesianIndex{2}((47, 56)), CartesianIndex{2}((48, 56)), CartesianIndex{2}((49, 56)), CartesianIndex{2}((50, 56)), CartesianIndex{2}((51, 56)), CartesianIndex{2}((52, 56)), CartesianIndex{2}((53, 56)), CartesianIndex{2}((54, 56)), CartesianIndex{2}((55, 56)), CartesianIndex{2}((56, 56)), CartesianIndex{2}((57, 56)), CartesianIndex{2}((58, 56)), CartesianIndex{2}((59, 56)), CartesianIndex{2}((23, 57)), CartesianIndex{2}((24, 57)), CartesianIndex{2}((25, 57)), CartesianIndex{2}((26, 57)), CartesianIndex{2}((27, 57)), CartesianIndex{2}((28, 57)), CartesianIndex{2}((29, 57)), CartesianIndex{2}((30, 57)), CartesianIndex{2}((31, 57)), CartesianIndex{2}((32, 57)), CartesianIndex{2}((33, 57)), CartesianIndex{2}((34, 57)), CartesianIndex{2}((35, 57)), CartesianIndex{2}((36, 57)), CartesianIndex{2}((45, 57)), CartesianIndex{2}((46, 57)), CartesianIndex{2}((47, 57)), CartesianIndex{2}((48, 57)), CartesianIndex{2}((49, 57)), CartesianIndex{2}((50, 57)), CartesianIndex{2}((51, 57)), CartesianIndex{2}((52, 57)), CartesianIndex{2}((53, 57)), CartesianIndex{2}((54, 57)), CartesianIndex{2}((55, 57)), CartesianIndex{2}((56, 57)), CartesianIndex{2}((57, 57)), CartesianIndex{2}((58, 57)), CartesianIndex{2}((24, 58)), CartesianIndex{2}((25, 58)), CartesianIndex{2}((26, 58)), CartesianIndex{2}((27, 58)), CartesianIndex{2}((28, 58)), CartesianIndex{2}((29, 58)), CartesianIndex{2}((30, 58)), CartesianIndex{2}((31, 58)), CartesianIndex{2}((32, 58)), CartesianIndex{2}((33, 58)), CartesianIndex{2}((34, 58)), CartesianIndex{2}((35, 58)), CartesianIndex{2}((36, 58)), CartesianIndex{2}((37, 58)), CartesianIndex{2}((38, 58)), CartesianIndex{2}((39, 58)), CartesianIndex{2}((40, 58)), CartesianIndex{2}((41, 58)), CartesianIndex{2}((42, 58)), CartesianIndex{2}((43, 58)), CartesianIndex{2}((44, 58)), CartesianIndex{2}((45, 58)), CartesianIndex{2}((46, 58)), CartesianIndex{2}((47, 58)), CartesianIndex{2}((48, 58)), CartesianIndex{2}((49, 58)), CartesianIndex{2}((50, 58)), CartesianIndex{2}((51, 58)), CartesianIndex{2}((52, 58)), CartesianIndex{2}((53, 58)), CartesianIndex{2}((54, 58)), CartesianIndex{2}((55, 58)), CartesianIndex{2}((56, 58)), CartesianIndex{2}((57, 58)), CartesianIndex{2}((25, 59)), CartesianIndex{2}((26, 59)), CartesianIndex{2}((27, 59)), CartesianIndex{2}((28, 59)), CartesianIndex{2}((29, 59)), CartesianIndex{2}((30, 59)), CartesianIndex{2}((31, 59)), CartesianIndex{2}((32, 59)), CartesianIndex{2}((33, 59)), CartesianIndex{2}((34, 59)), CartesianIndex{2}((35, 59)), CartesianIndex{2}((36, 59)), CartesianIndex{2}((37, 59)), CartesianIndex{2}((38, 59)), CartesianIndex{2}((39, 59)), CartesianIndex{2}((40, 59)), CartesianIndex{2}((41, 59)), CartesianIndex{2}((42, 59)), CartesianIndex{2}((43, 59)), CartesianIndex{2}((44, 59)), CartesianIndex{2}((45, 59)), CartesianIndex{2}((46, 59)), CartesianIndex{2}((47, 59)), CartesianIndex{2}((48, 59)), CartesianIndex{2}((49, 59)), CartesianIndex{2}((50, 59)), CartesianIndex{2}((51, 59)), CartesianIndex{2}((52, 59)), CartesianIndex{2}((53, 59)), CartesianIndex{2}((54, 59)), CartesianIndex{2}((55, 59)), CartesianIndex{2}((56, 59)), CartesianIndex{2}((26, 60)), CartesianIndex{2}((27, 60)), CartesianIndex{2}((28, 60)), CartesianIndex{2}((29, 60)), CartesianIndex{2}((30, 60)), CartesianIndex{2}((31, 60)), CartesianIndex{2}((32, 60)), CartesianIndex{2}((33, 60)), CartesianIndex{2}((34, 60)), CartesianIndex{2}((35, 60)), CartesianIndex{2}((36, 60)), CartesianIndex{2}((37, 60)), CartesianIndex{2}((38, 60)), CartesianIndex{2}((39, 60)), CartesianIndex{2}((40, 60)), CartesianIndex{2}((41, 60)), CartesianIndex{2}((42, 60)), CartesianIndex{2}((43, 60)), CartesianIndex{2}((44, 60)), CartesianIndex{2}((45, 60)), CartesianIndex{2}((46, 60)), CartesianIndex{2}((47, 60)), CartesianIndex{2}((48, 60)), CartesianIndex{2}((49, 60)), CartesianIndex{2}((50, 60)), CartesianIndex{2}((51, 60)), CartesianIndex{2}((52, 60)), CartesianIndex{2}((53, 60)), CartesianIndex{2}((54, 60)), CartesianIndex{2}((55, 60)), CartesianIndex{2}((28, 61)), CartesianIndex{2}((29, 61)), CartesianIndex{2}((30, 61)), CartesianIndex{2}((31, 61)), CartesianIndex{2}((32, 61)), CartesianIndex{2}((33, 61)), CartesianIndex{2}((34, 61)), CartesianIndex{2}((35, 61)), CartesianIndex{2}((36, 61)), CartesianIndex{2}((37, 61)), CartesianIndex{2}((38, 61)), CartesianIndex{2}((39, 61)), CartesianIndex{2}((40, 61)), CartesianIndex{2}((41, 61)), CartesianIndex{2}((42, 61)), CartesianIndex{2}((43, 61)), CartesianIndex{2}((44, 61)), CartesianIndex{2}((45, 61)), CartesianIndex{2}((46, 61)), CartesianIndex{2}((47, 61)), CartesianIndex{2}((48, 61)), CartesianIndex{2}((49, 61)), CartesianIndex{2}((50, 61)), CartesianIndex{2}((51, 61)), CartesianIndex{2}((52, 61)), CartesianIndex{2}((53, 61)), CartesianIndex{2}((29, 62)), CartesianIndex{2}((30, 62)), CartesianIndex{2}((31, 62)), CartesianIndex{2}((32, 62)), CartesianIndex{2}((33, 62)), CartesianIndex{2}((34, 62)), CartesianIndex{2}((35, 62)), CartesianIndex{2}((36, 62)), CartesianIndex{2}((37, 62)), CartesianIndex{2}((38, 62)), CartesianIndex{2}((39, 62)), CartesianIndex{2}((40, 62)), CartesianIndex{2}((41, 62)), CartesianIndex{2}((42, 62)), CartesianIndex{2}((43, 62)), CartesianIndex{2}((44, 62)), CartesianIndex{2}((45, 62)), CartesianIndex{2}((46, 62)), CartesianIndex{2}((47, 62)), CartesianIndex{2}((48, 62)), CartesianIndex{2}((49, 62)), CartesianIndex{2}((50, 62)), CartesianIndex{2}((51, 62)), CartesianIndex{2}((52, 62)), CartesianIndex{2}((31, 63)), CartesianIndex{2}((32, 63)), CartesianIndex{2}((33, 63)), CartesianIndex{2}((34, 63)), CartesianIndex{2}((35, 63)), CartesianIndex{2}((36, 63)), CartesianIndex{2}((37, 63)), CartesianIndex{2}((38, 63)), CartesianIndex{2}((39, 63)), CartesianIndex{2}((40, 63)), CartesianIndex{2}((41, 63)), CartesianIndex{2}((42, 63)), CartesianIndex{2}((43, 63)), CartesianIndex{2}((44, 63)), CartesianIndex{2}((45, 63)), CartesianIndex{2}((46, 63)), CartesianIndex{2}((47, 63)), CartesianIndex{2}((48, 63)), CartesianIndex{2}((49, 63)), CartesianIndex{2}((50, 63)), CartesianIndex{2}((34, 64)), CartesianIndex{2}((35, 64)), CartesianIndex{2}((36, 64)), CartesianIndex{2}((37, 64)), CartesianIndex{2}((38, 64)), CartesianIndex{2}((39, 64)), CartesianIndex{2}((40, 64)), CartesianIndex{2}((41, 64)), CartesianIndex{2}((42, 64)), CartesianIndex{2}((43, 64)), CartesianIndex{2}((44, 64)), CartesianIndex{2}((45, 64)), CartesianIndex{2}((46, 64)), CartesianIndex{2}((47, 64))]

    @test relative_indices(g1,omega_grid)==[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 31, 32, 33, 34, 35, 36, 37, 56, 57, 58, 59, 60, 83, 84, 85, 86, 87, 112, 113, 114, 115, 116, 145, 146, 147, 148, 179, 180, 181, 182, 215, 216, 217, 218, 253, 254, 255, 292, 293, 294, 331, 332, 333, 334, 373, 374, 375, 416, 417, 418, 459, 460, 461, 504, 505, 506, 549, 550, 551, 596, 597, 642, 643, 688, 689, 690, 735, 736, 737, 784, 785, 832, 833, 880, 881, 928, 929, 976, 977, 1024, 1025, 1072, 1073, 1074, 1119, 1120, 1121, 1166, 1167, 1212, 1213, 1258, 1259, 1260, 1303, 1304, 1305, 1348, 1349, 1350, 1391, 1392, 1393, 1434, 1435, 1436, 1475, 1476, 1477, 1478, 1515, 1516, 1517, 1554, 1555, 1556, 1591, 1592, 1593, 1594, 1627, 1628, 1629, 1630, 1661, 1662, 1663, 1664, 1693, 1694, 1695, 1696, 1697, 1722, 1723, 1724, 1725, 1726, 1749, 1750, 1751, 1752, 1753, 1772, 1773, 1774, 1775, 1776, 1777, 1778, 1791, 1792, 1793, 1794, 1795, 1796, 1797, 1798, 1799, 1800, 1801, 1802, 1803, 1804, 1805, 1806, 1807, 1808]

    @test size(restriction_operator(omega_grid,g1))==(186, 1808)
end

@testset "Approximation" begin
    init = [3,3]
    degree = [1,3]
    oversampling = 2
    center = @SVector [.5,.5]
    domain  = disk(.3,center)
    i = 2
    # correct caclulation of the A and Z matrix
    for T in [Float64, BigFloat]
        center = @SVector [T(.5),T(.5)]
        domain  = disk(T(.3),center)
        platform=BasisFunctions.bspline_platform(T, init, degree, oversampling)
        fplatform = extension_frame_platform(platform, domain)

        P = primal(fplatform,i)
        D = dual(fplatform,i)
        S = sampler(fplatform, i)

        EP = BasisFunctions.A(fplatform, i)
        ED = BasisFunctions.Z(fplatform, i)

        p = fplatform.parameter_sequence[i]
        Pt = tensorproduct([BSplineTranslatesBasis(pi, di, T) for (pi, di) in zip(p, degree) ])
        g = BasisFunctions.oversampled_grid(Pt, oversampling)
        Ft = extensionframe(Pt, domain)
        gO = FrameFun.subgrid(g, domain)
        EPt = evaluation_operator(Span(Pt), gO)
        EDt = EPt*DiscreteDualGram(Span(Pt),oversampling=oversampling)
        e = map(T,rand(size(Pt)...))
        @test EPt*e≈EP*e
        @test EDt*e≈ED*e*length(Pt)
    end

    # Correct implementation of the az and azs Algorithm
    # for irregular domain
    f2d = (x,y) -> x*(y-1)^2
    center = @SVector [.5,.5]
    domain2d = disk(.3,center)
    epsilon=1e-10
    degree = [1,2]
    init = [20,20]
    oversampling = 2
    platform = bspline_platform(Float64, init, degree, oversampling)
    fplatform = extension_frame_platform(platform, domain2d)
    i = 1
    s = sampler(fplatform, i)
    a = BasisFunctions.A(fplatform, i)
    z = BasisFunctions.Z(fplatform, i)
    p = FrameFun.plunge_operator(a,z')
    rd,sb = spline_util_restriction_operators(fplatform, i)
    b = s*f2d
    r = FrameFun.estimate_plunge_rank(a)
    @test r==102
    AZ = AZSolver(a,z',R=r,cutoff=epsilon)
    AZS = AZSSolver(a,z',rd', sb,cutoff=epsilon)
    x = zeros(src(a))

    apply!(AZ, x, b)
    @test norm(a*x-b)+1≈ 1
    apply!(AZS, x, b)
    @test norm(a*x-b)+1≈ 1
    x = AZS*b
    @test norm(a*x-b)+1≈ 1
    x = FrameFun.az_solve(a, z', b, cutoff=epsilon, R=r)
    @test norm(a*x-b)+1≈ 1
    x = FrameFun.az_solve(fplatform, i, f2d; cutoff=epsilon)
    @test norm(a*x-b)+1≈ 1
    x = FrameFun.azs_solve(fplatform, i, f2d; cutoff=epsilon)
    @test norm(a*x-b)+1≈ 1

    # For tensor domain
    i = 2
    platform  = bspline_platform(Float64, [4,4], [1,1], 2)
    fun = (x,y)->1+x+y
    mid = .25
    dom = interval(0,.5)^2
    fplatform = extension_frame_platform(platform, dom)
    p = primal(platform, i);
    s = sampler(platform, i);
    BR,DMZ_R = FrameFun.spline_util_restriction_operators(fplatform, i)
    A = BasisFunctions.A(fplatform, i);
    Z = BasisFunctions.Z(fplatform, i);
    r = FrameFun.estimate_plunge_rank(A)
    @test r==16
    S = sampler(fplatform, i)
    boundary = FrameFun.boundary_grid(BasisFunctions.grid(s), dom)
    dx = BasisFunctions.stepsize(elements(BasisFunctions.grid(s))[1])
    split_domain = interval(mid-dx/2,mid+dx/2)×interval(0,1)
    split_grid = FrameFun.subgrid(boundary, split_domain);
    DMZsplit = FrameFun.boundary_support_grid(p, split_grid, boundary)
    BRsplit, DMZ_Rsplit = FrameFun._spline_util_restriction_operators(p, BasisFunctions.grid(S), DMZsplit)
    left_over = boundary-DMZsplit
    boundary1, boundary2 = split(left_over)
    BR1, DMZ_R1 = FrameFun._spline_util_restriction_operators(p, BasisFunctions.grid(S), boundary1)
    BR2, DMZ_R2 = FrameFun._spline_util_restriction_operators(p, BasisFunctions.grid(S), boundary2)


    b = S*fun
    AZSS = FrameFun.AZSSolver(A, Z', BR', DMZ_R)
    x = AZSS*b
    @test 1+norm(A*x-b)≈1
    AZSDCS = FrameFun.AZSDCSolver(A, Z', BRsplit', BR1', BR2', DMZ_Rsplit, DMZ_R1, DMZ_R2)
    x = AZSDCS*b
    @test 1+norm(A*x-b)≈1
    AZS = FrameFun.AZSolver(A, Z')
    x = AZS*b
    @test 1+norm(A*x-b)≈1

    x = FrameFun.az_solve(A, Z', b)
    @test 1+norm(A*x-b)≈1
    x = FrameFun.azs_solve(A, Z', BR', DMZ_R, b)
    @test 1+norm(A*x-b)≈1
    x = FrameFun.azsdc_solve(A, Z', BRsplit', BR1', BR2', DMZ_Rsplit, DMZ_R1, DMZ_R2, b)
    @test 1+norm(A*x-b)≈1

    x = FrameFun.az_solve(fplatform, i, fun)
    @test 1+norm(A*x-b)≈1
    x = FrameFun.azs_solve(fplatform, i, fun)
    @test 1+norm(A*x-b)≈1
    x = FrameFun.azsdc_solve(fplatform, i, fun, 1, [0,.5])
    @test 1+norm(A*x-b)≈1

    op = FrameFun.AZSSolver(fplatform, i)
    x = op*b;@test 1+norm(A*x-b)≈1
    op = FrameFun.AZSolver(fplatform, i)
    x = op*b;@test 1+norm(A*x-b)≈1
    op = FrameFun.AZSDCSolver(fplatform, i, 1, [.0,.5])
    x = op*b;@test 1+norm(A*x-b)≈1
end
end
