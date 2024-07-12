! SteelWax and Bones
! Residues for poles from file 17 fcs.dat         

    subroutine ComplRes
	use Mult_Glob; implicit none

	integer m,n,iw  ! i,k,im,Nw	

	real(8) hres,rst,ist,gm 
	   
	complex(8) cr11,cr31,cr13,cr33,alf,dzt
		 
    common/gm/gm
    
    open(unit=19,file='.\DataFigs\'//'fcs_res.dat'   ,status='unknown')

    key = 1; rewind(17);  rewind(19)
    
 ! skip file heading
		
    do iw =1,5+3*Ms
 	  read (17,*,err=20,end=20)
 	end do	

    write(19,*)'    Ms, ibot - number of layers and key for the bottom type'
    write(19,*)' m  C_11   C_22   C_33 - 3*Ms lines below'
    write(19,*)'    C_12   C_13   C_23'
    write(19,*)'    C_44   C_55   C_66  tet rho hs,  '
      
    write(19,5)Ms,ibot
 5  format(2i7)
 	do m=1,Ms
      write(19,6)m,C_6(1,1,m),C_6(2,2,m),C_6(3,3,m), &
                   C_6(1,2,m),C_6(1,3,m),C_6(2,3,m), &
                   C_6(4,4,m),C_6(5,5,m),C_6(6,6,m),tet(m),rho(m),hs(m)
 6    format(i3,2x,3f15.5/5x,3f15.5/5x,3f15.5,3f15.5)	    
 	end do ! m

! branches 
 	read(17,*,err=20,end=20)n; 	write(19,3)n,' &'			
 3                              format(i7,a2)
    
    do while (n > 0); f=1 

	  do while (f > 0)
	    read (17,*,err=35,end=35)f,rst,ist; w = 2*pi*f;
		if(f >0)then
		
! residues K11, K31, K13, K33

          hres = 1d3*eps; dzt = w*cmplx(rst,ist)

          if((abs(dzt)-hres) < 0d0) hres = abs(dzt)-eps
   
          alf = dzt + hres	
          call MultiK_An(alf,gm,0d0); 

          cr11 = Kaz(1,1); cr31 = Kaz(3,1)  
          cr13 = Kaz(1,3); cr33 = Kaz(3,3)  
           
          alf = dzt - hres	
          call MultiK_An(alf,gm,0d0); 
        
          cr11 = hres*(cr11-Kaz(1,1))/2d0; 
          cr31 = hres*(cr31-Kaz(3,1))/2d0  
          cr13 = hres*(cr13-Kaz(1,3))/2d0 
          cr33 = hres*(cr33-Kaz(3,3))/2d0  
           
          write(19,33)f,rst,ist,cr11,cr31,cr13,cr33
33        format(f15.8,2f20.10,4(2x,2f20.10))        
                             
        else ! f < 0
          write(19,*)' -1  -1  -1  -1  -1  -1  -1  -1  -1  -1 '         
        end if ! f > 0
        
      end do ! while (f > 0)
		
  1	  read(17,*,err=25,end=25)n; write(19,3)n,' &'

	end do ! n > 0
	  
 25	write(19,*)' -1  -1  -1  -1  -1  -1  -1  -1  -1'
 	write(19,*)' -1  -1  -1  -1  -1  -1  -1  -1  -1'
    return  
 
! empty file
 20 write(2,*)' *** file 17 "fcs.dat" is empty, no sorting'
    stop 

! wrong file 
 35 write(2,*)' *** wrong file 17 "fcs.dat" ***'     
    stop

    end ! ComplRes

