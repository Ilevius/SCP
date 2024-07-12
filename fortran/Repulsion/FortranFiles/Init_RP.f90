! Initialisation for Repulsion

    subroutine Init_RP
    use Mult_Glob;  implicit none

	integer key_real,i,j,k,l,m,n,iv,jv,iso,MMs,iibot !,Mdim
	
	real(8) CC(6,6),ttet,rrho,hhs,err,gm,gmn,bmu,blam,blmu, &
	        sum,spm,ssm1,ssm2,pm,sm1,sm2,vb(3),rm(3),s1,s2,hpol

	complex(8) Av(3,3),mv(3),ev(3),evc(3,3)
	
    logical mask(3)

    namelist/inp_keys /Ms,ibot,Mode,iso      
    namelist/inp_iso  /V_p,V_s,tet,rho,hs
    namelist/inp_aniso/C_6,tet,rho,hs,isym 
    namelist/inp_work/gmn,eps,f1,f2,hf, &     ! common input
                      key_real,s1,s2,hpol, &  ! for real roots
                      Nn1,Nn2,Max,ip,cs0,zh   ! for complex roots

    common/gm/gm/realroots/s1,s2,hpol,key_real
   
! files 1 and 2	for input and output, 20 for temporary data

    open(unit=1,file='inp_rp.dat',status='old')
    open(unit=2,file='out_rp.dat',status='unknown')

! /inp-keys /Ms,ibot,Mode,iso 

    read(1,inp_keys)
    write(2,1)Ms,ibot,Mode,iso 
 1  format('  Ms,ibot,Mode,iso =',4i5)
      
! prepare arrays for material constants

    allocate(V_p(Ms),V_s(Ms),tet(Ms)) ! in case iso = 0
    allocate(C_6(6,6,Ms),C_3(3,3,3,3,Ms),rho(Ms),hs(Ms), &
                  zm(Ms+1),isym(Ms),xp(3,Ms))
    
    C_6=0; C_3=0; CC=0

! input material constants

    if(iso == 0)then   ! isotropic case
      
      read(1,inp_iso); ! /inp-iso  /V_p,V_s,rho,hs
      write(2,*)'  m, V_p, V_s, tet, rho, hs'
      write(2,2)(m,V_p(m),V_s(m),tet(m),rho(m),hs(m), m=1,Ms)
 2    format(i5,5f14.5)
 
      do m=1,Ms
        bmu  = V_s(m)**2*rho(m);  isym(m)=0 
        blmu = V_p(m)**2*rho(m);  blam = blmu - 2d0*bmu
    
        C_6(1,1,m)=blmu; C_6(2,2,m)=blmu; C_6(3,3,m)=blmu
        C_6(1,2,m)=blam; C_6(1,3,m)=blam; C_6(2,3,m)=blam; 
        C_6(4,4,m)=bmu;  C_6(5,5,m)=bmu;  C_6(6,6,m)=bmu;  
     
      end do   
    
    else ! anisotropic case
    
      read(1,inp_aniso); ! C_6,rho,hs,isym 

    end if ! iso

! output C_6, C_6 --> C_3, zm, xp
 
    zm(1)=0d0
    do m=1,Ms

! isym=0, isotropic layer
      if(isym(m)==0)write(2,10)m,isym(m)
  10    format(' m = ',i2,'  isym = ',i2,', isotropic layer')             
 
! isym=1, cubic symmetry, input: C_11, C_12, C_44
      if(isym(m)==1)write(2,11)m,isym(m)
  11    format(' m = ',i2,'  isym = ',i2,', cubic symmetry')      

! isym=2 - transversally isotropic to z-axis:
!   C_11, C_33, C_13, C_44, C_66 then
!   C_22=C_11,  C_23=C_13,  C_55=C_44, C_12=C_11-2C_66

      if(isym(m)==2) write(2,12)m,isym(m) 
  12    format(' m = ',i2,'  isym = ',i2,', transversally isotropic to z-axis')           

! isym=3 - transversally isotropic to x-axis:
!   C_11, C_22, C_12, C_23, C_55 then
!   C_33=C_22,  C_13=C_12,  C_44=(C_22-C_23)/2
 
        if(isym(m)==3) write(2,112)m,isym(m) 
  112    format(' m = ',i2,'  isym = ',i2,', transversally isotropic to x-axis')           
  
