MODULE globals
IMPLICIT NONE
integer dotsNum
real*8 pi, lambda(3), mu(3), rho(3), h(3), z(4)
real*8 fMin, fMax, fStep
real*8 dzMin, dzMax, haminStep, haminEps
real*8 f, w, fOld, alfaOld, SCPstep
complex*16 ci
parameter (pi=3.141592653589793d0)
parameter (ci=(0d0,1d0))    
namelist/waveguide/lambda, mu, rho, h   
namelist/study/fmin, fmax, dotsNum
namelist/simDcurves/dzMin, dzMax, haminStep, haminEps    
    
    
CONTAINS
    SUBROUTINE Init_globals
    IMPLICIT NONE
        open(unit=1,file='settings.txt',status='old')
        read(1, waveguide) 
        read(1, study)
        read(1, simDcurves)
        close(1)
        open(unit=7,file='3Curve.txt', FORM='FORMATTED')
        !open(unit=8,file='5Curve.txt', FORM='FORMATTED')
        
        fstep = (fmax - fmin)/dotsNum;
        z(1) = 0d0; z(2) = -h(1); z(3) = -( h(1) + h(2) ); z(4) = -( h(1) + h(2) + h(3) );
    END SUBROUTINE Init_globals
    
END MODULE globals  