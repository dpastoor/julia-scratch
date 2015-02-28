include("cleannm_function_strip.jl")

function f()
  cleannm_tocsv("/Users/devin/Repos/misc-datasets/nonmem_sim.vpc")
end

using Benchmark

benchmark(f, "cleannm", "cleannm_tocsv", 10)
benchmark(cleannm_tocsv("/Users/devin/Repos/misc-datasets/nonmem_sim.vpc"), "cleannm_global", "cleannm_tocsv_global", 10)
