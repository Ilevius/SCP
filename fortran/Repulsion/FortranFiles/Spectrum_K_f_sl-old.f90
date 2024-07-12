! Frequency-slownes spectrum of a K_ij element of 
! the Green matrix K calculated by MultiK_An
!  
! Output: Array for plotting surface |K_ij(f,sl)|
!         on the freq.-slown. plane
! (K11, K31, K13 or K33 for Kij = 1,2,3 or 4, respectively; 
!  else --> empty array)
 

    subroutine Spectrum_Kf_sl
	use Mult_Glob; implicit none

    integer Kij,Nf,Nsl,i,j
    
    real(8) sl1,sl2,hsl,ff1,ff2,hff,gm
    real(8), allocatable:: aK(:),sl(:),ff(:)
    
    complex(8) alf
        
    common/gm/gm
    
    namelist/inp_Kij/Nf,Nsl,ff1,ff2,sl1,sl2,Kij

! input    
    read(1,inp_Kij)
    write(2,11)Nf,Nsl,ff1,ff2,sl1,sl2,Kij
 11 format('  Nf,Nsl  =',2i5/ &
           '  ff1,ff2 =',2f12.5/ &
           '  sl1,sl2 =',2f12.5  &
           '      Kij =',i5)
!   Kij = 1,2,3 or 4 ==> K11, K31, K13 or K33, else --> stop

    if(ff1 < 1d-15)then
      ff1 = ff2/Nf; write(2,3)ff1
 3    format('   ff1 =',f12.5)
    end if     
           
! output file and arrays

    open(unit=20,file='.\DataFigs\'//'inp_Kij.dat',status='unknown')
    open(unit=21,file='.\DataFigs\'//'aK.dat',status='unknown')

    allocate(ff(Nf),aK(Nsl),sl(Nsl))
    
    hff = (ff2 - ff1)/(Nf -1)
    hsl = (sl2 - sl1)/(Nsl-1)
    
    key = 1 ! for MultiK_An
 
    do i=1,Nf;  ff(i) = ff1 + hff*(i-1); end do
    do j=1,Nsl; sl(j) = sl1 + hsl*(j-1); end do

    write(20,1)Nf ,ff1,ff2,hff
    write(20,1)Nsl,sl1,sl2,hsl
    write(20,1)Kij  
 1  format(i10,3f15.5)  
 
! main loops
 
    do i=1,Nf
      f = ff(i); w = 2d0*pi*f
      
      do j=1,Nsl    
        alf = sl(j)*w
	    
	    call MultiK_An(alf,gm,0d0)

!   Kij = 1,2,3 or 4 ==> K11, K31, K13 or K33, else --> stop

        if(Kij == 1)aK(j) = abs(Kaz(1,1))
        if(Kij == 2)aK(j) = abs(Kaz(3,1))
        if(Kij == 3)aK(j) = abs(Kaz(1,3))
        if(Kij == 4)aK(j) = abs(Kaz(3,3))

! balanced
!        aK(j) = w*w*abs(aK(j))*sqrt(alf)
        aK(j) = w*abs(aK(j))
        if(aK(j)> 20.) aK(j) = 20.
      end do ! j for sl -> alf
           
      print *,' i,f =',i,f
      write(2,*)' i,f =',i,f
      write(21,2)ak(1:Nsl)
  2   format(1000d15.6)  
     
    end do ! j for f   
    
  end ! Lmb-f_Spectrum
