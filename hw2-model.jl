using JuMP
using Cbc

md = Model(with_optimizer(Cbc.Optimizer))

# Data
M = 1000

# Variables
@variable(md, x[i in 1:2], Int)
@variable(md, y[t in 1:T], Bin)
@variable(md, u[i in 1:2] >= 0)
@variable(md, d[i in 1:2, t in 1:T])
@variable(md, p[i in 1:2, t in 1:T] >= 0)
@variable(md, lambda[i in 1:3, t in 1:T] >= 0)

# Model
@objective(md, Min, u[1]+u[2])

@constraint(md, u[1] >= x[1] - b[1])

@constraint(md, u[1] >= b[1] - x[1])

@constraint(md, u[2] >= x[2] - b[2])

@constraint(md, u[2] >= b[2] - x[2])

@constraint(md, sum(y[t] for t = 1:T) >= 1)

@constraint(md, [t in 1:T, j in 1:2], d[j,t] == sum(lambda[i,t]*v[t,i,j] for i = 1:3))

@constraint(md, [t in 1:T], sum(lambda[i,t] for i = 1:3) == 1)

@constraint(md, [t in 1:T, i in 1:2], p[i,t] >= x[i] - d[i,t])

@constraint(md, [t in 1:T, i in 1:2], p[i,t] >= d[i,t] - x[i])

@constraint(md, [t in 1:T], y[t] <= 1 - (p[1,t] + p[2,t])/M)

# Solve model
optimize!(md)

# Assign value

xs[1] = value.(x[1])
xs[2] = value.(x[2])
