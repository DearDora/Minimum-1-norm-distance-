import Pkg
Pkg.add("Plots")

using Plots

scatter([b[1] xs[1]], [b[2] xs[2]])
plot!(transpose([v[:,:,1] v[:,1,1]]), transpose([v[:,:,2] v[:,1,2]]))
