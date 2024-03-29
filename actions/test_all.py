#!/usr/bin/env python
#coding:utf-8

from sh import bash

def createDeck(LANG):
    import itertools
    DDBUG=['debug','release']
    if LANG == "fortran":
        FC=['gfortran','ifort']
        return (list(itertools.product(FC,DDBUG)))
    else:
        FC=['g++']
        return (list(itertools.product(DDBUG,FC)))

def main():
    
    def test_library(str):
        if LIBRARY == "STATIC_LIBRARY":
            expected = read_file("./expect/lib_expect.txt")
        else:
            expected = read_file("./expect/dll_expect.txt")
            
        expected = pure_str(expected)
        cstrs = str.split( " --------------------------------" )
        result = pure_str(cstrs[-2])
        if expected == result:
            print ('\033[0;32m[PASS]\033[0m', flush=True);  err_code = 0
        else:
            print ('\033[1;31m[ERROR]\033[0m', flush=True);  err_code = 1
        
        return err_code
        
    def test_modes():
        err_count=0
        for i in modes:
            bash( c='./'+LANG+'_'+LIBRARY.lower()+'/clean_all.sh', _timeout=2 )
            app_cmd = i[0]+' '+i[1]
            if app_cmd.isspace():
                print ('['+LANG+'] '+LIBRARY+' DEFAULT', end=": ", flush=True)
            else:
                print ('['+LANG+'] '+LIBRARY+' '+app_cmd, end=": ", flush=True)
            str = bash( c='./'+LANG+'_'+LIBRARY.lower()+'/build.sh '+app_cmd, _timeout=10 )
            err_count += test_library(str)
        return err_count
    
        
    print ('', flush=True)
    
    err_tcount = 0
    
    LANG="fortran"
    
    # Fortran STATIC LIBRARY
    modes = createDeck(LANG)
    modes.append(('',''))
    LIBRARY="STATIC_LIBRARY"
    err_tcount += test_modes()
    print ('', flush=True)
    
    # Fortran DYNAMIC LIBRARY
    LIBRARY="DYNAMIC_LIBRARY"
    err_tcount += test_modes()
    print ('', flush=True)
    
    LANG="cpp"
    
    # C++ STATIC LIBRARY
    LIBRARY="STATIC_LIBRARY"
    modes = createDeck(LANG)
    err_tcount += test_modes()
    print ('', flush=True)
    
    # C++ DYNAMIC LIBRARY
    LIBRARY="DYNAMIC_LIBRARY"
    modes = createDeck(LANG)
    err_tcount += test_modes()
    
    
    clean_all()
    
    print ("\033[1;31mERROR\033[0m =", err_tcount)
    print ('', flush=True)
    
def read_file(file_path):
    import os
    if not os.path.isfile(file_path):
        raise TypeError(file_path + " does not exist")
    text_in_file = open(file_path).read()
    return text_in_file
    
def pure_str(str):
    purestr = str.replace(' ','')
    purestr = purestr.replace('\n','')
    return purestr
    
def clean_all():
    bash( c="./fortran_static_library/clean_all.sh", _timeout=2 )
    bash( c="./fortran_dynamic_library/clean_all.sh", _timeout=2 )
    bash( c="./cpp_static_library/clean_all.sh", _timeout=2 )
    bash( c="./cpp_dynamic_library/clean_all.sh", _timeout=2 )
    #------------------------------------------------------
    # add script here
    #------------------------------------------------------
    print ('', flush=True)
    
if __name__=="__main__":
    main()
    
