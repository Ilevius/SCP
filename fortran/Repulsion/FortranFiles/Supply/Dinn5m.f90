! Dinn5 -- Программа вычисления N интегралов по полубесконечному контуру 
!          в случае обратной волны (+ Cdinn5, CSimpn5 уже здесь)
!  
!  subroutine СF(u,s,n) - подынтегральные функции; u - аргумент (complex*16),
!                   s(n) - массив значений функций в точке u (complex*16),
!                   n - число интегралов (integer)
! [t1,t2],[t3,t4] - участки отклонения контура вниз (real*8)
!         [t2,t3] - участок отклонения контура вверх (real*8)
! tm,tp > 0 - величины отклонения контура вниз и вверх (real*8)
! (если нет обратной волны, то следует положить t2=t3=t1, tp=0 
!  обход полюсов при этом будет только снизу на участке [t1,t4]
!  с отклонением на tm)
! eps -  отн. погрешность,  pr - начальный шаг, 
! gr - верхний предел (все real*8)
! N- число интегралов (integer) 
! Rd(N) - выход: массив значений интегралов

    subroutine DINN5(CF,t1,t2,t3,t4,tm,tp,eps,pr,gr,N,Rd)
    implicit none
	
	integer N,ib,inf,i

	real*8 t1,t2,t3,t4,tm,tp,eps,pr,gr
	
	complex*16 Rd(N),a,b,sb(N),h

    external CF

    common/simp5/h,ib,inf

! initial constants

    h=pr/4; ib=1; inf=-1
	do i=1,N;  Rd(i)=0;	end do

! [0, t1]
    a=0; b=t1
    call CDINN5(CF,a,b,eps,pr,N,sb,Rd)

	if(t3-t2 < eps)then
! no inverse poles case

! [t1, t1-i*tm]    

	  a=b; b=cmplx(t1,-tm)
      call CDINN5(CF,a,b,eps,pr,N,sb,Rd)

!  [t1-i*tm, t4-i*tm]    

      a=b; b=cmplx(t4,-tm)
      call CDINN5(CF,a,b,eps,pr,N,sb,Rd)

!  [t4-i*tm, t4]    

      a=b; b=t4
      call CDINN5(CF,a,b,eps,pr,N,sb,Rd)

    else
! t2 < t3 - an inverse pole case

      if(t2-t1 > eps)then
! first deviation from below

!   [t1, t1-i*tm]    

	    a=b; b=cmplx(t1,-tm)
        call CDINN5(CF,a,b,eps,pr,N,sb,Rd)

!   [t1-i*tm,t2-i*tm]    

	    a=b; b=cmplx(t2,-tm)
        call CDINN5(CF,a,b,eps,pr,N,sb,Rd)

	  end if ! t2 > t1
! diviation from above

!   [b,t2+i*tp]    

      a=b; b=cmplx(t2,tp)
      call CDINN5(CF,a,b,eps,pr,N,sb,Rd)
	   
!  [t2+i*tp, t3+i*tp]    

      a=b; b=cmplx(t3,tp)
      call CDINN5(CF,a,b,eps,pr,N,sb,Rd)

!  [t3+i*tp, t3-i*tm]    

	  a=b; b=cmplx(t3,-tm)
      call CDINN5(CF,a,b,eps,pr,N,sb,Rd)

! second diviation from below

!  [t3-i*tm, t4-i*tm] 

	  a=b; b=cmplx(t4,-tm)
      call CDINN5(CF,a,b,eps,pr,N,sb,Rd)

!  [t4-i*tm, t4] 

	  a=b; b=t4
      call CDINN5(CF,a,b,eps,pr,N,sb,Rd)

	end if ! t3 > t2

! [t4, inf.] 

	a=b; b=gr; inf=1
    call CDINN5(CF,a,b,eps,pr,N,sb,Rd)

    end
    
!=============================

