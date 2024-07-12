
      SUBROUTINE CMPMY1(Z,IZ,A,N1,B,M1)
      implicit real*8(a-h,o-z)
      COMPLEX*16 Z(1),A(1),B(1),S
      IZ=N1+M1-1
      DO 1 K=1,IZ
      K1=K+1
      S=(0D0,0D0)
      DO 2 I=1,K
      J=K1-I
      IF(I.GT.N1) GO TO 2
      IF(J.GT.M1) GO TO 2
      S=S+A(I)*B(J)
    2 CONTINUE
    1 Z(K)=S
      RETURN
      END
