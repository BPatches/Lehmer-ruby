require 'set'
require_relative 'LRandom'
def modPow(base,exponent,modulus)
	@exponent = exponent
	@modulus = modulus
	@base = base
	result = 1
	while @exponent>0
		if (@exponent % 2 == 1)
			result = (result*@base) % @modulus
		end
		@exponent = @exponent >> 1
		@base = @base**2 % @modulus
	end
	return result
end

def checkMC(a,m)
	return (m % a) < (m/a)
end 
def findMCJ(base,m)
	n = Math.sqrt(m).to_i+256
	5000000.times{#m/n < 10**10
		if checkMC(modPow(base,n,m),m)
			return n
		end
		n-=1
	}
	puts "too short a jump"
	return -1
	
end

def checkFPM(a,jump,m)
	nums = Set.new
	rand = LRandom.new(1,1,a,m)
	
	jump.times{
		nums.add(rand.nextInt)
	}
	temp = rand.nextInt
	jRand = LRandom.new(temp,1,modPow(a,jump,m),m)
	#puts ((m.to_f/jump.to_f).ceil-2)
	((((m-1).to_f/jump.to_f).ceil-1).to_i).times{
		temp = jRand.nextInt
		#puts temp
		if nums.include?(temp)
			return false
		end
	}
	if nums.include?(jRand.nextInt)
		return true
	end
	return false

end
def findFPM(m)
	for i in 2..10
		if !checkMC(i,m)
			print i," is not modulus compatible \n"
			next
		end
		temp = findMCJ(i,m)
		if(temp != -1)
			if checkFPM(i,temp,m)
				puts "#{i} is a full period multiplier"
			else 
				puts "#{i} is a not full period multiplier"
			end
		end
	end
end
#findFPM(10000000000037)#apparently 2 is a full period multiplier for 10000000000037
#rand = LRandom.new(1,1,2,10000000000037)
#rand.nextInt
#puts checkFPM(3,9,31)
