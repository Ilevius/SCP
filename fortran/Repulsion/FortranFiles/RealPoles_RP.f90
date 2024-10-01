! Real poles for Repulsion (over slowness)

    subroutine RealPoles_RP
	use Mult_Glob; use SDC_globals; implicit none

	integer Ndz,Ndzm,Ndj,maxN,j,Nj,jn,n,m,nt,nf,Nft,&
	        jt,it,Nbr,i,jni,ift,key_real,iQ,MMs 
	
	parameter(Ndzm=50); !	integer Njn(Ndzm)
	
	real*8  s1,s2,hpol,pols(Ndzm),zeta(Ndzm),dzt, &
	        vs,kap2,hres,ht,absr1,absr3,rs,gm,RDabs,RDabs_alf, &
	        ft1,ft2,st1,st2,st,rt1,rt2,rt3,rt,rt_inf, &
            pm,sm1,sm2,frt,rst1,rst3, &
            r11,i11,r31,i31,r13,i13,r33,i33, & 
            Re1(Ndzm),Im1(Ndzm),Re3(Ndzm),Im3(Ndzm)

	complex(8) res11(Ndzm),res31(Ndzm),res13(Ndzm),res33(Ndzm), &
	           RDs,cdt,cr,cr11,cr31,cr13,cr33,alf
	
	real(8), allocatable:: ft(:),ff(:,:),slown(:,:),slf(:,:),resn1(:,:), &
	              resn3(:,:),rsf1(:,:),rsf3(:,:),spm(:),ssm1(:),ssm2(:)
	                  
    common/slown/rs/gm/gm/realroots/s1,s2,hpol,key_real,iQ

	external RDabs,RDabs_alf
    
! constants

    key = 1; vs = sqrt(C_6(6,6,1)/rho(1)) ! key for MultiK_An 
    rt_inf = 2*(abs(f2-f1)+abs(s2-s1));   ! max distance in (f,s)
                                          ! hf20 = 20*hf;    
! allocation 

    Ndj =(f2 - f1)/hf + 100
    allocate(ft(Ndj),slown(Ndj,Ndzm),resn1(Ndj,Ndzm),resn3(Ndj,Ndzm)); 
             ft = -1d0; slown = -1d0;   
    allocate(ff(20*Ndj,Ndzm),   slf(20*Ndj,Ndzm), &
             rsf1(20*Ndj,Ndzm),rsf3(20*Ndj,Ndzm)); 
             ff = -1d0;      slf = -1d0
    allocate(spm(Ms),ssm1(Ms),ssm2(Ms))
    
! body wave slownesses   
    do m=1,Ms
      spm(m) =1d0/sqrt(C_6(1,1,m)/rho(m)); 
 	  ssm1(m)=1d0/sqrt(C_6(4,4,m)/rho(m));   	     
 	  ssm2(m)=1d0/sqrt(C_6(6,6,m)/rho(m));      
    end do
   
    if (key_real == -2)go to 7 ! to Residues 

!  search for slowness roots 

! starting file 13 'rpoles.dat'
 
      write(13,*)Ms
      do m=1,Ms
   	    write(13,27)spm(m),ssm1(m),ssm2(m)
  27    format(3f15.7)     
      end do ! m
      
! cycle f
      
      !call plotAllcurves
      !call simpleDcurves
  
      maxN=0; jn=0         
      do f=f1,f2*1.00001,hf
    
        jn = jn+1; ft(jn) = f; 
      
        w = 2d0*pi*f; kap2=w*hs(1)/vs;  
        write(2,5) f,w;  print 5, f
 5      format(/' f,w =',2f15.7)            

!        if (w > 2d0)then
        if (kap2 > 2d0)then
          call Hamin(RDabs,s1,s2,hpol,eps,Ndzm,pols,Ndz)
        else
