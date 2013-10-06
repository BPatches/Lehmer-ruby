class LRandom
  attr_accessor :j
  def initialize(seed=1,numStreams=1,a = 48271,m=2**31-1)
    @seed=seed
    @numStreams=numStreams
    @numDraws=[0]
    @lastX = [seed]
    @a = a
    @m = m
    @q = (@m/@a)
    @r = @m % @a
    @alreadyWorned = {0=>[]}
    initStreams
  end
  
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
  
  def initStreams
    @j = @m/@numStreams
    aj = modPow(@a,@j,@m)
    while not checkMC(aj,@m) do
      @j -= 1
      aj = modPow(@a,@j,@m)
    end
    (@numStreams-1).times do |i|
      qt = (@m/aj)
      rt = @m % aj
      temp = @lastX[i]
      @lastX.push(nextInt(i,aj,qt,rt))
      @lastX[i]=temp
      @numDraws.push(0)
      @alreadyWorned[i] = []
    end
    
      @alreadyWorned[@numStreams-1] = []
  end
  def random(lBound=0,rBound=1,streamNum=0)
  	return ((rBound-lBound).to_f*nextInt(streamNum)).to_f/@m.to_f+lBound.to_f
  end
  def checkMC(a,m)
    return (m % a) < (m / a)
  end 
  
  def nextInt(streamNum=0,a=@a,q=@q,r=@r)
    if(@numDraws[streamNum]>@j )
      overlap = (streamNum + @numDraws[streamNum]/@j) % @numStreams
      if not @alreadyWorned[streamNum].include? overlap
        $stderr.puts "Stream #{streamNum} overlaping with stream #{overlap}"
        @alreadyWorned[streamNum].push(overlap)
      end
    end
    temp = @lastX[streamNum]
    if checkMC(a,@m) then
      t = a * (temp % q) - r*(temp / q)
      
      if t > 0
        @lastX[streamNum] = t
      else 
        @lastX[streamNum] = t+@m
      end
    else
      @lastX[streamNum] = (a * temp) % @m
    end
    @numDraws[streamNum] += 1
    return @lastX[streamNum]
  end
  
end
