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
=begin
  def test_with_authers
    a = LRandom.new(1,256)
    256.times do |i|
      IO.readlines("stream#{i}.dat").each do |line|
        assert_equal( a.nextInt(i),line.to_i)
      end
    end
  end
=end
  def test_shuffle
    a=LRandom.new(1)
    l=[]
    10.times do |i|
      l<< i
    end
    a.shuffle(l,0)
    puts l
    assert_not_equal(l,[0,1,2,3,4,5,6,7,8,9])
  end
end
