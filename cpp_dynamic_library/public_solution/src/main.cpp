#include <stdio.h> 
#include <iostream> 
#include <windows.h> 
#include <public_proc.h>

using namespace std;

typedef void(__cdecl * SUB1)();
typedef void(__cdecl * SUB2)();
typedef int(__cdecl * FUNC1)();
typedef int(__cdecl * FUNC2)();

int test_dll(void){
	// dynamic load dll
#ifdef _WIN64
	HINSTANCE fddLibrary = LoadLibrary(L"dll_x64.dll");
#else // _WIN32
	HINSTANCE fddLibrary = LoadLibrary(L"dll_x86.dll");
#endif

	if (fddLibrary == NULL)
	{
		cout << "can't find the dll file" << endl;
		return -1;
	}
	// fetch subroutine/function names in the dll
	SUB1 sub1 = (SUB1)GetProcAddress(fddLibrary, "SUB1");
	SUB2 sub2 = (SUB2)GetProcAddress(fddLibrary, "SUB2");
	FUNC1 func1 = (FUNC1)GetProcAddress(fddLibrary, "FUNC1");
	FUNC2 func2 = (FUNC2)GetProcAddress(fddLibrary, "FUNC2");

	int i = func1();
	i = func2();
	sub1();
	sub2();
	int err;
	FreeLibrary(fddLibrary);
	err = public_proc();

	return 0;
}

int main(void) {
	int err;
	err = test_dll();
	cout << " 7. Done." << endl;
	return -1;
}
