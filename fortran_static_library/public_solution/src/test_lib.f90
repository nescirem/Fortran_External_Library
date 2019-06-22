subroutine test_lib
    
    use funcmod
    use data_def
    implicit none
    
    interface
    
        function func2
            implicit none
            integer func2
        end function func2
        
    end interface
    
    i = func1()
    i = func2()
    call sub1()
    call sub2()
    call public_sub()
  
end subroutine test_lib
