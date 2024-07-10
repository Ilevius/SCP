! Version 2014.05.10  

! Functions M,N,P,R,S(al,z)and their z-derivatives 
! of Green's matrix symbol K(al,z) for a set of elastic structures:

!   iK = 1 - multilayered (N-layered) half-space
!   iK = 2 - multilayered plate with stress-free bottom side
!   iK = 3 - multilayered plate with clamped bottom side
!   iK = 4 - multilayered plate on acoustic half-space
!   any other iK works as iK = 1

!   iY = 1 - calculates only functions P and R (without M and S; 
!   any other iY - all four functions  (N depending on iN)

!   iN = 1 - calculates N(al,z) in addition to M, P, R and S
!   any other iY - without N

! (algorithm with non-exponential diagonal blocks, MultiK modification)

!				INPUT (via Global_Mult):

! keys iK, iY, iN (see above), interger
! al - 'alpha', complex(8)
! z - depth 'z', real(8)
! w - angular frequency 'omega', real(8) 
! Ns - number of sublayers + underlying half-space (1 <= Ns <= 101), integer

!       Structural parameters :

! Vp(m), Vs(m), rho(m), hs(m), m=1,Ns - vp,vs,rho,h for each sublayer
!      Comments:
!        hs(Ns) = inf. => so it is ignored and may be any;
!        for an acoustic underlying half-space, it must be Vs(Ns) = 0,
!        otherwise (Vs(Ns) > 0) - usual elastic half-space 
  
!			OUTPUT (via Global_Mult):
!
! cM,cN,cP,cR,cS,- values of the Green's matrix functions 
!                  for the inputed (al,z w) and structural parameters
! cM1,cN1,cP1,cR1,cS1 - their z-derivatives
! cMn,cNn,cPn,cRn,cSn - values for body wave asymptotics for solid base (iK = 1) and
!                       acoustic half-space (iK = 4)

    subroutine MultiK_Uni
    use Global_Mult; implicit none
    
    integer k,k0,m

!	real(8) 
	
	complex(8) Mk(4,4),tk(4),Y(4),Nk(2,2),sk(2),X(2), &
	           ex(4),exzN(2),s1,s2,s11,s22 
	
 ! check acoustic
    
    if(ik == 4)Vs(Ns)=0d0
 
 ! allocation
 
    if(Ns.ne.Ns0)then
      if(allocated(bl))deallocate(bl,bm,blm,zk,AM,AN,t,s)
      Ns0 = Ns; NsM=4*Ns; NsN=2*Ns; Mf=2
      if(iY == 1)Mf=1
    end if ! Ns
    
    if(.not.allocated(bl))then
      allocate (bl(Ns),bm(Ns),blm(Ns),zk(Ns+1)) ! work real
      allocate (AM(NsM,NsM),AN(NsN,NsN),t(NsM,Mf),s(NsN,1), &
                rb1(NsM,NsM),rb2(NsM,Mf+3),sg1(Ns),sg2(Ns)) ! work complex     
    end if ! allocation
       	      	
! sigma(k), z_k, lambda, mu

    al2=al*al; zk(1)=0d0
    
    do k=1,Ns
      zk(k+1)=zk(k)-hs(k); 
      blm(k) =rho(k)*Vp(k)**2;
      bm(k)  =rho(k)*Vs(k)**2;   bl(k)=blm(k)-2d0*bm(k)    

      sg1(k)=sqrt(al2-(w/Vp(k))**2-(0d0,1d-30))
      if((k == Ns).and.(iK == 4)) then 
        sg2(k) = 0d0;  ! ! acoustic half-space
      else    
	    sg2(k)=sqrt(al2-(w/Vs(k))**2-(0d0,1d-30))
	  end if
    end do
    	      	
! system for t_k (M,P,R,S)

    call Matrix_AM

    call STAR5(AM,t,rb1,rb2,NsM,NsM,Mf,2)
    
! system for s_k (N(al,z) if iN = 1)

    if(iN == 1)then
    
      call Matrix_AN

      call STAR5(AN,s,rb1,rb2,NsN,NsN,1,2)
	
	end if ! iN = 1
		     
! results P,R amd M,S (Mf = 2)

!   k - number of the layer with z: z_k+1 < z < z_k
    
 	do k=1,Ns
	  kz=k; if(z.ge.zk(k+1))go to 1
	end do ! m
	
1	k=kz; k0 = 4*(k-1)

! current sigma

    s1=sg1(k); s2=sg2(k); s11=s1*s1; s22=s2*s2;  

! exponents ex(z)
	
	ex(1)=exp( s1*(z-zk(k))  )
	ex(2)=exp( s2*(z-zk(k))  )
  	ex(3)=exp(-s1*(z-zk(k+1)))
	ex(4)=exp(-s2*(z-zk(k+1)))

! matrix Mk

    Mk(1,1)=1d0;  Mk(1,2)=s2;     Mk(1,3)=1d0;  Mk(1,4)=-s2
    Mk(2,1)= s1;  Mk(2,2)=s22;    Mk(2,3)=-s1;  Mk(2,4)= s22
    Mk(3,1)= s1;  Mk(3,2)=al2;    Mk(3,3)=-s1;  Mk(3,4)= al2
    Mk(4,1)=s11;  Mk(4,2)=al2*s2; Mk(4,3)=s11;  Mk(4,4)=-al2*s2

! Y_m => result

    do m=1,Mf
      tk(1:4)=t(k0+1:k0+4,m)*ex(1:4); Y=MATMUL(Mk,tk)
      
      if(m == 1)then
        cP=Y(1); cP1=Y(2); cR=Y(3); cR1=Y(4) 
      else
        cM=Y(1); cM1=Y(2); cS=Y(3); cS1=Y(4) 
      end if    
    end do

! results N(al,z) (iN = 1)

    if(iN == 1)then
    
! matrix Nk

      Nk(1,1)=  1;  Nk(1,2)=  1;     
      Nk(2,1)= s2;  Nk(2,2)=-s2;    

      k=kz; k0 = 2*(k-1);  sk(1)=s(k0+1,1)*ex(2); sk(2)=s(k0+2,1)*ex(4)
    
      X=MATMUL(Nk,sk);  cN = X(1);  cN1 = X(2)
      
    end if ! iN = 1

! body wave asymptotics

! solid base (iK = 1)

    if(iK == 1)then
      k=Ns; k0 = 4*(k-1) 
      s1=sg1(k); exzN(1)=exp(-s1*zk(Ns))
      s2=sg2(k); exzN(2)=exp(-s2*zk(Ns))
            
      do m=1,Mf
        tk(1:2)=t(k0+1:k0+2,m)*exzN(1:2)     
        if(m == 1)then
          cPn(1)=tk(1);    cPn(2)=tk(2)*s2; 
          cRn(1)=tk(1)*s1; cRn(2)=tk(2)*al2; 
        else
          cMn(1)=tk(1);    cMn(2)=tk(2)*s2; 
          cSn(1)=tk(1)*s1; cSn(2)=tk(2)*al2; 
        end if    
      end do

! function N (iN=1)

      if(iN == 1)then
        k=Ns; k0 = 2*(k-1);
           
        cNn(1)=0d0; cNn(2)=s(k0+1,1)*exzN(2)        
      end if
      
    end if ! solid base (iK = 1)

! asymptotics for acoustic half-space (iK = 4)

    if(iK == 4)then
      k=Ns; k0 = 4*(k-1); 
      s1=sg1(k); tk(1)=t(k0+1,1)*exp(-s1*zk(Ns))     

      cPn(1)=tk(1);    cPn(2)=0d0; cMn=0d0
      cRn(1)=tk(1)*s1; cRn(2)=0d0; cSn=0d0; cNn=0d0
    end if

    if(iN.ne.1)return
    
! body wave asymptotics
    
    end
