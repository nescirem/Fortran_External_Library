subroutine sub1() bind(c,name='SUB1')
    !DEC$ ATTRIBUTES DLLEXPORT  :: SUB1
    use,intrinsic       :: iso_c_binding
    implicit none
    
    write( *,* ) '3. This is a subroutine in the dynamic library!'  
    
end subroutine sub1
