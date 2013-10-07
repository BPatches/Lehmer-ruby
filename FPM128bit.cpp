#include <cstdlib>
#include <cmath>
#include <iostream>
#include <set>
#include <unordered_map>
#include <stdlib.h>
using namespace std;
typedef unsigned long long superlong;
const unsigned long long m =9223372036854775783 ;//long(pow(2,31))-1;//

bool checkMC(unsigned long long a){
  //cout << "trying to do mod comp"<<endl;
  long long fpError = lldiv(m,a).rem;
  //cout << "mod ok" << endl;
  long long otherFperror = superlong(lldiv(m,a).quot);
  //cout << "div ok" <<endl;
  bool finFPerror = fpError < otherFperror;
  //cout << "comp ok" << endl;
  return finFPerror;
}
long Random(long x,long a){
  //	if(checkMC(a)){
  //int q = m/a;
  //		int r = m%a;
  //		long t = a*(x%q)-r*(x/q);
  //		if(t>0){
  //			return t;
  //		}
  //		else{
  //			return t + m;
  //		}
  //	}else{
  //cout<<"doin scary math"<<endl;
  __uint128_t atemp = a;
  __uint128_t xtemp = x;
  __uint128_t mtemp = m;
  return superlong((atemp * xtemp) % mtemp);
  //}
}
long ceiling(long long a, long long b){
  if(a%b==0){
    return a/b;
  }else{
    return a/b+1;
  }
}
long long modularExponentiation(superlong a , superlong m, superlong n){

  __uint128_t result = 1;
  __uint128_t atemp= a;
  __uint128_t mtemp = m;
  while(n  > 0){
    if(n % 2 == 1){
      //cout<<"Made it to result"<<endl;
      result = (result*atemp)%m;
    }
    n /= 2;
    //cout<<"Made it to atemp"<<endl;
    atemp = (atemp*atemp)%m;
    if (atemp*atemp%m == 0){
      cout << "illegal state exception"<<endl;
      //cout << "atemp * atemp is: " << (atemp*atemp) << endl;
    }
    //cout<<"ended atemp"<<endl;
    //cout <<"atemp: "<< atemp<<endl;
    //cout<<"result: "<<result<<endl;
  }
  //cout << "Hey we are returning"<<endl;
  return superlong(result);
}

bool testFp(int a){
  long long n = 140000000;
  cout<<"checking: " << a << endl;
  cout<< "at N: " << n << endl;
  //while (!checkMC(modularExponentiation(a,m,n))){
  //	  cout<<"in the loop"<<endl;
  //n--;
  //	if(n%500000==0){
  //	  cout<< "at N: "<< n<<endl;
  //	}
  //	if(m/n>pow(10,12)){
  //		cout<< a <<" Bad Jump"<<endl;
  //		return false;
  //	}
  //}
  //cout << "we are out of the loop"<<endl;
  long long jumpMP = modularExponentiation(a,m,n);
  cout<<n<<" is our jump distance"<<endl;
  cout<<jumpMP<<" is our jump multiplier"<<endl;
  unordered_map<superlong,bool> lookUp;
  lookUp.reserve(n);
  long long x=1;
  for(__uint64_t i = 0; i < n; i++){
    lookUp.insert({x,true});
    x=Random(x,a);
    if(i%1000000 == 0){
      cout<<"adding number " << i << " of " << n <<" to the set"<<endl;
    }
  }
  x = 1;
  bool weLost = false;
  superlong numJumps = ceiling(m,n)-1;
  for( int i = 0; i < numJumps;i++){
    x=Random(x,jumpMP);
    if(lookUp.find(x)!= lookUp.end()){
      cout<<a<<" not fpm"<<endl;
      return false;
      break;
    }
    if(i%1000000 == 0){
      cout<<"on jump " << i << " of " << numJumps <<endl;
    }
  }
  if(!weLost){
    x=Random(x,jumpMP);
    if(lookUp.find(x)!= lookUp.end()){
      cout<<a<<" is a fpm"<<endl;
      return true;
    }
  }
}

int main(){
  cout<<m<<endl;
  cout<< modularExponentiation(2,50,100)<<endl;
  for(long a=2;a<20;a++){
    if(testFp(a)){
      return 0;
    }
  }
  return 1;
}


