! Complex poles for SteelWax (Bones)            

    subroutine ComplPoles
	use Mult_Glob; implicit none

	integer MMs,Nit,Nn,n,iw,Nw,i0,it,np 
	real(8) rst,ist,ah,fs(4)

	complex*16 cst,cst0,CDS,alt,CDS_alf,cs(4),Acp(4),cvalp,cf
	
	complex(8), allocatable:: dzs(:)
    real(8), allocatable:: fv(:)
	          		
	external CDS,CDS_alf
 
! constants

    key = 1; ! vs = sqrt(C_6(6,6,1)/rho(1))

! estimate of file length for work arrays fv, dzs    

    rewind(17)
	do iw=1,10000000
      read(17,*,err=21,end=21)
	end do
	
 21 allocate(fv(iw),dzs(iw)); rewind(17)

! data from file for eliminating known roots 
!                at a current frequency
! skip file heading
		
	do iw=1,3*Ms+5
	  read(17,*,err=20,end=20)
	end do ! iw

	read(17,*,err=20,end=20)n	

! read branches

 20	iw=0
    do while (n > 0); f=1; 
	  do while (f > 0)
	    read(17,*,err=22,end=22)f,rst,ist;
		iw=iw+1; fv(iw)=f; dzs(iw)=cmplx(rst,ist)     
	  end do
      Nn=n; read(17,*,err=22,end=22)n
	end do 

 22 Nw=iw  !  Nw - число частот в файле 17
 
! allocation 'dzs0' for eliminable known roots
! Nit - number of Crootw25 calls for one ct0

    Nit=5; ah=100*abs(hf); allocate(dzs0(100))
 	
	cst0=cs0; np=0
    write(2,15) f1,cst0;  print 15, f1,cst0     
 15 format(/'  f0 =',f15.6,'   cst0=',2f20.6)

    do f=f1,f2,hf;  w=2*pi*f; ! w2 = w*w
      i0=0; 
	  do iw=1,Nw
	    if(abs(f-fv(iw)) < 1d-5)then
		  if(abs(cst0-dzs(iw)) < 0.5d0)then
		    i0=i0+1; dzs0(i0)=dzs(iw)
		end if; end if	  
	  end do ! iw
	  N0=i0

! Выбор начальной точки cst0 с помощью Cubic_splines
                    
      if(np == 1)cst0 = cst

      if(np == 2)then
        Acp(2) = (cs(2)-cs(1))/(fs(2)-fs(1))
        cst0 = cs(2) + Acp(2)*(f-fs(2))
      end if ! np = 2
      
      if(np >= 3)then
        cf = f; cst0 = cvalp(cf,Acp,np)
      end if
      
      np = np+1 
	  
	  do it = 1,Nit
		  cst=cst0
          call CROOTW25(cst,zh,eps,Max,ip,CDS)
          
		  if(abs( f - f1 ) < eps)go to 10
		  
		  if(f > 0.1d0)then
		    if(abs(cst-cst0) <  ah)go to 10
		  else
  		    if(w*abs(cst-cst0) <  ah)go to 10
		  end if

	      write(2,31)cst,cst0;  print 31,cst,cst0 
 31       format(' cst,cst0=',2(2d12.3,2x))
          N0=N0+1; dzs0(N0)=cst 
                               	   
	  end do ! it

	  write(2,30)Nit,cst,cst0;  print 30,Nit,cst,cst0; stop 
 30   format(' *** ComplPoles stop: Nit,cst,cst0=',i3,2(2d12.3,2x))
	  
 10   write(2,5) f,cst;  print 5, f,cst
 5    format(' f =',f10.4,'   cst=',2d13.5)
      
	  write(16,17)f,cst
 17   format(f10.5,2x,2f20.12)
 	  
! Polynomial coefficients for extrapolation
           
      if(np <= 4)then
        fs(np) = f; cs(np) = cst 
      else
        np = 4
        fs(1:np-1) = fs(2:np); cs(1:np-1) = cs(2:np) 
        fs(np) = f; cs(np) = cst
      end if  
      
      if(np >= 3)call CMPLAG1(cs,np,Acp,fs)
        
	end do ! f
  
    close(16)

    end ! ComplPoles

