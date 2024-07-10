!  MultiK_Uni_test - check boundary conditions for MultiK_Uni

    program MultiK_Uni_test
    use Global_Uni; implicit none

    integer i,j,ku,m,m1,k,Ns

	real*8 bl(Nsd),blm(Nsd),z,Ek(Nsd),vk(Nsd),rok(Nsd),zm(Nsd+1),w,bm(Nsd)

	complex*16 u,u2,c,cM,cN,cS,cM1,cN1,cS1, &
	   Tp(2,4),Tm(2,4),Yp(4,2),Ym(4,2), &
	   TYp(2,2),TYm(2,2),lXp,lXm ,bt,al,al2,ci
	  
	 parameter(ci=(0d0,1d0))
 
! input

    open(unit=1,file='inp.dat',status='old')
    open(unit=2,file='out.dat',status='unknown')

	read(1,*) Ns
    do k=1,Ns
      read(1,*)Ek(k),vk(k),rok(k),hs(k)
    end do ! k
		 
    write(2,4)Ns,(Ek(k),vk(k),rok(k),hs(k),k=1,Ns)
    print 4,  Ns,(Ek(k),vk(k),rok(k),hs(k),k=1,Ns)

 4  format('  Ns =',i3/'  Ek,vk,rok,hs'/ &
                20(d15.3,f12.3,2d12.3/))
    close(1)

    zm(1)=0d0
    do k=1,Ns
      bl(k)=Ek(k)*vk(k)/((1+vk(k))*(1-2*vk(k)))
      bm(k)=Ek(k)/(2*(1+vk(k)))
      blm(k)=bl(k)+2*bm(k)

      vp(k)=sqrt(blm(k)/rok(k))
      vs(k)=sqrt(bm(k)/rok(k))
      rho(k)=rok(k)
      
	  zm(k+1)=zm(k)-hs(k)

     write(2,8)k,bl(k),bm(k),blm(k),zm(k)
 8   format(i3,' bl,bm,blm,zm=',4d12.5)
    end do

! test
    cM=0; cM1=0; cS=0; cS1=0; cN=0; cN1=0; TYp=0
    w=0.2; 
    do ku=1,10,3
      
	  bt=w/Vs(Ns)/5-ci/5+10*(ku-1); 
      al=w*bt; al2=u*u
	  write(2,33)al
 33   format('  al=',2f12.5)
     
! z=0
      c=-ci*bm(1)
      Tp(1,1)=-bl(1)*u2; Tp(1,2)=0; Tp(1,3)=0; Tp(1,4)=blm(1);
      Tp(2,1)= 0;        Tp(2,2)=c; Tp(2,3)=c; Tp(2,4)=0;

      call MultiK_Ac(al,0d0,w,Ns)
     
      Yp(1,1)=cP;   Yp(1,2)=cM
      Yp(2,1)=cP1;  Yp(2,2)=cM1
      Yp(3,1)=cR;   Yp(3,2)=cS
      Yp(4,1)=cR1;  Yp(4,2)=cS1
	
	  TYp=Matmul(Tp,Yp);


	  write(2,*); write(2,*)'   z=0'
      write(2,7)((Typ(i,j),j=1,2),i=1,2)
 7    format('   T*Y'/2(2d12.4,4x))

! at the layers

      do m=2,Ns
	    m1=m-1;      c=-ci*bm(m1)
        Tp(1,1)=-bl(m1)*u2; Tp(1,2)=0; Tp(1,3)=0; Tp(1,4)=blm(m1);
        Tp(2,1)= 0;         Tp(2,2)=c; Tp(2,3)=c; Tp(2,4)=0;

        call MultiK_Ac(al,zm(m)+1d-12,w,Ns)

        Yp(1,1)=cP;   Yp(1,2)=cM
        Yp(2,1)=cP1;  Yp(2,2)=cM1
        Yp(3,1)=cR;   Yp(3,2)=cS
        Yp(4,1)=cR1;  Yp(4,2)=cS1
	  
	    TYp=Matmul(Tp,Yp)

 	    write(2,*); write(2,*)'   z+0=',zm(m)	   
        write(2,9)cM,cN,cP,cR,cS
 9      format(' cM,cN,cP,cR,cS'/3(2d12.4,4x))	   
        write(2,7)((Typ(i,j),j=1,2),i=1,2)
	    
! z=z-0

        if(m == Ns+1)cycle
		c=-ci*bm(m)
        Tm(1,1)=-bl(m)*u2; Tm(1,2)=0; Tm(1,3)=0; Tm(1,4)=blm(m);
        Tm(2,1)= 0;        Tm(2,2)=c; Tm(2,3)=c; Tm(2,4)=0;	

        call MultiK_Ac(al,zm(m)-1d-12,w,Ns)

        Ym(1,1)=cP;   Ym(1,2)=cM
        Ym(2,1)=cP1;  Ym(2,2)=cM1
        Ym(3,1)=cR;   Ym(3,2)=cS
        Ym(4,1)=cR1;  Ym(4,2)=cS1

	    TYm=Matmul(Tm,Ym)

 	    write(2,*); write(2,*)'   z-0=',zm(m)	   
        write(2,9)cM,cN,cP,cR,cS
        write(2,7)((Tym(i,j),j=1,2),i=1,2)
   		
	  end do ! m
   
    end do ! ku

	end
