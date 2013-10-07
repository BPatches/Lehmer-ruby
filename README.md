Lehmer-ruby
===========

A lehmer random number generator for ruby.

Use
--- 

###Import
To import the LRandom class use:

    require "./LRandom"

###Constructor
The form of the constructor is 

    LRandom.new(seed=1,numStreams=1,a = 48271,m=2**31-1)
    
We strongly recomend not suppling your own a or m. This functinality only existis to facilitate testing.
If a stream requires a dispropotinate number of random numbers the recomended course of action is to allocate more streams
then necessary

###nextInt
To get the next Integer out of a stream use 

    nextInt(streamNum=0)
    
this will give the next int in a stream, if there is a collision with another stream the program will
print 

    "Stream n overlaping with stream m" 
to standard error. 

