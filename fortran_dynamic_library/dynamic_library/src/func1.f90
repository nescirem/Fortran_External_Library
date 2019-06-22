module funcmod
    
    implicit none

contains

    integer function func1()
        
        !DEC$ ATTRIBUTES DLLEXPORT :: func1
        implicit none
  
        write( *,* ) '1. This is a function in the dynamic library which is packed by a module!'
        func1 = 1
    
    end function func1
  
end module funcmod
