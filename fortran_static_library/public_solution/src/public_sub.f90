subroutine public_sub
    
    use data_def
    implicit none
    
    string = '6. This is a variable defined in the static libaray "lib.lib"!'
    write ( *,* ) string
    
end subroutine public_sub
