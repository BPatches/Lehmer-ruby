class LRandom

  def initialize(seed=1,numStreams=1,a = 48271,m=2**31-1)
    @seed=seed
    @numStreams=numStreams
    @numDraws=[0]
    @x = [seed]
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
    while not checkMC (aj) do
      @j -= 1
      aj = modPow(@a,@j,@m)
    end
    (@numStreams-1).times do |i|
      qt = (@m/aj)
      rt = @m % aj
      @x.add(nexInt(i,aj,qt,rt))
      @numDraws.add(0)
      @alreadyWorned[i] = []
    end
  end
  
  def checkMC(a,m)
    return (m % a) < (m / a)
  end 
  
  def nextInt(streamNum=0,a=@a,q=@q,r=@r)
    if(@numDraws[streamNum]>@j )
      overlap = (streamNum + @numDraws[streamNum]/@j) % @numStreams
      if not @alreadyWorned[streamNum].include? overlap
        $stderr.puts "Stream #{streamNum} overlaping with stream #{overlap}"
        @alreadyWorned[streamNum].add(overlap)
      end
    end
    temp = @x[streamNum]  
    t = a * (@x[streamNum] % q) - r*(@x[streamNum] / q)
    if t > 0
      @x[streamNum] = t
    else 
      @x[streamNum] = t+@m
    end
    @numDraws[streamNum] += 1
    return temp
  end
  
end
