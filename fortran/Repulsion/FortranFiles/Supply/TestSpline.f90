! Test of Cubic_splines:
!   subroutine spline (x, y, b, c, d, n)
!   Calculate the coefficients b(i), c(i), and d(i), i=1,2,...,n
!   for cubic spline interpolation
!   s(x) = y(i) + b(i)*(x-x(i)) + c(i)*(x-x(i))**2 + d(i)*(x-x(i))**3
!   for  x(i) <= x <= x(i+1)
    
    Subroutine TestSpline
    implicit none
    
    integer i,j,n,N1 
    real(8) x(10),y(10),b(10),c(10),d(10),xt,yt,ys,w(10) 
    complex(8) F(10),A(10),ct,cvalp

    n = 4; N1=n+1

! points    
    x(1) = 0d0;  x(2) = 0.15; x(3) = 0.25; x(4) = 0.5  
    do i = 1,n
!      y(i) = x(i) - x(i)**2 + 2*x(i)**3 
       y(i) = sin(x(i)); F(i)=y(i)
    end do
    
    w(1:n)=x(1:n); ! x(1:n-1) = x(2:n)

! coefficients    
    call spline(x, y, b, c, d, n)
    
    call CMPLAG1(F,n,A,W)
    
! extrapolation

    do j = 1,20
      xt = x(n) + 0.1*(j-1); ct = xt
!      yt = xt - xt**2 + 2*xt**3
       
      yt = sin(xt)

      ys = y(n)+b(n)*(xt-x(n))+c(n)*(xt-x(n))**2+d(n)*(xt-x(n))**3 
      
      ct = cvalp(ct,A,n-1)
      
      write(2,1)xt,yt,ys,ct
  1   format(' x,y, ys, ct =',2f12.3,2x,f12.6,2x,2f12.6)    
            
    end do  
    
    end