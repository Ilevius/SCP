! real roots dzeta_k of a comlex-valued function F(t)
! (usually F(t)=Delta(al), t=real(al) - denominator of 
! Green's matrix K(al) for a multilayered half-space (MultiKD))

    subroutine HalfcPlus(F,tmin,tmax,ht,eps,Nmax,dz,Nx)
    implicit none
    integer Nmax,Nx,it,ir,ii

    real*8 tmin,tmax,t1,t2,ht,eps,dz(Nmax),rf1,rf2,if1,if2, &
	  epsf,signr,signi,u1,u2,u,sgr,sgi,rfu1,rfu2,ifu1,ifu2, &
	  rfu,ifu,sigi,sigr,rfz,ifz,rfz1,ifz1,rfz2,ifz2,z1,z2,z

	complex*16 F,ft,fz


! initial values	
    Nx=0; it=1; epsf=eps/1d7
	t1=tmin;  ft=F(t1)
    rf1=real(ft);	if1=imag(ft)    

! ht steps

 1  t2=t1+ht 
    if(t2 > tmax)then
      t2=tmax; it=-1
	end if
    ft=F(t2); rf2=real(ft);	if2=imag(ft)

!    write(2,33)t2,ft
! 33 format('  t,ft=',f11.5,2d12.5)

    if(abs(rf2) < epsf)then
	  signr=-1; ir=-1
	else
	  signr=rf1*rf2; ir=1
	end if

    if(abs(if2) < epsf)then
	  signi=-1; ii=-1
	else
	  signi=if1*if2; ii=1
	end if

! simultaneous change of the signs on the interval [t1,t2]

    IF((signr < 0).and.(signi < 0))THEN


! special case ReF=ImF=0
	  if((ir < 0).and.(ii < 0))then
	    Nx=Nx+1; dz(Nx)=t2
		go to 2
	  end if

	  u1=t1; rfu1=rf1; ifu1=if1
	  u2=t2; rfu2=rf2; ifu2=if2	  	  

! root's localisation
   
  3   u=(u1+u2)/2;  ft=F(u)
	  rfu=real(ft); ifu=imag(ft)

      sgr=rfu1*rfu; sgi=ifu1*ifu

!    write(2,34)u,ft
! 34 format('      u,fu=',f11.5,2d12.5)

!   non-synchronous signs change
	  if((ir > 0).and.(ii > 0).and.(sgr*sgi < 0))go to 2
		
	  if(ir > 0)then
		if(sgr > 0)then
	      u1=u; rfu1=rfu; ifu1=ifu
		else
	      u2=u; rfu2=rfu; ifu2=ifu
		end if
	  else
	    if(sgi > 0)then
	      u1=u; rfu1=rfu; ifu1=ifu
		else
	      u2=u; rfu2=rfu; ifu2=ifu
		end if
	  end if
	  
	  if(abs(u1-u2) > eps)go to 3

! picking up the root selected
      Nx=Nx+1; dz(Nx)=u

!  write(2,35)Nx,u
! 35 format('  Nx,u=',i5,d12.5)
	ELSE if((signr < 0).or.(signi < 0)) then
	 !one part is zero and anouther didn't change the signum
	 if((ii<0).or.(ir<0))  goto 2


	 if(signr<0)then
	 ! finding the root of REAL part		
		z1=t1;  rfz1=rf1; ifz1=if1;
		z2=t2;  rfz2=rf2; ifz2=if2;
		

  5		z=(z1+z2)/2;   fz=F(z);
		rfz=real(fz);  ifz=imag(fz);

        sigr=rfz1*rfz;   sigi=ifz1*ifz;
		if(sigr<0) then
		 z2=z; 	rfz2=rfz;  ifz2=ifz;
		else
		 z1=z;  rfz1=rfz;   ifz1=ifz;
		endif !(sigr<0)

 		 if(sigi<0) then ! sinhronos signum shange
		  u1=z1;  rfu1=rfz1; ifu1=ifz1;
		  u2=z2;  rfu2=rfz2; ifu2=ifz2;
		  goto 3 ! jumping to find root of F(z)
		 endif

		if(abs(z1-z1)<eps) goto 2 ! it's only Real part root

		! once more half division
        goto 5  

	 else !it mean (signi<0)
	 ! finding the root of IMAGINE part
		z1=t1;  rfz1=rf1; ifz1=if1;
		z2=t2;  rfz2=rf2; ifz2=if2;
		

  7		z=(z1+z2)/2;   fz=F(z);
		rfz=real(fz);  ifz=imag(fz);

        sigr=rfz1*rfz;   sigi=ifz1*ifz;
		if(sigi<0) then
		 z2=z; 	rfz2=rfz;  ifz2=ifz;
		else
		 z1=z;  rfz1=rfz;   ifz1=ifz;
		endif !(sigi<0)

 		 if(sigr<0) then ! sinhronos signum shange
		  u1=z1;  rfu1=rfz1; ifu1=ifz1;
		  u2=z2;  rfu2=rfz2; ifu2=ifz2;
		  goto 3 ! jumping to find root of F(z)
		 endif

		if(abs(z1-z1)<eps) goto 2 ! it's only IMAG part root

		! once more half division
        goto 7  


	 endif !(signr<0)

 	END IF

! looking for the next roots
 
 2	t1=t2; rf1=rf2; if1=if2
    if((Nx < Nmax).and.(it > 0)) go to 1

    end                       
        