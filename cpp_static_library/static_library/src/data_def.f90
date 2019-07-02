module data_def
    
    use,intrinsic   :: iso_c_binding
    implicit none
    
    integer(c_int),bind(c)      ::  i_iter
    real(c_double),bind(c)      ::  fdouble
    
end module data_def
