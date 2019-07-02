module data_def
    !DEC$ ATTRIBUTES DLLEXPORT :: I_ITER, FDOUBLE
    use,intrinsic   :: iso_c_binding
    implicit none
    
    public
    integer(c_int),bind(c)      ::  i_iter
    real(c_double),bind(c)      ::  fdouble
    
end module data_def
