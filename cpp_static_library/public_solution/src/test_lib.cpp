#include <iostream> 
#include "public_proc.h"

extern "C" {
	int i_iter;
	int func1(void);
	int func2(void);
	void sub1(void);
	void sub2(void);
	// the entry point of the program (may) must be public
	void f_main(void);
	// make Fortran can call C++ function: test_lib
	void test_lib(void);
}

void test_lib(void){
	i_iter = func1();
	i_iter = func2();
	sub1();
	sub2();
	public_proc();
}

int main(void) {
	f_main();
	return -1;
}
