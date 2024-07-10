!  MultiK_Uni_test - check boundary conditions for MultiK_Uni
!  Tau, U -  stress and displacement for every layer
!  Q - load for the first layer (z=0)
!  z - point of calculation

    program MultiK_Uni_test
    use Global_Mult; implicit none

    integer k

	real*8 gm,pi,eps

	complex*16 a1,a2,a11,a12,a22,Q(3),U(3),Tau(3),U2(3),Tau2(3)
    parameter (pi=3.141592653589793d0)
	   
	namelist/input/Ns,iK,iY,iN,Vp,Vs,rho,hs
		   
! input

    open(unit=1,file='inp.dat',status='old')
    open(unit=2,file='out.dat',status='unknown')

    read(1,input); 
       
    print 1, Ns,iK,iY,iN
    write(2,1)Ns,iK,iY,iN
 1  format('  Ns =',i3,'  iK,iY,iN = ',3i3// &
           '       k,Vp,Vs,rho,hs'/20(i5,4f12.3/))
    close(1)

    print 2,  (k,Vp(k),Vs(k),rho(k),hs(k),k=1,Ns)
    write(2,2)(k,Vp(k),Vs(k),rho(k),hs(k),k=1,Ns)
 2  format(i5,4f12.3)

! test
    w=2.5d0; al=(2d0,-0.5d0); 
	write(2,3)w,al
 3  format('  w,al=',f12.5,2x,2f12.5)
 
    gm=0; gm=0d0;  a1=al*cos(gm); a2=al*sin(gm); eps=1d-15
    Q(1)=1d0;  Q(2)=2d0;  Q(3)=3d0
                
    do k=1,Ns+1
    
      if(k == 1)then
        z=0; call MultiK_Uni
             
             call Form_UT(a1,a2,Q,U,Tau)
       
        write(2,4)k,zk(1),Q(1:3),Tau(1:3)
 4      format(/'     k,z_k=',i5,f12.5// &
              ' Q=',3(2f10.5,2x)/ &
              ' T=',3(2f10.5,2x)/)
      else
        if(k < Ns+1)then
          z=zk(k)+eps; call MultiK_Uni; call Form_UT(a1,a2,Q,U,Tau)
          z=zk(k)-eps; call MultiK_Uni; call Form_UT(a1,a2,Q,U2,Tau2)
      
          write(2,5)k,zk(k),Tau,Tau2,U,U2
5         format('     k,z_k=',i5,f12.5// &
              ' T=',3(2f10.5,2x)/  &
              '   ',3(2f10.5,2x)// &
              ' U=',3(2f10.5,2x)/  &
              '   ',3(2f10.5,2x) / )  
        else
          if((iK == 1).or.(iK == 4))stop
          
          z=zk(k); call MultiK_Uni; call Form_UT(a1,a2,Q,U,Tau)
      
          write(2,6)k,zk(k),Tau,U
 6        format(/'     k,z_k=',i5,f12.5// &
              ' T=',3(2f10.5,2x)/  &
              ' U=',3(2f10.5,2x)/  )
        
        end if
      end if
    end do ! k
     
	end
