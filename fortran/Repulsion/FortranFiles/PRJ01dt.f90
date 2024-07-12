! integrands for VIBROSdt

    subroutine PRJ01dt(al,s,Ni)
    implicit none	

    integer Nsd,Nrd
    parameter (Nsd=20,Nrd=500)
	
	integer j,j0,Ni,Nkr
    real*8 rw(Nrd),aP,aR

	complex*16 al,s(Ni),cM,cN,cP,cR,cS,c,cdj	  
        
    common/MKout/cM,cN,cP,cR,cS/Rk/rw,Nkr/aPR/aP,aR

! Pdz,Rdz

	call MultiK(al,0d0,1,-1)

! test
!    write(2,1)real(al),real(cR*al),aR,real(cP*al*al),aP
! 1 format(f10.3,2(2f12.6,2x))

	do j=1,Nkr
	  j0=2*(j-1);	  c=al*rw(j)

      s(j0+1)=(cP*al*al-aP)*cdj(c,1)
      s(j0+2)=(cR*al   -aR)*cdj(c,0)
    end do ! j
	
    end                       
        