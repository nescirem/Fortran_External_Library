module funcmod
    
    implicit none

contains

    integer function func1()
  
        write(*,*) 'This is a function which is packed by module in the static libaray "lib.lib"!'
        func1 = 1
    
    end function func1
  
end module funcmod
