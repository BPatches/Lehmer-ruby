class LRandom
	def initialize(seed,numStreams=1)
		@seed=seed
		@numStreams=numStreams
		if 1.size == 4
			@m=2**31-1
			@a=48271
		elsif 1.size == 8
			@m=2**63-25
			@a=
		plantSeeds
	end
	def plantSeeds

	end
	def checkMC
		r=@m % a

	end
end
