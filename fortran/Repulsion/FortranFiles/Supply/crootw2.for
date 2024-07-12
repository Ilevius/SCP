! ѕодпрограмма поиска комплексных корней уравнени€ 
! f(z)=0 в окрестности заданного начального значени€ y
! ¬ход:
! y - начальное значение (complex*16)
! dz - начальный шаг поиска (complex*16)
! epz - требуема€ точность (real*8)
! max - максимально допустимое число итераций (integer)
!       (~ 30 - 50) 
! ip - код печати 
!      ip >= 0 - все промежуточные печати 
!                (описать файл дл€ устройства печати 2)
!      ip < -5 - без печатей
! f - им€ функции f(z): complex*16 function F(z)
!                    z - аргумент, copmlex*16
!
! ¬ыход:
! у - полученный корень
	
	SUBROUTINE CROOTW2(Y,DZ,EPZ,MAX,IP,F)
      IMPLICIT REAL*8(A-H,O-Z)
      COMPLEX*16 Z(3),DZ,F,ZN(3),FZ(3),C,A1,A2,A3,
     *Y1,Y2,Y,FN(3)

      Z(1)=Y
      Z(2)=Y+DZ
      Z(3)=Y-DZ

      iep=0
      tmax=0d0
      kmax=1
      DO 1 K=1,3
        FZ(K)=F(Z(K))
        T=ABS(FZ(K))
        if(t.gt.tmax)then
          tmax=t
          kmax=k
        end if
        
        IF(IP.LT.0) GOTO 1
          PRINT 18,K,Z(K),fz(k),t
 18       FORMAT('     z,f(z)=',I4,2D12.5,2x,2d11.4,1x,d9.2)
          WRITE(2,18) K,z(k),fz(k)
  1   CONTINUE
  
      do k=1,3
        fz(k)=fz(k)/tmax
      end do
  
      DO 14 I=1,MAX
        A1=(0D0,0d0)
  
  9     DO 2 M=1,3
          C=(1D0,0d0)
          DO 3 K=1,3
            IF(K.EQ.M)GOTO 3
            C=C*(Z(M)-Z(K))
  3       CONTINUE
      
          ZN(M)=C
          FN(M)=FZ(M)/C
  2     A1=A1+FN(M)

c tm - minimal fz(k), km - its number
      
        tm=abs(fz(1))
        km=1
        do k=2,3
          t=abs(fz(k))
          if(t.gt.tm)go to 55
            km=k
            tm=t
 55     end do
             
        A2=-((Z(2)+Z(3))*FN(1)+(Z(1)+Z(3))*FN(2)+
     *(Z(1)+Z(2))*FN(3))
        A3=Z(2)*Z(3)*FN(1)+Z(1)*Z(3)*FN(2)+Z(1)*Z(2)*FN(3)
        
        IF(ABS(A1).LT.1D-30) GOTO 16
        A2=A2/A1
        A3=A3/A1
        C=SQRT(A2*A2-4D0*A3)
        Y1=(-A2+C)*0.5D0
        Y2=(-A2-C)*0.5D0
        GO TO 17
 
 16     Y1=-a3/a2
        Y2=Y1
        
 17     R1=abs(y1-z(km))
        R2=abs(y2-z(km))
        
        IF(R1.le.R2)then
          Y=Y1
        else
          Y=Y2
        end if
  
  7     C=F(Y)/tmax
        T=ABS(C)
        IF(IP.GE.0) write(2,15)I,Y,c,t
        IF(IP.GE.0) print 15, I,Y,c,t
        IF(DMIN1(R1,R2).LE.EPZ)then
          iep=iep+1
        else
          iep=0
        end if
        if(iep.ge.2)GOTO 11

        KN=1
        kmin=1
        fzmax=abs(fz(1))
        fzmin=fzmax        
        DO 12 K=2,3  
          fzk=abs(fz(k))
          IF(fzk.LT.fzmax)GO TO 37
            fzmax=fzk
            KN=K                    
 37       if(fzk.gt.fzmin)go to 12
            fzmin=fzk
            kmin=k        
 12     CONTINUE

        if(t.gt.fzmax)then
          y=z(kmin)+(y-z(kmin))*fzmin/(fzmin+t)
          if(abs(y-z(kmin)).gt.epz/10d0) go to 7
        end if
        
        Z(KN)=Y
        FZ(KN)=C
 14    CONTINUE
       
       if(ip.gt.-6)write(2,20) max,y,c
 20    format('  crootb max=',i5,' z,f=',2(2d10.4,2x))
 15    FORMAT(' i=',i3,' z,f=',2D12.5,2x,3d9.2)
 11   RETURN
      END
