subroutine f_main() bind(c, name='f_main')
    
    use,intrinsic   :: iso_c_binding
    use data_def,   only: fdouble
    implicit none
    
    interface
    
        subroutine sub_lib_in_lib()
        implicit none
        end subroutine sub_lib_in_lib
        
        ! make Fortran can call C++ function: test_lib
        subroutine test_lib() bind(c, name='test_lib')
            implicit none
        end subroutine test_lib
        
    end interface

    fdouble = 0.114514d0
    call test_lib()
    
    call sub_lib_in_lib()
	
    write( *,* ) '8. Done.'
    
end subroutine f_main
