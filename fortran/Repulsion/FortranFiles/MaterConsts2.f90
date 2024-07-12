! Calculation of elastic modulii C_ijkl
! from engineering constants Ex,Ez, etc. ==> C_6, C_3
 
    subroutine MaterConsts2(m)
    use PropRest2_Glob; use Mult_Glob; implicit none
    
    integer i,j,k,l,m,iv,jv,iCS
 
    real(8) aC1(3,3),aC2(4:6),aS1(3,3),aS2(4:6), &
            E,v,lb,mb,lb2m
 
    complex(8) C1(3,3),S1(3,3),rb1(3,3),rb2(3,6)

! current layer number 'm'

! ism < 0 - no change, keeps initial data  
      if(ism(m) < 0)return 
        
! ism = 0 - isotropic
!       1 - cubic
!       2 - transversal isotropic to z-axis

      if(ism(m) == 2)then   

! S -> C           
        aS1(1,1)= 1d0/Ex(m); aS1(1,2)= -nux(m)/Ex(m);  aS1(1,3)= -nuz(m)/Ez(m);
        aS1(2,1)= aS1(1,2);  aS1(2,2)= aS1(1,1);       aS1(2,3)= aS1(1,3);
        aS1(3,1)= aS1(1,3);  aS1(3,2)= aS1(2,3);       aS1(3,3)= 1d0/Ez(m)
      
        aS2(4)= 1d0/muz(m); aS2(5)= aS2(4); aS2(6)= 2d0*(1d0+nux(m))/Ex(m)
             
        S1 = aS1; 
        C1 = 0d0; C1(1,1)=1d0; C1(2,2)=1d0; C1(3,3)=1d0;
    
        call STAR5(S1,C1,rb1,rb2,3,3,3,2); aC1 = real(C1);
    
        C_6(1:3,1:3,m) = aC1(1:3,1:3)
        do i=4,6; C_6(i,i,m)= 1d0/aS2(i); end do
      
      end if ! ism = 2
      
      if((ism(m)==0).or.(ism(m)==1))then
        E = Ez(m); v = nuz(m)
        if(ism(m)==0)then
          mb = E/(2d0*(1d0+v))
        else
          mb = muz(m)
        end if ! bm
      
        lb  = v*E/((1d0+v)*(1d0-2d0*v));
        lb2m = lb + 2d0*mb

        aC1(1,1) = lb2m; aC1(2,2) = aC1(1,1); aC1(3,3) = aC1(1,1);
        aC1(1,2) = lb;  aC1(1,3) = aC1(1,2); aC1(2,3) = aC1(1,2);
        
        aC1(2,1) = aC1(1,2); aC1(3,1) = aC1(1,3); aC1(3,2) = aC1(2,3);

        C_6(1:3,1:3,m) = aC1(1:3,1:3)
               
        do i=4,6; C_6(i,i,m)= mb; end do
      
      end if ! ism = 0 or 1 
      
 ! C_6 --> C_3
      
        do i=1,3; do j=1,3; do k=1,3; do l=1,3
          if(i == j)then
	        iv = i;   else;   iv = 9-(i+j)
	      end if

          if(k == l)then
	        jv = k;   else;   jv = 9-(k+l)
	      end if

	      C_3(i,j,k,l,m)=C_6(iv,jv,m)
	    end do; end do; end do; end do

! rho, hs	     
	  
	   rho(m)= rhot(m); hs(m)= hst(m) 
	       
    end ! MaterConsts2