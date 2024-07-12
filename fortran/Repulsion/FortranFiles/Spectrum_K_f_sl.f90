! Frequency-slownes spectrum of a K_ij element of 
! the Green matrix K calculated by MultiK_An
!  
! Output: Array for plotting surface |K_ij(f,sl)|
!         on the freq.-slown. plane
! (K11, K31, K13 or K33 for Kij = 1,2,3 or 4, respectively; 
!  else --> empty array)
 

    subroutine Spectrum_Kf_sl
	use Mult_Glob; implicit none

    integer Nf,Nsl,i,j
    
    real(8) sl1,sl2,hsl,ff1,ff2,hff,gm,aK_max,hs2
    real(8), allocatable:: sl(:),ff(:),aK11(:),aK31(:),aK13(:),aK33(:)
    
    complex(8) alf
        
    common/gm/gm
    
    namelist/inp_Kij/Nf,Nsl,ff1,ff2,sl1,sl2,aK_max

! input    
    read(1,inp_Kij)
    write(2,11)Nf,Nsl,ff1,ff2,sl1,sl2,aK_max
 11 format('  Nf,Nsl  =',2i5/ &
           '  ff1,ff2 =',2f12.5/ &
           '  sl1,sl2 =',2f12.5  &
           '  aK_max  =', f12.2)
           
    if(ff1 < 1d-15)then
      ff1 = ff2/Nf; write(2,3)ff1
 3    format('   ff1 =',f12.5)
    end if     
           
! output file and arrays

    open(unit=20,file='.\DataFigs\'//'inp_Kij.dat',status='unknown')
    open(unit=21,file='.\DataFigs\'//'aK11.dat',status='unknown')
    open(unit=22,file='.\DataFigs\'//'aK31.dat',status='unknown')
    open(unit=23,file='.\DataFigs\'//'aK13.dat',status='unknown')
    open(unit=24,file='.\DataFigs\'//'aK33.dat',status='unknown')

    allocate(ff(Nf),sl(Nsl),aK11(Nsl),aK31(Nsl),aK13(Nsl),aK33(Nsl))
    
    hff = (ff2 - ff1)/(Nf -1)
    hsl = (sl2 - sl1)/(Nsl-1)
    
    key = 1 ! for MultiK_An
 
    do i=1,Nf;  ff(i) = ff1 + hff*(i-1); end do
    do j=1,Nsl; sl(j) = sl1 + hsl*(j-1); end do

    write(20,1)Nf ,ff1,ff2,hff
    write(20,1)Nsl,sl1,sl2,hsl
 1  format(i10,3f15.5)  

    if (Ms > 1)hs2 = hs(2)
    if (Ms ==1)hs2 = 0d0
    write(20,4)hs2
 4  format(f15.5)  
 
! main loops
 
    do i=1,Nf
      f = ff(i); w = 2d0*pi*f
      
      do j=1,Nsl    
        alf = sl(j)*w
	    
	    call MultiK_An(alf,gm,0d0)

! test, zeros 
!  Kaz(1,1)=1d0/(w*Kaz(1,1))
!  Kaz(3,1)=1d0/(w*Kaz(3,1))
!  Kaz(1,3)=1d0/(w*Kaz(1,3))
!  Kaz(3,3)=1d0/(w*Kaz(3,3))
!
!  aK11(j) = abs(Kaz(1,1))
!  aK31(j) = abs(Kaz(3,1))
!  aK13(j) = abs(Kaz(1,3))
!  aK33(j) = abs(Kaz(3,3))

!   |Kaz| ==> K11, K31, K13 or K33, balanced

        aK11(j) = w*abs(Kaz(1,1))
        aK31(j) = w*abs(Kaz(3,1))
        aK13(j) = w*abs(Kaz(1,3))
        aK33(j) = w*abs(Kaz(3,3))


        if(aK11(j)> aK_max) aK11(j) = aK_max
        if(aK31(j)> aK_max) aK31(j) = aK_max
        if(aK13(j)> aK_max) aK13(j) = aK_max
        if(aK33(j)> aK_max) aK33(j) = aK_max

      end do ! j for sl -> alf
           
      print *,' i,f =',i,f; write(2,*)' i,f =',i,f
      
      write(21,2)aK11(1:Nsl)
      write(22,2)aK31(1:Nsl)
      write(23,2)aK13(1:Nsl)
      write(24,2)aK33(1:Nsl)
  2   format(1000d15.6)  
     
    end do ! j for f   
    
  end ! Lmb-f_Spectrum
