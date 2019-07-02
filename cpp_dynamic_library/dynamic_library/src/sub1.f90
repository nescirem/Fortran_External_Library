subroutine sub1()
    !DEC$ ATTRIBUTES DLLEXPORT :: SUB1
    implicit none
    
    write( *,* ) '3. This is a subroutine in the dynamic library!'  
    
end subroutine sub1
