! integrands for Response
! tangential and vertical loads applied to [-a,a]  

    subroutine KQ2(bt,s,Ni)
	use Mult_Glob; implicit none
	
	integer Ni

	real*8 gm,a
	
	complex*16 bt,alf,s(Ni),Q2,aalf

 	common/gm/gm/a/a

    w=2d0*pi*f; alf=bt*w; aalf=a*alf
    
    if(abs(aalf) > 1d-12)then
      Q2 = (sin(aalf)/aalf)**2
    else
      Q2 = 1d0
    end if

	call MultiK_An(alf,gm,0d0)

    s(1) = Kaz(1,1)*Q2
    s(2) = Kaz(3,3)*Q2
	  	   
    end                       
        