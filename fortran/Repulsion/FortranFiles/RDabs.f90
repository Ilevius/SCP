! auxiliary function for real poles finding by Hamin
! on the slowness axis s=alpha/omega

    real(8) function RDabs(rs)
    use Mult_Glob; implicit none

	real(8) gm,rs,abc; complex*16 alf,c,det
	common/gm/gm/det/det

	alf=w*rs

	call MultiK_An(alf,gm,0d0)
!	call MultiK_An(alf,gm,-hs(1)/3)
	 
!   c = det
!    c = 1d0/(Kaz(3,1) + 1d0/Kaz(3,3))  ! + 1d0/Kaz(2,2)
!     c = 1d0/(Kaz(1,1))
!     c = 1d0/Kaz(2,2)
     c = 1d0/Kaz(3,3)
  
   	abc = abs(c)
	RDabs = abc
	
!	write(2,21)rs,abc
! 21  format(' s,dt =',f15.6,2d15.5)	
		
	end