!          call Hamin(RDabs_alf,w*s1,w*s2+1d0,hpol,eps,Ndzm,pols,Ndz)
          call Hamin(RDabs_alf,w*s1,w*s2,hpol,eps,Ndzm,pols,Ndz)
          pols(1:Ndz) = pols(1:Ndz)/w                 
        end if
 
 	    write(13,20)f,kap2,Ndz,(pols(n),n=1,Ndz)
 20     format(f20.10,f12.4,i5,50f20.10)
 
        do n=1,Ndz; 
          ft(jn)=f; slown(jn,n)=pols(n); 
        end do 
           
	    write(2,25)Ndz,(slown(jn,n),n=1,Ndz)
 	    print   25,Ndz,(slown(jn,n),n=1,Ndz)
 25     format(' Ndz =',i5,5f11.5/20(6f11.5/))
 
        if(Ndz > maxN)maxN = Ndz
        
      end do ! f, rpolse   
      Nft = jn
    
!    end if ! key_real >=0
    write(13,*)' -1  -1  -1  -1'; write(13,*)' -1  -1  -1  -1'   

    if(key_real==0)return
    
!  =============================      

! if key_real < 0
! take 'ft' and 'slown' from file 13 
    if(key_real < 0)then
           
      rewind(13); read(13,*,err=21,end=21) MMs

! check file header
      if(MMs.ne.Ms)go to 21

      do m=1,Ms
      	read(13,*,err=21,end=21)pm,sm1,sm2
        if(abs(pm-spm(m))+abs(sm1-ssm1(m))+abs(sm2-ssm2(m))< 1d-6)cycle     
        go to 21
      end do ! m
      go to 22
      
 21   write(2,*)' *** inappropriate header data in file 13 "rpoles"'; stop       

! take data from file 13 'rpoles.dat'     
 
 22   maxN = 0; jn = 0; f = 1d0
 
      do while (f > 0)
 
  	    read(13,*)f,kap2,Ndz,(pols(n),n=1,Ndz);	    
  	    if(f < 0)exit; if(Ndz <=0)cycle
  	                  
        jn = jn+1; 
        ft(jn) = f; slown(jn,1:Ndz)=pols(1:Ndz)
  	               
        if(Ndz > maxN)maxN = Ndz

      end do ! while f > 0
      Nft = jn
      
    end if ! key_real < 0

!  =============================      

! point distribution among the branches

    do nf = 1,Ndzm  ! nf - branch number
          
      rt2 = rt_inf; 
      it = 0; jn = 0  ! it is a counter for points in the current branch No nf                    
      
      do while (jn < Ndj)  ! jn is the No of current frequency ft(jn) 
        jn = jn+1;  
       
        jt = -1;  rt1 = rt_inf; 
        do i = 0,2
          jni = jn-i
          if(jni < 1)cycle
          f = ft(jni); if(f < 0)cycle; 
                     
          ift = -1         ! if ift becomes > 0 - ft(jni) is still actual
          do n = 1,maxN          
            st2 = slown(jni,n); if(st2 < 0)cycle;             
            ift = 1
            
            if(it == 0)then
 ! first point of the branch 
              it = it+1;
              ff(it,nf) = f; slf(it,nf) = st2; slown(jni,n)= -1d0
              ft1       = f; st1        = st2;  
              go to 10   
            
            else ! it > 0
              rt = abs(ft1-f)+abs(st1-st2)
              if(rt < rt1)then
                rt1 = rt; ft2 = f 
                jt = jni; nt = n  ! nt - No n for a current candidate point 
              end if                                                    
            end if ! it = 1
          
          end do ! n
          
          if(ift < 0)then
            ft(jni) = -1d0
          end if ! ift < 0
                  
        end do ! i
        
        if(rt1 > 20d0*rt2)exit
        
        if(jt < 0)then; 
          cycle;
        else
          it = it+1;  jn = jt
          ff(it,nf) = ft2;  slf(it,nf) = slown(jt,nt)
          rt2 = rt1;       
          ft1 = ft2; st1 = slown(jt,nt); slown(jt,nt)= -1d0 
           
          if(ft2 > f2-hf) exit      
        end if
             
  10  end do ! jn
  
      ift = -1
      do jt =1,Ndj
        if (ft(jt)>0) then
          ift = 1; exit
        end if
      end do ! jt
      
      if(ift < 0)exit ! nf
      
12  end do ! nf
    
    Nbr = nf
    
