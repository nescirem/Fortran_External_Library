program main
    
    implicit none
    
    interface
    
        subroutine sub_lib_in_lib()
        implicit none
        end subroutine sub_lib_in_lib
        
    end interface
    
    call test_lib()
    
    call sub_lib_in_lib()
    
end program main
