! Anly: Green's matrix T(al,z) for stresses at horizontal
!       surface elements: tau = (tau_xz,tau_yz,sigma_zz) as columns 

    subroutine Green_T(z)
    use Mult_Glob;  implicit none
    
    integer j,m,mt
    
    real(8) z,zmt,zmt1
    
    complex(8) ex(6),rN(3,6),rt(6,3)
	
! layer borders 

     zm(1)=0d0
     do m=1,Ms; zm(m+1)=zm(m)-hs(m); end do

! selecting the number of the current sublayer 
   
    do m=1,Ms  ! do while (z.ge.zm(m+1))
      mt = m; if(z.ge.zm(m+1))exit   
    end do

! exp
    zmt  = z-zm(mt);   ex(1:3)=exp( sgm(1:3,mt)*zmt )            
    zmt1 = z-zm(mt+1); ex(4:6)=exp(-sgm(1:3,mt)*zmt1)

! Mm*exp   
    do j=1,6
      rN(:,j) = Nm(:,j,mt)*ex(j)
    end do

! t_m    
    rt(:,:) = tm(:,:,mt)

! T(al,z) -- 3x3 matrix
    
    Taz = MatMul(rN,rt)
    
    end
