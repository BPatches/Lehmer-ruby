require_relative "LRandom"
require "test/unit"
 
class TestLRandom < Test::Unit::TestCase

  def test_jumpCalc
    a=LRandom.new(1,1024)
    assert_equal(a.j,2082675,"bad jump")
    
    a=LRandom.new(1,512)
    assert_equal(a.j,4170283,"bad jump")

    a=LRandom.new(1,256)
    assert_equal(a.j,8367782,"bad jump")
    
    a=LRandom.new(1,128)
    assert_equal(a.j,16775552,"bad jump")
  end

  def test_ModCompatable
    a=LRandom.new(1,1,3,31)
    res = []
    25.times do
      res.push(a.nextInt)
    end
    assert_equal([3,9,27,19,26,16,17,20,29,25,13,8,24,10,30,28,22,4,12,5,15,14,11,2,6],res,"bad standard generation")
  end
  
  def test_nonModCompatable_Stream
    a=LRandom.new(1,2,3,31)
    res = []
    res2= []
    10.times do
      res.push(a.nextInt)
      res2.push(a.nextInt(1))
    end
    assert_equal(a.j,14,"Bad jump calc")
    assert_equal([3,9,27,19,26,16,17,20,29,25],res,"Bad stream 0 generation")
    assert_equal([30,28,22,4,12,5,15,14,11,2],res2,"Bad stream 1 generation")
  end
  def test_random01
    a = LRandom.new()
    sum = 0
    10000.times{
      temp = a.random
      sum += temp
      assert_true(temp > 0 && temp<1)
    }
    avg=sum.to_f/10000
    puts avg
  end
  def test_random510
    a = LRandom.new(124325)
    sum = 0
    100000.times{
      temp = a.random(5,10,0)
      sum += temp
      assert_true(temp > 5 && temp<10)
    }
    avg=sum.to_f/100000
    puts avg
  end
end
