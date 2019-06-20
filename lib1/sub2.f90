subroutine sub2()
    
    implicit none
    
    include 'just_inculde_me.inc'
    
    write(*,*) 'This is a subroutine with include file in it in the static libaray "lib.lib"!'
    write(*,*) 'Content in include file is: "'//hello//'"'
    
end subroutine sub2
