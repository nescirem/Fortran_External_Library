subroutine sub2() bind(c,name='sub2')
    
    use,intrinsic   :: iso_c_binding
    implicit none
    
    include 'just_inculde_me.inc'
    
    write( *,* ) '4. This is a subroutine with include file in the static library!'
    write( *,* ) '5. Content in the include file is: "'//hello//'"'
    
end subroutine sub2
