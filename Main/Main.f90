program test_lib
    
    use funcmod
    implicit none
    
    ! ����̬���ӿ��е�function��δ��moudle��װʱ���ڵ��ø�functionʱ�ƺ���Ҫ����interface
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
