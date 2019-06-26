#!/usr/bin/env python

import os
from sh import bash

def main():
    
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

def test_static_library(str):
    expected = read_file("./expect/lib_expect.txt")
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
    expected = read_file("./expect/dll_expect.txt")
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
    
def read_file(file_path):
    
    if not os.path.isfile(file_path):
        raise TypeError(file_path + " does not exist")

    text_in_file = open(file_path).read()
    return text_in_file
    
if __name__=="__main__":
    main()
    
