subroutine test_dll
    
    use funcmod
    use data_def
    implicit none
    
    interface
    
        integer function func2
            implicit none 
        end function func2
        
    end interface
    
    i = func1()    
    i = func2()
    call sub1()
    call sub2()
    call public_sub()
  
end subroutine test_dll
