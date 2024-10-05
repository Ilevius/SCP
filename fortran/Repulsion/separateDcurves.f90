    MODULE SDC_globals
    integer resFileNo, freqsNum, SDcurvesNum, dotsNum
    character (len=40) curvesDir
    real*8 fOld, alfaOld, SDCstep, fMax
    real*8 fMin, fStep, dzMin, dzMax, haminStep, haminEps
    
    real*8, allocatable:: freqs(:), dzetas(:), resK11(:), f_sp(:), alfa_sp(:)
    namelist /basicInfo/SDcurvesNum, fmax, SDCstep, curvesDir
    namelist /startPoints/ f_sp, alfa_sp, fMax
    namelist /simpleDC/ dotsNum, fMin, dzMin, dzMax, haminStep, haminEps
    
    CONTAINS 
        subroutine initSeparateDcurves
        IMPLICIT NONE
            open(unit=1,file='SeparateDcurves settings.txt',status='old')
            read(1, basicInfo)
            allocate(f_sp(SDcurvesNum), alfa_sp(SDcurvesNum))
            read(1, startPoints)
            read(1, simpleDC)
            close(1)       
        end
    END MODULE
    
    
    
    SUBROUTINE simpleDcurves
    use Mult_Glob;            ! GIVES US w, f, pi
    use SDC_globals;
    IMPLICIT NONE
    real*8 dz(20)
    integer i, j, Ndz
    real*8 RDabs, RDabs_alf, vs, kap2
    external RDabs,RDabs_alf
        call initSeparateDcurves
        dz = 0d0;
        vs = sqrt(C_6(6,6,1)/rho(1))
        open(unit=301, file='.\DataFigs\separateDcurves\'//trim(curvesDir)//'\Dcurves\simpleDcurves.txt', status='unknown')
        fstep = (fmax - fmin)/dotsNum;
        print*, 'Regular, non separate d curver plot has been started'
        do i = 1, dotsNum
            f = fmin + fstep*(i-1); w = f*2d0*pi; kap2=w*hs(1)/vs;
            call Hamin(RDabs, dzMin, dzMax, haminStep, haminEps, 20, dz, Ndz)
            do j = 1, Ndz
                write(301, '(5E15.6E3)') f, dz(j)*w, dz(j)
            enddo    
        enddo
        close(301)
    END SUBROUTINE simpleDcurves
    
    
                                                                ! auxiliary function for real poles finding by Hamin
    real(8) function arcRDabs(angle)
    use Mult_Glob; 
    use SDC_globals;
    implicit none
	real(8) gm,angle; 
    complex*16 alf,c,det
	common/gm/gm/det/det
        w = 2d0*pi*(cos(angle)*SDCstep + fOld)
	    alf = (sin(angle)*SDCstep + alfaOld)*(1d0,0d0)
	    call MultiK_An(alf,gm,0d0)
        c = 1d0/Kaz(3,3)
	    arcRDabs = abs(c)
    end
    
    

    subroutine SCP1(f0, alfa0, file)
    use SDC_globals;
    use Mult_Glob; 
    implicit none
    integer  Ndz, choice, iterno, j, file
    real*8 f0, alfa0, fNew, alfaNew, step, dz(20), psi, arcRDabs
    external arcRDabs
    !    !                                                                    первые шаги, подготовка к автоматике
        step = SDCstep; fOld = f0; alfaOld = alfa0;
        call Hamin(arcRDabs, 0d0, pi, 1d-3, 1d-7, 20, dz, Ndz)
        alfaNew = sin(dz(1))*SDCstep + alfaOld; fNew = cos(dz(1))*SDCstep + fOld;
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
                    if (step < SDCstep) SDCstep = SDCstep*2d0
                     choice = 1; exit;
                endif    
                iterno = iterno + 1; if (iterno > 5) exit;
            enddo
            alfaNew = sin(dz(choice))*SDCstep + alfaOld; fNew = cos(dz(choice))*SDCstep + fOld;
            w = 2d0*pi*fNew        
            write(file, '(4E15.6E3)') fNew, alfaNew
            psi = atan( (fNew-fOld)/(alfaNew-alfaOld) ); fOld = fNew; alfaOld = alfaNew;
            if (fNew>fmax) exit;
        enddo 
    end subroutine SCP1
    
    
    subroutine plotAllcurves
    use SDC_globals;
    implicit none
    integer i, fileNum
    character(len=20) fileName, str
    external str
        call initSeparateDcurves
        print*, 'Separate disp curves plotting has been started!'
        do i = 1, SDcurvesNum
            fileName = str(i)
            fileNum = i+300
            print*, 'Curve ', i, ' plotting has been started!'
            open(unit=fileNum, file='.\DataFigs\separateDcurves\'//trim(curvesDir)//'\Dcurves\'//trim(fileName)//'.txt', FORM='FORMATTED')
            call SCP1(f_sp(i), alfa_sp(i), fileNum)
            close(fileNum)
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
    
    
    character(len=20) function str(k)
!   "Convert an integer to string."
    integer, intent(in) :: k
        write (str, *) k
        str = adjustl(str)
    end function str