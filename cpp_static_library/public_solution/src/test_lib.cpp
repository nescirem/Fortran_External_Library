#include <stdio.h> 
#include <iostream> 
#include <public_proc.h>

using namespace std;

extern "C" {
	int i_iter;
	int func1(void);
	int func2(void);
	void sub1(void);
	void sub2(void);
	void f_main(void);
	void test_lib(void);
}

void test_lib(void){

	i_iter = func1();
	i_iter = func2();
	sub1();
	sub2();
	void public_proc();

}

int main(void) {
	f_main();
	return -1;
}