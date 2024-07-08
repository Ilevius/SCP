MODULE globals
IMPLICIT NONE

integer dotsNum
real*8 pi, lambda(3), mu(3), rho(3), h(3), z(4)
real*8 fMin, fMax, fStep
real*8 f, w
complex*16 ci
parameter (pi=3.141592653589793d0)
parameter (ci=(0d0,1d0))    
    
    
    
    
    
    
    
    
    
    
    
CONTAINS
    SUBROUTINE Init_globals
    IMPLICIT NONE
    
        h(1) = 1d0; lambda(1) = 55d0; mu(1) = 25d0; rho(1) = 2.7d0;
        
        h(2) = 2d0; lambda(2) = 2.76d0; mu(2) = 1.18d0; rho(2) = 1.19d0;
        
        h(3) = 3d0; lambda(3) = 55d0; mu(3) = 25d0; rho(3) = 2.7d0;
    
        
        fmin = 1d-4; fmax = 0.2d0; dotsNum = 200; 
        fstep = (fmax - fmin)/dotsNum;

    
    END SUBROUTINE Init_globals
    
    
    
    
    
END MODULE globals  