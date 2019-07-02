module funcmod
    use,intrinsic   :: iso_c_binding
    implicit none
    
contains

    function func1() bind(c,name='FUNC1')
        
        !DEC$ ATTRIBUTES DLLEXPORT :: func1
        implicit none
        integer(c_int) func1
  
        write( *,* ) '1. This is a function in the dynamic library which is packed by a module!'
        func1 = 1
        
        return
    
    end function func1
  
end module funcmod
