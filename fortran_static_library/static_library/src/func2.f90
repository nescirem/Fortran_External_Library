integer function func2()
    
    implicit none
    
    write( *,* ) '2. This is a global function in the static libaray!'
    func2 = 1
    return
    
end function func2