! isym > 3, general orthotropy
      if(isym(m) > 3)write(2,13)m,isym(m)
  13    format(' m = ',i2,'  isym = ',i2,', general orthotropy')      
              
     write(2,77)m,C_6(1,1,m),m,C_6(2,2,m),m,C_6(3,3,m), &
                m,C_6(1,2,m),m,C_6(1,3,m),m,C_6(2,3,m), &
                m,C_6(4,4,m),m,C_6(5,5,m),m,C_6(6,6,m), &
                m,tet(m),m,rho(m),m,hs(m),m,isym(m)

77 format(' C_6(1,1,',i1,')='f10.5,'  C_6(2,2,',i1,')='f10.5, &
                                    '  C_6(3,3,',i1,')='f10.5/ & 
          ' C_6(1,2,',i1,')='f10.5,'  C_6(1,3,',i1,')='f10.5, &
                                    '  C_6(2,3,',i1,')='f10.5/ & 
          ' C_6(4,4,',i1,')='f10.5,'  C_6(5,5,',i1,')='f10.5, &
                                    '  C_6(6,6,',i1,')='f10.5// &          
          ' tet(',i1,')='f10.5,' rho(',i1,')='f10.5,'  hs(',i1,')='f10.5,'  isym('i1,')='i2)

!       write(2,2)C_6(1,1,m),C_6(2,2,m),C_6(3,3,m), &
!                 C_6(1,2,m),C_6(1,3,m),C_6(2,3,m), &
!                 C_6(4,4,m),C_6(5,5,m),C_6(6,6,m),rho(m),hs(m)
! 2    format(' C_11_22_33 = ',3f12.3/ &
!             ' C_12_13_23 = ',3f12.3/ &
!             ' C_44_55_66 = ',3f12.3,'  rho,h= ',2f10.5)             

      C_6(2,1,m)=C_6(1,2,m); C_6(3,1,m)=C_6(1,3,m); C_6(3,2,m)=C_6(2,3,m);

! C_6 --> C_3

      do i=1,3; do j=1,3; do k=1,3; do l=1,3
        if(i == j)then
	      iv = i;   else;   iv = 9-(i+j)
	    end if

        if(k == l)then
	      jv = k;   else;   jv = 9-(k+l)
	    end if

	    C_3(i,j,k,l,m)=C_6(iv,jv,m)
	  end do; end do; end do; end do; 
	  
! C_6 ==> Engineering constants Ex,Ez, etc. 

      call MaterConsts1(m)

! z_m, xp      
      zm(m+1)=zm(m)-hs(m)
       
    end do ! m input
      
    write(2,4)zm(1:Ms+1)
4   format('  zm:',5f10.4/)
                    
! ===================
! inp_work and open files for poles and residues 

    read(1,inp_work) ! gmn,eps,f1,f2,hf, &            ! common input
                     ! key_real,iQ,s1,s2,hpol, &         ! for real roots
                     ! compldzs,Nn1,Nn2,Max,ip,cs0,zh ! for complex roots
      
    write(2,3)gmn,eps,f1,f2,hf; gm = gmn*pi
 3  format(' gamma/pi = ', f10.3,' eps =',d12.3/ & 
           ' f1,f2,hf =',3f12.5/)
 
    if(Mode == 0) then ! RealPoles
     write(2,14)key_real,s1,s2,hpol
