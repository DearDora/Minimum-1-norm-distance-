using LinearAlgebra
using Random

# Comment out the following line to get different triangles every time
Random.seed!(0)

# x1 in [ 0 100 ], x2 in [ 0 100 ]
range = [ 0 100 ; 0 100 ]

# b in center, initialize xs, set number of triangles
b = 0.5 * (range[:, 1] + range[:, 2])
xs = range[:, 1]
T = 20

# Generate random triangles
v = zeros(T, 3, 2)

area = (range[1, 2] - range[1, 1]) * (range[2, 2] - range[2, 1])

function random_triangle(range)
	for i = 1:100
		v1 = rand(2) .* (range[:,2] - range[:, 1]) + range[:, 1]
		v2 = rand(2) .* (range[:,2] - range[:, 1]) + range[:, 1]
		v3 = rand(2) .* (range[:,2] - range[:, 1]) + range[:, 1]

		B = [(v2 - v1) (v3 - v1)]
		
		if (abs(det(B)) < 0.01 * area)
			continue
		end
		
		y = inv(B) * (b - v1)
		
		if (y[1] >= -0.5) && (y[2] >= -0.5) && (y[1] + y[2] <= 1.5)
			continue
		end
		
		return transpose([v1 v2 v3])
	end
	
	println("Failure to generate random triangle")
	return zeros(3, 2)
end


for t = 1:T
	v[t, :, :] = random_triangle(range)
end

nothing
