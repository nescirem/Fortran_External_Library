integer*4 function func2()
    !DEC$ ATTRIBUTES DLLEXPORT :: func2
    implicit none
    
    write( *,* ) '2. This is a global function in the dynamic library!'
    func2 = 1
    return
    
end function func2
