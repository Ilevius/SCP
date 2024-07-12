! Anly: Green's matrix K(al(1),al(2),z,f)
! output: Kaz - 3x3 

    subroutine Green_K(z)
    use Mult_Glob;  implicit none
    
    integer j,m,mt
    
    real(8) z,zmt,zmt1
    
    complex(8) ex(6),rM(3,6),rt(6,3)
	
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
      rM(:,j) = Mm(:,j,mt)*ex(j)
    end do

! t_m    
    rt(:,:) = tm(:,:,mt)

! K(al,z) -- 3x3 matrix
    
    Kaz = MatMul(rM,rt)
    
    end