14   format(' key_real   = ',i5/ &
            ' s1,s2,hpol = ',3f15.7/)
      
      open(unit=13,file='.\DataFigs\'//'rpoles.dat',status='unknown')
      open(unit=14,file='.\DataFigs\'//'fslown_t.dat',status='unknown')

    end if ! Mode = 0
  
    if((Mode == 1).or.(Mode == 2)) then ! ComplexPoles or ComplRes
      
      write(2,7)Nn1,Nn2,Max,ip
 7    format('  Nn1,Nn2,Max,ip =',4i7)
    
      write(2,8)zh,cs0
 8    format('  zh =',2d15.3/ &
             ' cs0 =',2f15.5)
    
      open(unit=16,file='.\DataFigs\'//'cpoles.dat',status='unknown')
      open(unit=17,file='.\DataFigs\'//'fcs.dat'   ,status='unknown')
    
! check file 17 for complex roots
    
      read(17,*,err=22,end=22); read(17,*,err=22,end=22)
      read(17,*,err=22,end=22); read(17,*,err=22,end=22)
      
  	  read(17,*,err=22,end=22)MMs,iibot
 	  if((MMs.ne.Ms).or.(iibot.ne.ibot))then
 	    write(2,*)'  **** wrong Ms or ibot in file 17; Ms,MMs,ibot,iibot =' &
 	                 ,Ms,MMs,ibot,iibot; stop	   
 	  end if ! MMs
       	  
 	  do m=1,Ms
 	    read(17,*,err=22,end=22)n,CC(1,1),CC(2,2),CC(3,3)
 	    read(17,*,err=22,end=22)  CC(1,2),CC(1,3),CC(2,3)
 	    read(17,*,err=22,end=22)  CC(4,4),CC(5,5),CC(6,6),ttet,rrho,hhs
 
        CC(2,1)=CC(1,2); CC(3,1)=CC(1,3); CC(3,2)=CC(2,3);
	    
 	    err=0d0
 	    do i=1,3; do j=1,3
 	      err = err + abs(CC(i,j)-C_6(i,j,m))
 	    end do; end do ! i,j
   	      
   	    if(err > 1d-4) go to 24;  cycle 
   	       	     	          
 	  end do; go to 25 ! m
 	  
 24  write(2,*)'  *** wrong input constants for file 17'; stop 
	  
! formatting new file 17

22    rewind(17)
      write(17,*)'    Ms, ibot - number of layers and key for the bottom type'
      write(17,*)' m  C_11   C_22   C_33 - 3*Ms lines below'
      write(17,*)'    C_12   C_13   C_23'
      write(17,*)'    C_44   C_55   C_66  tet rho hs,  '
      
      write(17,5)Ms,ibot
 5    format(2i7)
 	  do m=1,Ms
        write(17,6)m,C_6(1,1,m),C_6(2,2,m),C_6(3,3,m), &
                     C_6(1,2,m),C_6(1,3,m),C_6(2,3,m), &
                     C_6(4,4,m),C_6(5,5,m),C_6(6,6,m),tet(m),rho(m),hs(m)
 6      format(i3,2x,3f15.5/5x,3f15.5/5x,3f15.5,3f15.5)	    
 	  end do ! m
 	  
 	  write(17,*)' -1  -1  -1  -1 '
 	  write(17,*)' -1  -1  -1  -1 '

! SortPoles
    
25    if((Mode == 1).and.(Nn1 > 0)) then
	    write(2,32)Nn1,Nn2
32      format('  SortPoles, Nn1,Nn2 =',2i4)		
		call SortPoles; stop
	  end if 	  

    end if ! Mode == 1, ComplPoles; or Mode == 2, ComplRes; 
       
! ===================
! bulk wave velocities and branch points s_i 
!(in the slowness plane s=1/alf)

    mv(1) = cos(gm); mv(2) = sin(gm); mv(3) = 0d0
   
    do m = 1,Ms
      do i=1,3; do l=1,3
        sum = 0d0
        do j=1,3; do k=1,3
          sum = sum + C_3(i,j,k,l,m)*mv(j)*mv(k) 
        end do; end do ! j,k
        Av(i,l) = sum/rho(m)
      end do; end do ! i,l
    
      call EV_evaluate(Av,3,ev,evc)
      rm(1:3) = sqrt(real(ev(1:3)))

! arranging velocities in descent order      
      mask=.true. 
	  do i=1,3	     
        iv = maxloc(rm,1,mask); mask(iv)=.false.
        vb(i)=rm(iv)
      end do
      xp(1:3,m) = 1d0/vb(1:3)          

! body wave slownesses for plots
           
      spm =1d0/sqrt(C_6(1,1,m)/rho(m)); 
 	  ssm1=1d0/sqrt(C_6(4,4,m)/rho(m));   	     
 	  ssm2=1d0/sqrt(C_6(6,6,m)/rho(m));   	     

      write(2,30)m,ev(1:3),vb(1:3),xp(1:3,m),spm,ssm1,ssm2
  30  format(' m,ev_i = ',i3,3(2f12.5)/ &
             '      v_i =  ',3f12.5/ & 
             ' xp=1/v_i =  ',3f12.5/ & 
             ' spm,ssm  =  ',3f12.5/)               	   
    end do ! m
    
    end
