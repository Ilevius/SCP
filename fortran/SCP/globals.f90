MODULE globals
IMPLICIT NONE

real*8 pi, lambda(3), mu(3), rho(3), h(3), z(4)
complex*16 ci
parameter (pi=3.141592653589793d0)
parameter (ci=(0d0,1d0))    
    
    
    
    
    
    
    
    
    
    
    
CONTAINS
    SUBROUTINE Init_globals
    IMPLICIT NONE
    
        h(1) = 1d0; lambda(1) = 5d0; mu(1) = 10d0; rho(1) = 6.25d0;
        
        h(2) = 2d0; lambda(2) = 11d0; mu(2) = 10d0; rho(2) = 5.25d0;
        
        h(3) = 3d0; lambda(3) = 22d0; mu(3) = 22d0; rho(3) = 4.25d0;
    
    
    END SUBROUTINE Init_globals
    
    
    
    
    
END MODULE globals  