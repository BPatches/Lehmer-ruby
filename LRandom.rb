class LRandom
	def initialize(seed=1,numStreams=1,a = 48271,m=2**31-1)
		@seed=seed
		@numStreams=numStreams
		@x = seed
		@a = a
		@m = m
=begin		if 1.size == 4
			@m=2**31-1
		elsif 1.size == 8
			#@m=2**63-25
			#puts @m
			@m=2**31-1
			@a=48271
		end
=end
		@q = (@m/@a)
		@r = @m % @a
	end
	def checkMC(a,m)
		return (m % a) < (m/a)
	end 
	def nextInt
		temp = @x
		if checkMC(@a,@m)
			t = @a*(@x % @q)-@r*(@x/@q)
			if t > 0
				@x = t
			else 
				@x =t+@m
			end
		else
			puts "not modulus compatable"
			@x = (@a*@x) % @m
		end
		return temp
	end
end
