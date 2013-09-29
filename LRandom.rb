class LRandom
	def initialize(seed,numStreams=1)
		@seed=seed
		@numStreams=numStreams
		@x = seed
		if 1.size == 4
			@m=2**31-1
			@a=48271
		elsif 1.size == 8
			#@m=2**63-25
			#puts @m
			@m=2**31-1
			@a=48271
		end
		@q = (@m/a).to_i
		@r = @a % @m
		if @numStreams > 1
			@jump = getJump()
			plantSeeds()
		end
		
	end
	def nextInt
		t = @a*(@x % @q)-@r*(@x/@q).to_i
		if t > 0
			return t
		else 
			return t + @m
		end
	end
	def getJump
		dist = (@m/@numStreams).to_i
		while !checkMC((@a**dist) % @m)
				dist-=1
		end
		return dist
	end
	def plantSeeds(jump)
		for i 1..@numStreams

		end
	end
	def checkMC(a)
		r = a % @m
		q = (@m/a).to_i
		return r < q
	end
	def 
end
