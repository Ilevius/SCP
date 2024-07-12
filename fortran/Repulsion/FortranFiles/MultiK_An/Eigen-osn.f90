! Anly: eigenvalues 'sgm(3,Ms)' and eigenvectors 'Mm(3,6,Ms)' 
!       for all 'Ms' layers

    subroutine Eigen(alf)
    use Mult_Glob;  implicit none
    
	logical  mask(3)

    integer i,j,k,l,m,n,kp,km,im,ind(3)

    real(8) rom2,Rez(6),Imz(6),as(3),vp,vs,xp1,xp2,rsp(3),isp(3)

	complex(8) alf,B0(3,3),B1(3,3),B2(3,3),A(6,6),A0(3,3),A1(3,3), &
	           C(3,3),rb1(3,3),rb2(3,6),Pm(3,3),vm(3),vn(3), &
	           eval(6),evec(6,6),sg1,sg2,sum,sg_p(3),sg_m(3), &
	           m_p(3,3),m_m(3,3),sg_pr(3),sg_pi(3),m_pr(3,3),m_pi(3,3)
    
! cycle by m for Ms layers

    do m=1,Ms      
! B_0        
        B0(1:3,1:3) = C_3(1:3,1,1:3,1,m)*al(1)*al(1)+ &    
                      C_3(1:3,1,1:3,2,m)*al(1)*al(2)+ &     
                      C_3(1:3,2,1:3,1,m)*al(2)*al(1)+ &     
                      C_3(1:3,2,1:3,2,m)*al(2)*al(2)  
      
        rom2=rho(m)*w*w   ! frequency
	    do i=1,3; 
	      B0(i,i)=B0(i,i)-rom2;
	      if(abs(B0(i,i)) < 1d-12)B0(i,i)=1d-12 
	    end do
  
! B1
        B1(1:3,1:3) = C_3(1:3,3,1:3,1,m)*al(1)+ &    
                      C_3(1:3,3,1:3,2,m)*al(2)+ &     
                      C_3(1:3,1,1:3,3,m)*al(1)+ &     
                      C_3(1:3,2,1:3,3,m)*al(2)   
! B2
        B2(1:3,1:3) = C_3(1:3,3,1:3,3,m)

! matrix A; C=inv(B2)

        C=0; do i=1,3; C(i,i)=(1d0,0d0); end do
        call STAR5(B2,C,rb1,rb2,3,3,3,2)
    
        A0 = MatMul(C,B0); A1 = cci*MatMul(C,B1);
      
        A(1:3,1:6)=0d0;  A(1,4)=1d0;   A(2,5)=1d0;   A(3,6)=1d0;
	    A(4:6,1:3)=A0;   A(4:6,4:6)=A1;

! eigenproblem by LAPAC; root selection and sorting

	    call EV_evaluate(A,6,eval,evec); Rez=real(eval); Imz=imag(eval)

!    write(2,*)' eval'
!    write(2,7)eval
 
!    write(2,*)' evec(:,1:3)/evec(:,4:6)'
!    write(2,17)((evec(i,j),j=1,3),i=1,3)
!    write(2,17)((evec(i,j),j=4,6),i=1,3)
17  format(3(3(2f12.4,2x)/))  	
   	
        kp=0; km=0
        do i=1,6  
	      if(    (Rez(i)  > 1d-10).or.  &
	        ((abs(Rez(i)) < 1d-10).and.(Imz(i) < 0d0))) then
	 	      kp=kp+1 
		      sg_p(kp)=eval(i); m_p(1:3,kp)=evec(1:3,i)
	      end if
		
	      if(    (Rez(i)  <-1d-10).or.  &
	        ((abs(Rez(i)) < 1d-10).and.(Imz(i) >= 0d0))) then
		      km=km+1 
		      sg_m(km)=eval(i); m_m(1:3,km)=evec(1:3,i)
	      end if
	    end do

	    if((kp /= 3).or.(km /= 3))then ! wrong egenvalues
	      write(2,*)' *** kp,km,al=',kp,km,al; stop	    
	    end if
 
!    write(2,*)' sg_p/sg_m'
!    write(2,7)sg_p(1:3),sg_m(1:3)

!    write(2,*)'    m_p '
!    write(2,17)((m_p(i,j),j=1,3),i=1,3)
              
!    write(2,*)'    m_m '
!    write(2,17)((m_m(i,j),j=1,3),i=1,3)
                     
! positive sigmas and the corresponding eigenvectors
	
	  sgm(1:3,m) = sg_p(1:3); Mm (1:3,1:3,m)=m_p(1:3,1:3);  

! negative counterparts
	
	    mask=.true. 
	    do i=1,3
	      as(1:3)=abs(sg_p(i)+sg_m(1:3))
          im = minloc(as,1,mask); mask(im)=.false.
          sgm(i+3,m)= sg_m(im); Mm(1:3,i+3,m)=m_m(1:3,im)
        end do

! Cut selection       

        if((ibot == 0).and.(m == Ms))then
 
!   write(2,*)' ibot =',ibot
!   write(2,*)'   sgm(1:3,Ms) '
!   write(2,7)sgm(1:3,Ms)

!   write(2,*)'   Mm(:,1:3,Ms) '
!   write(2,17)((Mm(i,j,Ms),j=1,3),i=1,3)
                    
          call CutSelect(alf)

 !         write(2,*)' sgm rearranged'
 !         write(2,7)sgm(1:3,Ms)
   7      format(2(3(2f12.4,2x)/))

!   write(2,*)'   Mm(:,1:3,Ms) rearranged '
!   write(2,17)((Mm(i,j,Ms),j=1,3),i=1,3)
             
        end  if ! cut 
      
! Matrices N_m for stresses

      do im = 1,6   ! m -- column number in Mm  
        al(3) = cci*sgm(im,m)
        vm(1:3) = Mm(1:3,im,m)
      
  ! Matrix Pm = [p_ij]
        do i=1,3; do j=1,3
          sum = 0d0 
          do n=1,3
            sum = sum + C_3(i,3,j,n,m)*al(n)
          end do ! n 
          Pm(i,j) = sum 
        end do; end do ! i,j
      
        vn = Matmul(Pm,vm)
        Nm(:,im,m) = -cci*vn(:)        
      end do ! im

! exponents em(j,m) = exp(-sgm_j*hs_m)

      em(1:3,m) = exp(-sgm(1:3,m)*hs(m))
      
    end do ! m

    end
