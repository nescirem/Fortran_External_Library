program test_lib
    
    use funcmod
    implicit none
    
    ! 当静态链接库中的function并未被moudle封装时，在调用该function时似乎需要声明interface
    interface
        function func2
            implicit none
            integer func2
        end function func2
    end interface
    
    integer :: i
    
    i = func1()
    i = func2()
    call sub1()
    call sub2()
  
end program test_lib
