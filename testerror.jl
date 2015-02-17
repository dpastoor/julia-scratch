function fail(x)
	if x > 2
		error("x cannot be greater than 2")
		println("your value of x was $x")
	else 
		println("success, your value of x is only: $x")
	end
	println("thanks for checking")
end

fail(1)

fail(2)

fail(3)