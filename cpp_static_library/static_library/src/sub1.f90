subroutine sub1() bind(c,name='sub1')
    
    use,intrinsic   :: iso_c_binding
    implicit none
    
    write( *,* ) '3. This is a subroutine in the static library!'  
    
end subroutine sub1
