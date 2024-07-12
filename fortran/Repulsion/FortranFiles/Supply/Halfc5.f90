! Modified Halfc 2018.02.23
!
! real roots dzeta_k of a comlex-valued function F(t)
! (usually F(t)=Delta(al), t=real(al) - denominator of 
! Green's matrix K(al) for a multilayered half-space (MultiKD))
!
! 5-point estimation of the zero level 

    subroutine Halfc5(F,tmin,tmax,ht,eps,Nmax,dz,Nx)
    implicit none
    integer Nmax,Nx,it,ir,ii

    real*8 tmin,tmax,t1,t2,ht,eps,dz(Nmax),rf1,rf2,if1,if2, &
	  epsf,signr,signi,u1,u2,u,fu,fu1,fu2,af,af1,af2,af12, &
	  zero,hz

	complex*16 F,ft
    
! initial values	
    Nx=0; it=1; ir=1; ii=1;   !  epsf=eps/1d7
	t1=tmin;  ft=F(t1)
    rf1=real(ft); if1=imag(ft) 
!    write(2,33)t1,ft
! 33 format('  t,ft=',f14.5,2d15.5)

! zero level

    zero = abs(ft); hz = (tmax - tmin)/4d0
    do ii = 2,5
      zero = zero + abs(F(tmin+(ii-1)*hz))
    end do
    zero = zero/1d9
    
! ht steps

 1  t2=t1+ht 
    if(t2 > tmax)then
      t2=tmax; it=-1
	end if
    ft=F(t2); rf2=real(ft);	if2=imag(ft)
!  write(2,33)t2,ft

! analysis

    if((abs(rf1) < zero).or.(abs(rf2) < zero))then
      ir = -1; signr = 0 
    else 
      ir = 1; signr=rf1*rf2
    end if 
 
    if((ir > 0).and.(signr > 0))go to 2 ! no Re sign change on [t1,t2]
    
    if((abs(if1) < zero).or.(abs(if2) < zero))then
      ii = -1; signi = 0 
    else 
      ii = 1; signi=if1*if2
    end if 

    if((ii > 0).and.(signi > 0))go to 2 ! no Im sign change on [t1,t2]
    
! change of sign (or signs) on the interval [t1,t2]

    u1=t1; u2=t2
    
! localization of sign(Re(F)) change      

    if(ir > 0)then
      fu1 = rf1; af1 = abs(fu1);
      fu2 = rf2; af2 = abs(fu2); af12 = af1+af2
      
!  3   u = (af1*u2+af2*u1)/(af1+af2) 
 
  3   u = (u1+u2)/2d0 
      fu = real(F(u)); af = abs(fu)
!   write(2,34)u,fu
! 34 format('    u,fu=',f15.7,2d15.7)
      
      if(af > af12)go to 2 ! it is a pole
      
      if(fu*fu1 > 0)then
        u1 = u; fu1 = fu; af1 = af
      else
        u2 = u; fu2 = fu; af2 = af
      end if
      
      if((u2-u1) > eps)go to 3
      
    else; if(ii > 0)then
             
      fu1 = if1; af1 = abs(fu1);
      fu2 = if2; af2 = abs(fu2); af12 = af1+af2
      
!  4   u = (af1*u2+af2*u1)/(af1+af2) 
 
  4   u = (u1+u2)/2d0 
      fu = real(F(u)); af = abs(fu)
!   write(2,34)u,fu
      
      if(af > af12)go to 2 ! it is a pole
      
      if(fu*fu1 > 0)then
        u1 = u; fu1 = fu; af1 = af
      else
        u2 = u; fu2 = fu; af2 = af
      end if
      
      if((u2-u1) > eps)go to 4      
      
      end if !ii > 0 
    end if ! ir > 0
   
! Re(f) root is localized, check |F(u)| < zero        
      
    u = (u1+u2)/2d0;  ft=F(u); 
!  write(2,37)u,ft
!37 format(' *** u,ft=',f15.7,2d15.7)
   
    epsf = af12/100   
    if(abs(ft) < epsf)then
      Nx=Nx+1; dz(Nx)=u
!      write(2,35)Nx,u
! 35   format('  Nx,u=',i5,d12.5)
    end if ! |ft| < epsf

! looking for the next roots
 
 2	t1=t2; rf1=rf2; if1=if2
    if((Nx < Nmax).and.(it > 0)) go to 1

    end                       
        