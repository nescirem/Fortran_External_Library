function func2() bind(c,name='func2')
    
    use,intrinsic   ::  iso_c_binding
    implicit none
    
    integer(c_int)  ::  func2
    write( *,* ) '2. This is a global function in the static library!'
    func2 = 1
    return
    
end function func2
