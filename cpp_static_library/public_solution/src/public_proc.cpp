#include <iostream>
#include <cmath>
#include "public_proc.h"
using namespace std;

extern "C" { 
	double fdouble;
}

void public_proc(void) {
	double exp_fdouble = 0.114514;
	if (fabs(fdouble - exp_fdouble) < 0.000001) {
		cout << " 6. This is a variable defined in the static library!" << endl;
	}
}