! ------------------------------------
! rpolse --> fslown_t
! write branches into file 14 'fslown_t.dat'
  
    rewind(14); 
    write (14,*)'   Ms / spm,ssm1,ssm2 / n & / f s' ! K11 K31 K13 K33'
      
    write(14,*)Ms
    do m=1,Ms; 
      write(14,27)spm(m),ssm1(m),ssm2(m)
    end do
      
    nf = 0
    do n = 1,Nbr
      
      do j= 1,Ndj
        
        ft(j) = ff(j,n); Nj = j 
        if(ft(j)<0d0)then
            Nj = j-1; exit
        end if
        
      end do ! j 
      
      if(Nj > 0)then
        
        nf = nf+1; write(14,*)nf,'  &'
        
        do j = 1,Nj
          write(14,3)ff(j,n),slf(j,n)
  3       format(f15.8,f20.10,4(2x,2f20.10))        
        end do ! j
        write(14,*)'   -1   -1   -1   -1'
        
      end if ! Nj > 0
      
    end do ! n 
    write(14,*)'   -1   -1   -1   -1'; rewind(14)    

! =============================      

                                                                ! Residues

! file 25 'temp.dat' for addimg residues into 'fslown_t.dat'
 
7   open(unit=15,file='.\DataFigs\'//'temp.dat',status='unknown')   
 
    rewind(14); read (14,*); read (14,*,err=35,end=35)Ms
    rewind(15); write(15,*)Ms
!    write (25,*)'   Ms / spm,ssm1,ssm2 / n & / f s K11 K31 K13 K33'

    do m=1,Ms; 
      read (14,*,err=35,end=35)spm(m),ssm1(m),ssm2(m)
      write(15,27)             spm(m),ssm1(m),ssm2(m)
    end do
      
    read (14,*,err=35,end=35)n

    do while(n > 0)
          write(15,36)n
    36    format(i12,'   &')
         
          read (14,*,err=35,end=35)f,st; w = 2d0*pi*f;      
      
          do while (f > 0)
                ! residues K11, K31, K13, K33

                hres = 1d3*eps; dzt = w*st 
                if((dzt-hres) < 0d0) hres = dzt-eps
   
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
           
                write(15,3)f,st,cr11,cr31,cr13,cr33
                    
                read (14,*,err=35,end=35)f,st; w = 2d0*pi*f;
          end do ! while (f > 0)
      
          write(15,*)' -1  -1  -1  -1  -1  -1  -1  -1  -1  -1 '

          read (14,*,err=35,end=35)n         
    end do !while (n > 0)
    
    
    
    call setResEnv
    eps = 1d-6;
    do i = 1, freqsNum
        w = 2d0*pi*freqs(i)
        hres = 1d3*eps; dzt = dzetas(i) 
        if((dzt-hres) < 0d0) hres = dzt-eps
   
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
        
        write(resFileNo, '(7E15.6E3)') freqs(i), dzetas(i), abs(cr11), abs(cr13), abs(cr31), abs(cr33)
    enddo
    
    write(15,*)' -1  -1  -1  -1  -1  -1  -1  -1  -1  -1 '  

! temp.dat --> fslown_t

    rewind(15); rewind(14); 
    write (14,*)'   Ms / spm,ssm1,ssm2 / n & / f s K11 K31 K13 K33'
    
    read (15,*,err=35,end=35)Ms
    write(14,*)Ms

    do m=1,Ms; 
      read (15,*,err=35,end=35)spm(m),ssm1(m),ssm2(m)
      write(14,27)             spm(m),ssm1(m),ssm2(m)
    end do
      
    read (15,*,err=35,end=35)n

    do while(n > 0)
      write(14,36)n
         
      read (15,*,err=35,end=35)f,st,r11,i11,r31,i31,r13,i13,r33,i33    
      do while (f > 0)
                  
        write(14,3)f,st,r11,i11,r31,i31,r13,i13,r33,i33
                    
        read (15,*,err=35,end=35)f,st,r11,i11,r31,i31,r13,i13,r33,i33; 
        
      end do ! while (f > 0)
      write(14,*)' -1  -1  -1  -1  -1  -1  -1  -1  -1  -1 '

      read (15,*,err=35,end=35)n         
              
    end do !while (n > 0)

    write(14,*)' -1  -1  -1  -1  -1  -1  -1  -1  -1  -1 '   
    return 

 35 write(2,*)' *** wrong file 14 "fslown_t" ***'     
    stop

  end ! RealPoles_RP
