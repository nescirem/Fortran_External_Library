integer function func2()
    
    implicit none
    
    write(*,*) 'This is a global function in the static libaray "lib.lib"!'
    func2 = 1
    return
    
end function func2
