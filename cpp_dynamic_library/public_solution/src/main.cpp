#include <stdio.h> 
#include <iostream>
#include "platform.inc"
#ifdef __WINDOWS
#include <windows.h> 
#else
#include <dlfcn.h>
#endif
#include "public_proc.h"
using namespace std;


#ifdef __WINDOWS
typedef void(__cdecl * SUB1)();
typedef void(__cdecl * SUB2)();
typedef int(__cdecl * FUNC1)();
typedef int(__cdecl * FUNC2)();
#else
typedef void(*SUB1)();
typedef void(*SUB2)();
typedef int(*FUNC1)();
typedef int(*FUNC2)();
#endif

int test_dll(void){
	// dynamic load dll
#ifdef _WIN64
	HINSTANCE fddLibrary = LoadLibrary(L"dll_x64.dll");
#elif _WIN32
	HINSTANCE fddLibrary = LoadLibrary(L"dll_x86.dll");
#else //GNU Linux
#define LIB_CACULATE_PATH "./libdll.so"
	void *fddLibrary = dlopen(LIB_CACULATE_PATH, RTLD_LAZY);
#endif

	if (fddLibrary == NULL)
	{
		cout << "can't find the dynamic library file" << endl;
		return -1;
	}

#ifdef __WINDOWS
	// fetch subroutine/function names in the dll
	SUB1 sub1 = (SUB1)GetProcAddress(fddLibrary, "SUB1");
	SUB2 sub2 = (SUB2)GetProcAddress(fddLibrary, "SUB2");
	FUNC1 func1 = (FUNC1)GetProcAddress(fddLibrary, "FUNC1");
	FUNC2 func2 = (FUNC2)GetProcAddress(fddLibrary, "FUNC2");
#else
	SUB1 sub1 = (SUB1)dlsym(fddLibrary, "SUB1");
	SUB2 sub2 = (SUB2)dlsym(fddLibrary, "SUB2");
	FUNC1 func1 = (FUNC1)dlsym(fddLibrary, "FUNC1");
	FUNC2 func2 = (FUNC2)dlsym(fddLibrary, "FUNC2");
#endif

	int i = 1;
	i = func1();
	i = func2();
	sub1();
	sub2();

#ifdef __WINDOWS
	FreeLibrary(fddLibrary);
#else
	dlclose(fddLibrary);
#endif

	int err = 0;
	err = public_proc();

	return 0;
}

int main(void) {
	int err;
	err = test_dll();
	cout << " 7. Done." << endl;
	return err;
}
