! auxiliary function for real poles finding by Halfc
! on the slowness axis s=alpha/omega

    complex*16 function RDs(rs)
    use Mult_Glob; implicit none

	integer i; real(8) gm,rs; complex*16 alf,c,det
	common/gm/gm/det/det

	alf=w*rs

	call MultiK_An(alf,gm,0d0)
!	call MultiK_An(alf,gm,-2*hs(1))
	 
 !    c = det
!    c = 1d0/(Kaz(1,1) +1d0/Kaz(3,3))  ! + 1d0/Kaz(2,2)
     c = 1d0/(Kaz(1,1))
!     c = 1d0/Kaz(2,2)
!     c = 1d0/Kaz(3,3)
!     c = Kaz(3,3)
    	  
	RDs = c
	
 	  write(15,20)rs,abs(c),c
  20  format(f15.6,3f15.6)
!20   format(f15.6,3d15.5)

!	write(2,21)rs,c
! 21  format(' s,dt =',f15.6,2d15.5)	
		
	end