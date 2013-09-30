#include <cstdlib>
#include <cmath>
#include <iostream>
#include <set>

using namespace std;
const long m = -25+long(pow(2,63));//long(pow(2,31))-1;
bool checkMC(long a){
	return (m%a)<(m/a);
}
long Random(long x,long a){
	if(checkMC(a)){
		int q = m/a;
		int r = m%a;
		long t = a*(x%q)-r*(x/q);
		if(t>0){
			return t;
		}
		else{
			return t + m;
		}
	}else{
		cout<<"doin scary math"<<endl;
		return (a * x) % m;
	}
}
long ceiling(long a, long b){
	if(a%b==0){
		return a/b;
	}else{
		return a/b+1;
	}
}
long modularExponentiation(long a , long m, long n){
	long temp=a%m;
	for(int i = 1; i < n; i++){
		temp = (temp*a ) % m;
	}
	return temp;
}

bool testFp(int a){
	long n = sqrt(m);
	while (!checkMC(modularExponentiation(a,m,n))){
		n--;
		if(m/n>pow(10,12)){
			cout<< a <<" Bad Jump"<<endl;
			return false;
		}
	}
	long jumpMP = modularExponentiation(a,m,n);
	cout<<n<<" is our jump distance"<<endl;
	cout<<jumpMP<<" is our jump multiplier"<<endl;
	set<long> lookUp;
	long x=1;
	for(int i = 0; i < n; i++){
		lookUp.insert(x);
		x=Random(x,a);
	}
	x = 1;
	bool weLost = false;
	for( int i = 0; i < ceiling(m,n)-1;i++){
		x=Random(x,jumpMP);
		if(lookUp.find(x)!= lookUp.end()){
			cout<<a<<" not fpm"<<endl;
			return false;
			break;
		}
	}
	if(!weLost){
		x=Random(x,jumpMP);
		if(lookUp.find(x)!= lookUp.end()){
			cout<<a<<"tis a fpm"<<endl;
			return true;
		}
	}
}

int main(){
	cout<<m<<endl;
	for(long a=2;a<20;a++){
		if(testFp(a)){
			return 0;
		}
	}
	return 1;
}