! Программа счета N интегралов по комплексному отрезку [a,b] 
! в том числе и для полуоси (b = inf.);
! переменный шаг интегрирования в зависимости от быстроты
! получения требуемой точности на каждом предыдущем шаге 
! (считает CSIMPN5) 

	subroutine CDINN5(CF,a,b,eps,pr,N,sb,rd)
    implicit none

	integer N,ib,inf,ipr,i,it
	
	real*8 eps,pr,f(N),t,t1,t2,eps10,th,pm,pt

	complex*16 a,b,rd(N),r(N),h,sb(N),h1,a1,b1,s1

    common/simp5/h,ib,inf

	external CF

! initial constants

    ipr=0; t=abs(b-a); t2=(1-1d-12)*t
    eps10=10*eps;      if(t < 1d-13)return

    s1=(b-a)/t; h1=s1*pr; 

! beginning of integration
	
	b1=a; it=1

 	do while(it > 0)
	  a1=b1;  b1=b1+h1;  t1=abs(b1-a)
	  if(t1 > t)then
	    b1=b; it=-1
	  end if

      call CSIMPN5(CF,a1,b1,eps,N,sb,R); ib=-1

! for cheking-up the convergence at infinity

      if(inf > 0)then
	    th=abs(b1-a1)
		do i=1,N
		  f(i)=abs(r(i))/th
		end do
	  end if ! inf > 0

! summing

      do i=1,N
        rd(i)=rd(i)+r(i)
	  end do

      if(abs(h1) < 10*abs(h)) then
	    h1=4*h1;  else;   h1=4*h
	  end if

! at infinity

      if(inf > 0)then
	    pm=0
        do i=1,N
          if(abs(rd(i)) > 1d-15)then
		    pt=abs(f(i)*t1/rd(i))
		    if(pt > pm) pm=pt
		  end if
	    end do

        if(pm < eps10)then
          ipr=ipr+1
		  if(ipr > 4)return
		else
		  ipr=0
	    end if ! pm < eps10
	  end if ! inf >0

    end do ! while(it > 0)

    end

!===================================

! Программа счета N интегралов методом Симпсона 
! по комплексному отрезку [a,b] 

! Вход:
!  subroutine СF(u,s,N) - подынтегральные функции: 
!         u - аргумент (complex*16),
!         s(N) - массив значений функций в точке u (complex*16),
!         N - число интегралов (integer);
! eps -  отн. погрешность, real*8
! N- число интегралов (integer) 

! Bыход:
! R(N) -  массив значений интегралов
 
    subroutine CSIMPN5(CF,a,b,eps,N,sb,R)
    implicit none
    
	integer N,Nh,i,k,ib,inf
	
	real*8 eps,pm,t

	complex*16 a,b,R(N),s(N),s1(N),s2(N),s3(N), &
	           h,h1,h3,h43,sb(N),ri,u

    common/simp5/h,ib,inf
	 
! first step

    h=(b-a)/2; h3=h/3; h43=4*h3; Nh=1
    
	if(ib > 0)then
	  call CF(a,s1,N)
    else
	  do i=1,N
	    s1(i)=sb(i)
      end do
	end if ! ib

	call CF(b  ,sb,N)
	call CF(a+h,s3,N)

	do i=1,N
	  s1(i)=(s1(i)+sb(i))*h3
	  s2(i)=0
	  s3(i)=s3(i)*h43
	end do ! i

! next steps

 1  h1=h; h=h/2; h43=4*h/3; Nh=2*Nh; u=a+h

	do i=1,N
	  s1(i)=s1(i)/2
	  s2(i)=s2(i)/2+s3(i)/4
	  s3(i)=0
	end do ! i

    do k=1,Nh
	  call CF(u,s,N)
	  
	  do i=1,N
	    s3(i)=s3(i)+s(i)*h43
	  end do ! i

	  u=u+h1
	end do ! k

	pm=0
    do i=1,N
	  ri=s1(i)+s2(i)+s3(i)
      if(abs(ri) > 1d-12)then
	    t=abs((ri-R(i))/ri)
		if(t > pm) pm=t
	  end if ! ri > 1d-12
	  R(i)=ri   
	end do ! i

! accuracy control

    if((pm < eps))return
	if(abs(h) > eps) go to 1

    end
