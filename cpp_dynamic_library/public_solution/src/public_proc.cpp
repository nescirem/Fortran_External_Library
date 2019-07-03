#include <iostream>
#include <stdio.h> 
#include <cmath>
#include "platform.inc"
using namespace std;

#ifdef __WINDOWS
extern "C" _declspec(dllimport) double fdouble;
#else
extern "C" double fdouble;
#endif

int public_proc(void) {
	double exp_fdouble = 0.114514;
	fdouble = 0.114514;
	if (fabs(fdouble - exp_fdouble) < 0.000001) {
		cout << " 6. This is a variable defined in the dynamic library!" << endl;
	}
	else {
		return -1;
	}
	
	return 0;
}
