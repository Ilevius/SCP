MODULE globals
IMPLICIT NONE
integer dotsNum, j
real*8 pi, lambda(3), mu(3), rho(3), h(3), z(4), cp(3), cs(3)
real*8 fMin, fMax, fStep
real*8 dzMin, dzMax, haminStep, haminEps
real*8 f, w, fOld, alfaOld, SCPstep, f_sp(13), alfa_sp(13)
complex*16 ci
parameter (pi=3.141592653589793d0)
parameter (ci=(0d0,1d0))    
!namelist/waveguide/lambda, mu, rho, h   
namelist/waveguide/cp, cs, rho, h   
namelist/study/fmin, fmax, dotsNum
namelist/simDcurves/dzMin, dzMax, haminStep, haminEps  
namelist/startPoints/f_sp, alfa_sp
    
    
CONTAINS
    SUBROUTINE Init_globals
    IMPLICIT NONE
        open(unit=13,file='settings.txt',status='old')
        read(13, waveguide) 
        read(13, study)
        read(13, simDcurves)
        read(13, startPoints)
        close(13)
        
        open(unit=1,file="C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\data\curves\1.txt", FORM='FORMATTED')
        open(unit=2,file="C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\data\curves\2.txt", FORM='FORMATTED')
        open(unit=3,file="C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\data\curves\3.txt", FORM='FORMATTED')
        open(unit=4,file="C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\data\curves\4.txt", FORM='FORMATTED')
        open(unit=5,file="C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\data\curves\5.txt", FORM='FORMATTED')
        open(unit=6,file="C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\data\curves\6.txt", FORM='FORMATTED')
        open(unit=7,file="C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\data\curves\7.txt", FORM='FORMATTED')
        open(unit=8,file="C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\data\curves\8.txt", FORM='FORMATTED')
        open(unit=9,file="C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\data\curves\9.txt", FORM='FORMATTED')
        open(unit=10,file="C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\data\curves\10.txt", FORM='FORMATTED')
        open(unit=11,file="C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\data\curves\11.txt", FORM='FORMATTED')
        open(unit=12,file="C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\data\curves\12.txt", FORM='FORMATTED')
        open(unit=13,file="C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\data\curves\13.txt", FORM='FORMATTED')
        
        do j = 1, 3 
            lambda(j) = cp(j)**2*rho(j) - 2d0*cs(j)**2*rho(j); mu(j) =  cs(j)**2*rho(j);
        enddo
        
        fstep = (fmax - fmin)/dotsNum;
        z(1) = 0d0; z(2) = -h(1); z(3) = -( h(1) + h(2) ); z(4) = -( h(1) + h(2) + h(3) );
    END SUBROUTINE Init_globals
    
END MODULE globals  