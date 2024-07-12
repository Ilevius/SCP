! auxiliary function for real poles finding by Hamin
! on the frequency axis f

    real(8) function RDfabs(ff)
    use Mult_Glob; implicit none

	real(8) gm,rs,ff 
	complex*16 alf,c
	common/slown/rs/gm/gm

	f = ff; w=2d0*pi*f;
		
	alf=w*rs

	call MultiK_An(alf,gm,0d0)
	 
!    c = 1d0/(Kaz(3,1) + 1d0/Kaz(3,3))  ! + 1d0/Kaz(2,2)
!    c = 1d0/(Kaz(1,1))
!    c = 1d0/Kaz(2,2)
     
    c = 1d0/Kaz(3,3)
	
	RDfabs = abs(c)
	
!	write(2,21)rs,abc
! 21  format(' s,dt =',f15.6,2d15.5)	
		
	end