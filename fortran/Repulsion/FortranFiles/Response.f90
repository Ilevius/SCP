! Response -- averaged surface displacements versus fequency
! normalized to load
           
    subroutine Response
	use Mult_Glob; implicit none

	integer i,j,k,Ni        	
	         
	real*8 t1,t2,t3,t4,tmm,tp,pr,gr,gm,a,xpmax &
	       ,dmax1
      
	complex(8) Sd(2)
	
 	common/gm/gm/a/a
	
	external KQ2  !, KQ2_alf

    open(unit=20,file='.\DataFigs\'//'response.dat',status='unknown')

! parameters for integration
	
	key = 1; ! gm = 0d0 - есть в Init; z = 0 - уже в KQ2  
	a = 0.25d0;  ! a = 0.5d0 mm for Bones
	             ! a = 0.25d0 for SW-dimless (2.5 mm/10 mm)
	pr=0.01;  Ni=2
	
	xpmax = 0d0
	do i = 1,3; do j = 1,Ms
	   if(xp(i,j) > xpmax)xpmax = xp(i,j)
	end do; end do;
	
	t1 = pr; t2 = 1d0+1.5d0*xpmax; t3=t2; t4=t3; tmm=0.1*pr; tp=0d0;  
    gr=1d0+t4  ! gr=1d3
    
! f-cycle

    do f = f1,f2,hf
       w=2d0*pi*f; 

 	  call DINN5(KQ2,t1,t2,t3,t4,tmm,tp,eps,pr,gr,Ni,Sd)

! Compliance
      Sd(1:2) = (w/pi)*Sd(1:2)
      
      write(2,2)f,Sd(1:2); print 2, f !,Sd(1:2)   
2     format(' f,C11,C33 = 'f12.5,2(2d15.5,2x))

      write(20,3)f,Sd(1:2) 
3     format(f10.5,2(2x,2f20.12))

    end do

    write(20,*)' -1  -1  -1  -1  -1' 
    write(20,*)' -1  -1  -1  -1  -1' 

  end ! Response
