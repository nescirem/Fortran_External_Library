module funcmod
    
    implicit none

contains

    integer function func1()
        !DEC$ ATTRIBUTES DLLEXPORT :: func1
        implicit none
    end function func1
  
end module funcmod
