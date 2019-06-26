#!/usr/bin/env python3
#coding:utf-8

from sh import bash

def test_static_library(str):
	expected = '''
 1. This is a function in the static library which is packed by a module!
 2. This is a global function in the static libaray!
 3. This is a subroutine in the static libaray!
 4. This is a subroutine with include file in the static libaray!
 5. Content in the include file is: "hello, include file!"
 6. This is a variable defined in the static libaray!
 7. This is a subroutine in another static library in the static library!
 8. Done.
'''
	expected = expected.replace(' ','')
	expected = expected.replace('\n','')
	cstrs = str.split( " --------------------------------" )
	result = cstrs[-2].replace(' ','')
	result = result.replace('\n','')
	
	# print ("\nexpected",expected);
	# print ("\nresult",result);
	
	if expected == result:
		print (".", end="", flush=True);
	else:
		print ("F", end="", flush=True);
	
	bash( c="./fortran_static_library/clean_all.sh", _timeout=2 )
	
def test_dynamic_library(str):
	expected = '''
 1. This is a function in the dynamic library which is packed by a module!
 2. This is a global function in the dynamic library!
 3. This is a subroutine in the dynamic library!!
 4. This is a subroutine with include file in the dynamic library!
 5. Content in the include file is: "hello, include file!"
 6. This is a variable defined in the dynamic library!                                                                  
 7. Done.
'''
	expected = expected.replace(' ','')
	expected = expected.replace('\n','')
	cstrs = str.split( " --------------------------------" )
	result = cstrs[-2].replace(' ','')
	result = result.replace('\n','')
	
	# print ("\nexpected",expected);
	# print ("\nresult",result);
	
	if expected == result:
		print (".", end="", flush=True);
	else:
		print ("F", end="", flush=True);
	
	bash( c="./fortran_dynamic_library/clean_all.sh", _timeout=2 )

if __name__=='__main__':
	print ("", flush=True);

	bash( c="./fortran_static_library/clean_all.sh", _timeout=2 )
	str = bash( c="./fortran_static_library/build.sh", _timeout=10 )
	test_static_library(str)
	str = bash( c="./fortran_static_library/build.sh gfortran debug", _timeout=10 )
	test_static_library(str)
	str = bash( c="./fortran_static_library/build.sh gfortran release", _timeout=10 )
	test_static_library(str)
	str = bash( c="./fortran_static_library/build.sh ifort debug", _timeout=10 )
	test_static_library(str)
	str = bash( c="./fortran_static_library/build.sh ifort release", _timeout=10 )
	test_static_library(str)
	
	print (" ", end="", flush=True);
	
	bash( c="./fortran_dynamic_library/clean_all.sh", _timeout=2 )
	str = bash( c="./fortran_dynamic_library/build.sh", _timeout=10 )
	test_dynamic_library(str)
	str = bash( c="./fortran_dynamic_library/build.sh gfortran debug", _timeout=10 )
	test_dynamic_library(str)
	str = bash( c="./fortran_dynamic_library/build.sh gfortran release", _timeout=10 )
	test_dynamic_library(str)
	str = bash( c="./fortran_dynamic_library/build.sh ifort debug", _timeout=10 )
	test_dynamic_library(str)
	str = bash( c="./fortran_dynamic_library/build.sh ifort release", _timeout=10 )
	test_dynamic_library(str)
	
	print ("\n");
	print ("Done.");
