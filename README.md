Lehmer-ruby
===========

A lehmer random number generator for ruby.

LRandom
-------

###Import
To import the LRandom class use:

    require "./LRandom"

###Constructor
The form of the constructor is 

    LRandom.new([seed=1,[numStreams=1,[a = 48271, [m=2**31-1]]]])
    
If a stream requires a dispropotinate number of random numbers the recomended course of action is to allocate more streams
then necessary, and allow them to overlap.

We strongly recomend not suppling your own a or m. This functinality only existis to facilitate testing.


###nextInt
To get the next Integer (between 1 and m-1 (by default 2**31-2 ) out of a stream use 

    nextInt([streamNum = 0])
    
this will give the next int in a stream, if there is a collision with another stream the program will
print 

    "Stream n overlaping with stream m" 
    
to standard error. 

FPMCheck
--------

The astute among you may have noticed that a failry significant portion of this repo is C++. This is because this is also
the home of our attempt to find a full period mulitplier for a 64 bit prime modulus, our efforts have thus far been frutless.
The basic idea behind our methodology is detaled in the pdf. We are confident in the algoritm but we seem to have a problem with integer overflow.
