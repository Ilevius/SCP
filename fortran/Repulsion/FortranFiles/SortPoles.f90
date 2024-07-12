! SteelWax and Bones
! Sorting of complex pole branches in file 17 'fcs.dat'

    subroutine SortPoles
	use Mult_Glob; implicit none

	integer Nn,n,iw,Nw,Nwmax,im,m,MMs,iibot 
	
	real(8) rst,ist,CC(6,6),ttet,rrho,hhs 
    
!	complex*16 cst 
	
    real(8), allocatable:: fn(:),rs(:),is(:),rdz(:)
	logical, allocatable :: mask(:)
	           		
! file for reserve copy

    open(unit=15,file='.\DataFigs\'//'temp.dat',status='unknown')   
    open(unit=18,file='.\DataFigs\'//'fcs.bak',status='unknown')

! making reserve file copy (bak),
! esimating the number of branches Nn
! and the maximal branch length Nwmax for n in [Nn1,Nn2]
    
    rewind(17);  rewind(18)
    read(17,*,err=20,end=20); read(17,*,err=20,end=20);
    read(17,*,err=20,end=20); read(17,*,err=20,end=20);

  	read(17,*,err=20,end=20)MMs,iibot      	  
    do im=1,MMs
 	  read(17,*,err=20,end=20)m,CC(1,1),CC(2,2),CC(3,3)
 	  read(17,*,err=20,end=20)  CC(1,2),CC(1,3),CC(2,3)
 	  read(17,*,err=20,end=20)  CC(4,4),CC(5,5),CC(6,6),ttet,rrho,hhs

 	  write(18,6)m,CC(1,1),CC(2,2),CC(3,3), &
 	               CC(1,2),CC(1,3),CC(2,3), &
 	               CC(4,4),CC(5,5),CC(6,6),ttet,rrho,hhs
 6    format(i3,2x,3f15.5/5x,3f15.5/5x,3f15.5,3f15.5)	    
    end do ! im

	read(17,*,err=20,end=20)n; write(18,3)n,' &'	
 3  format(i7,a2)

    Nn=n; Nwmax=0

    do while (n > 0); iw=0; f=1 

	  do while (f > 0)
	    read (17,*,err=22,end=22)f,rst,ist; iw=iw+1;
		if(f >0)    write (18,17)f,rst,ist; 		      
 17                 format(f10.5,2x,2f20.12)
	  end do ! f > 0

 22   write(18,*)'  -1  -1  -1  -1'

      if((n < Nn1).or.(n > Nn2))go to 1
	  if(iw > Nwmax)Nwmax=iw

  1	  Nn=n; read(17,*,err=25,end=25)n; write(18,3)n,' &'

	end do ! n > 0

! work arrays for current branches
	
 25 allocate(fn(Nwmax),rs(Nwmax),is(Nwmax),rdz(Nwmax),mask(Nwmax)); 
 
! new reading from the file top 
! sorting of required file 17 
! and its copy into temporary file 15
 
    rewind(17); rewind(15)

! skip file heading
		
    do iw =1,5+3*MMs
 	  read (17,*,err=20,end=20)
 	end do	

	read(17,*,err=20,end=20)n; 	write(15,3)n,' &'			
  	
! cycle for n over branches

    do while (n > 0); iw=0; f=1 

! branch data reading into the current arrays
! and writing into temporary file 15 if required

	  do while (f > 0)
	    read(17,*,err=23,end=23)f,rst,ist 		                  

		if((n < Nn1).or.(n > Nn2))then
		  if(f >0) write(15,17)f,rst,ist;
        else
		  if(f >0)then
 	       iw=iw+1; fn(iw)=f; rs(iw)=rst; is(iw)=ist 
 	                          rdz(iw)=2d0*pi*f*rst   
		  end if
		end if
 
	  end do ! f

! if out of [Nn1,Nn2] range -- next branch
 
 23	  if((n < Nn1).or.(n > Nn2))then
		f=-1; write(15,*)' -1  -1  -1  -1'
	  else

! for [Nn1,Nn2] range -- write into file 15 with sorting 
	    
 	    Nw=iw; mask(1:Nw)=.true.; mask(Nw+1:Nwmax)=.false. 
        do iw=1,Nw
!		  im = minloc(fn,1,mask); mask(im)=.false.
		  im = minloc(rdz,1,mask); mask(im)=.false.
		  write(15,17)fn(im),rs(im),is(im)
        end do
		f=-1; write(15,*)' -1  -1  -1  -1'

	  end if
	
	  read(17,*,err=24,end=24)n; write(15,3)n,' &'		

	end do ! n
 
 24 continue;  ! return

! --------------------------------
! Copying sorted data from file 15 
!       into the permanent file 17

    rewind(15); rewind(17); rewind(18)

! file heading
    
    write(17,*)'    Ms, ibot - number of layers and key for the bottom type'
    write(17,*)' m  C_11   C_22   C_33 - 3*Ms lines below'
    write(17,*)'    C_12   C_13   C_23'
    write(17,*)'    C_44   C_55   C_66  tet rho hs,  '
      
    write(17,5)MMs,iibot
 5  format(2i7)
 
    do im=1,MMs
 	  read(18,*,err=20,end=20)m,CC(1,1),CC(2,2),CC(3,3)
 	  read(18,*,err=20,end=20)  CC(1,2),CC(1,3),CC(2,3)
 	  read(18,*,err=20,end=20)  CC(4,4),CC(5,5),CC(6,6),ttet,rrho,hhs

 	  write(17,6)m,CC(1,1),CC(2,2),CC(3,3), &
 	               CC(1,2),CC(1,3),CC(2,3), &
 	               CC(4,4),CC(5,5),CC(6,6),ttet,rrho,hhs
    end do ! im

	read(15,*,err=20,end=20)n; 	write(17,3)n,' &'			
  	
! cycle for n over branches

    do while (n > 0); iw=0; f=1 

	  do while (f > 0)
	    read (15,*,err=26,end=26)f,rst,ist 
        if(f > 0)    write(17,17)f,rst,ist
	  end do ! f
 	
 26	  f=-1; write(17,*)' -1  -1  -1  -1'
 
      read(15,*,err=27,end=27)n; write(17,3)n,' &'		

	end do ! n

 27 write(17,*)' -1  -1  -1  -1' 
    close(15); close(17); close(18);return

! empty file

 20 write(2,*)' *** file 17 (fcs.dat) is empty, no sorting'
    stop 

    end ! ComplPoles

