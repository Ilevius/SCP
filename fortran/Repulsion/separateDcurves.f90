    MODULE SDC_globals
    integer resFileNo, freqsNum
    real*8 fOld, alfaOld, SCPstep
    real*8, allocatable:: freqs(:), dzetas(:), resK11(:)
    END MODULE
    
    SUBROUTINE simpleDcurves
    use Mult_Glob;            ! GIVES US w, f, pi
    IMPLICIT NONE
    real*8 dz(20)
    integer i, j, Ndz, dotsNum
    real*8 fmin, fstep, fmax, dzMin, dzMax, haminStep, haminEps, RDabs, RDabs_alf, vs, kap2
    external RDabs,RDabs_alf
        dotsNum = 400
        fmin = 1d-3; fmax = 2.5d0; 
        dzMin = 1d-4; dzMax = 3.5d0; haminStep =1d-2; haminEps = 1d-6; dz = 0d0;
        vs = sqrt(C_6(6,6,1)/rho(1))
        open(1, file="C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\fortran\Repulsion\DataFigs\separateDcurves\simpleDcurves.txt", FORM='FORMATTED');
        fstep = (fmax - fmin)/dotsNum;
        do i = 1, dotsNum
            f = fmin + fstep*(i-1); w = f*2d0*pi; kap2=w*hs(1)/vs;
            if (kap2 > 2d0)then
                call Hamin(RDabs, dzMin, dzMax, haminStep, haminEps, 20, dz, Ndz)
            else
                call Hamin(RDabs_alf, dzMin, dzMax, haminStep, haminEps, 20, dz, Ndz)
                dz(1:Ndz) = dz(1:Ndz)/w                 
            end if
            do j = 1, Ndz
                write(1, '(5E15.6E3)') f, dz(j), dz(j)/f, f/dz(j)
            enddo    
        enddo
        close(1)
    END SUBROUTINE simpleDcurves
    
    
                                                                ! auxiliary function for real poles finding by Hamin
    real(8) function arcRDabs(angle)
    use Mult_Glob; 
    use SDC_globals;
    implicit none
	real(8) gm,angle; 
    complex*16 alf,c,det
	common/gm/gm/det/det
        w = 2d0*pi*(cos(angle)*SCPstep + fOld)
	    alf = (sin(angle)*SCPstep + alfaOld)*(1d0,0d0)
	    call MultiK_An(alf,gm,0d0)
        c = 1d0/Kaz(3,3)
	    arcRDabs = abs(c)
    end
    
    

    subroutine SCP1(f0, alfa0, step, fmax, file)
    use SDC_globals;
    use Mult_Glob; 
    implicit none
    integer  Ndz, choice, iterno, j, file
    real*8 f0, alfa0, fNew, alfaNew, step, fmax, dz(20), psi, arcRDabs
    external arcRDabs
    !    !                                                                    первые шаги, подготовка к автоматике
        SCPstep = step; fOld = f0; alfaOld = alfa0;
        call Hamin(arcRDabs, 0d0, pi, 1d-3, 1d-7, 20, dz, Ndz)
        alfaNew = sin(dz(1))*SCPstep + alfaOld; fNew = cos(dz(1))*SCPstep + fOld;
        psi = atan( (fNew-fOld)/(alfaNew-alfaOld) );      
        w = 2d0*pi*fNew       
        write(file, '(4E15.6E3)') fNew, alfaNew
        fNew = fOld; alfaNew = alfaOld;
    !                                                                         автоматический режим
        do 
            iterno= 0;
            do
                call Hamin(arcRDabs, pi/3d0-psi, 2d0*pi/3d0-psi, 0.5d-3, 1d-8, 4, dz, Ndz)
                if (Ndz>1) then
                    !print*, Ndz
                    choice = 1; 
                    do j = 2, Ndz
                        if ( abs(dz(j)-(pi/2d0 - psi)) < abs(dz(j-1)-(pi/2d0 - psi)) ) choice = j
                    enddo
                    exit;
                else
                    if (SCPstep < step) SCPstep = SCPstep*2d0
                     choice = 1; exit;
                endif    
                iterno = iterno + 1; if (iterno > 5) exit;
            enddo
            alfaNew = sin(dz(choice))*SCPstep + alfaOld; fNew = cos(dz(choice))*SCPstep + fOld;
            w = 2d0*pi*fNew        
            write(file, '(4E15.6E3)') fNew, alfaNew
            psi = atan( (fNew-fOld)/(alfaNew-alfaOld) ); fOld = fNew; alfaOld = alfaNew;
            if (fNew>fmax) exit;
        enddo 
    end subroutine SCP1
    
    
    subroutine plotAllcurves
    implicit none
    integer i
    real*8 f_sp(13), alfa_sp(13), fmax
    print*, 'Separate disp curves plotting has been started!'
    
        f_sp(1) = 6.099595d-3; alfa_sp(1) =  0.0731841d0;
        f_sp(2) = 0.0180982d0; alfa_sp(2) = 0.0219846d0;
        f_sp(3) = 0.156084d0; alfa_sp(3) = 0.0273854d0;
        f_sp(4) = 0.346065d0; alfa_sp(4) = 0.0457759d0;
        f_sp(5) = 0.526047d0; alfa_sp(5) = 0.0247028d0;
        f_sp(6) = 0.810595d0; alfa_sp(6) = 0.098386318441d0;
        f_sp(7) = 0.944d0; alfa_sp(7) = 0.0312388d0;
        f_sp(8) = 1.02303d0; alfa_sp(8) = 0.05052d0;
        f_sp(9) = 1.516d0; alfa_sp(9) = 0.128634d0;
        f_sp(10) = 1.5976d0; alfa_sp(10) = 0.021215d0;
        f_sp(11) = 1.6264d0; alfa_sp(11) = 0.0340154d0;
        f_sp(12) = 1.8016d0; alfa_sp(12) = 0.0696412d0;
        f_sp(13) = 2.02d0; alfa_sp(13) = 0.0882506d0;
        
        
        open(unit=301,file="C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\fortran\Repulsion\DataFigs\separateDcurves\A2Sc0,05G3v1\1.txt", FORM='FORMATTED')
        open(unit=302,file="C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\fortran\Repulsion\DataFigs\separateDcurves\A2Sc0,05G3v1\2.txt", FORM='FORMATTED')
        open(unit=303,file="C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\fortran\Repulsion\DataFigs\separateDcurves\A2Sc0,05G3v1\3.txt", FORM='FORMATTED')
        open(unit=304,file="C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\fortran\Repulsion\DataFigs\separateDcurves\A2Sc0,05G3v1\4.txt", FORM='FORMATTED')
        open(unit=305,file="C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\fortran\Repulsion\DataFigs\separateDcurves\A2Sc0,05G3v1\5.txt", FORM='FORMATTED')
        open(unit=306,file="C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\fortran\Repulsion\DataFigs\separateDcurves\A2Sc0,05G3v1\6.txt", FORM='FORMATTED')
        open(unit=307,file="C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\fortran\Repulsion\DataFigs\separateDcurves\A2Sc0,05G3v1\7.txt", FORM='FORMATTED')
        open(unit=308,file="C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\fortran\Repulsion\DataFigs\separateDcurves\A2Sc0,05G3v1\8.txt", FORM='FORMATTED')
        open(unit=309,file="C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\fortran\Repulsion\DataFigs\separateDcurves\A2Sc0,05G3v1\9.txt", FORM='FORMATTED')
        open(unit=310,file="C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\fortran\Repulsion\DataFigs\separateDcurves\A2Sc0,05G3v1\10.txt", FORM='FORMATTED')
        open(unit=311,file="C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\fortran\Repulsion\DataFigs\separateDcurves\A2Sc0,05G3v1\11.txt", FORM='FORMATTED')
        open(unit=312,file="C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\fortran\Repulsion\DataFigs\separateDcurves\A2Sc0,05G3v1\12.txt", FORM='FORMATTED')
        open(unit=313,file="C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\fortran\Repulsion\DataFigs\separateDcurves\A2Sc0,05G3v1\13.txt", FORM='FORMATTED')
        

        
        fmax = 2.5d0
    
        do i = 10, 10
            print*, 'Curve ', i, ' plotting has been started!'
            call SCP1(f_sp(i), alfa_sp(i), 0.5d-2, fmax, i+300)
        enddo    
    
    end subroutine plotAllcurves
    
    
    subroutine setResEnv
    use SDC_globals;
    implicit none
    integer i
        open(unit=301,file="C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\fortran\Repulsion\DataFigs\separateDcurves\A2Sc0,05G3v1\13.txt", FORM='FORMATTED')
        open(unit=resFileNo,file="C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\fortran\Repulsion\DataFigs\separateDcurves\A2Sc0,05G3v1\residues\13.txt", FORM='FORMATTED')
        call countFileLines(301, freqsNum); rewind(301);
        allocate(freqs(freqsNum), dzetas(freqsNum), resK11(freqsNum))
        do i = 1, freqsNum
            read(301, *) freqs(i), dzetas(i)   
        enddo    
        close(301);
    end        
    
    
    subroutine countFileLines(fileNo, nlines)
    implicit none
    integer fileNo, nlines, io
        nlines = 0
        DO
          READ(fileNo,*,iostat=io)
          IF (io/=0) EXIT
          nlines = nlines + 1
        END DO
    end