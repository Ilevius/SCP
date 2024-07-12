! Computes polynomial coefficients A(N1) (ascending powers)
! for a given set of values F(i) at the nodes w(i), i=1,N1 
 
        SUBROUTINE CMPLAG1(F,N1,A,W)
        implicit real*8(a-h,o-z)
        COMPLEX*16 F(n1),A(N1),X(51),Y(2),Z(51),WK,ZN,F1
        DIMENSION w(n1)
        
        n=n1-1

        DO 11 J=1,N1
 11       A(J)=0D0
      
        DO 1 K=1,N1
          WK=W(K)
          IX=2
          IY=2
          Y(2)=1D0
          X(2)=1D0
  
          IF(K.GT.1) GO TO 3
            X(1)=-W(2)
            Y(1)=-W(3)
            J1=4
          GO TO 5

 3        IF(K.NE.2) GO TO 4
            X(1)=-W(1)
            Y(1)=-W(3)
            J1=4
          GO TO 5

 4        X(1)=-W(1)
          Y(1)=-W(2)
          J1=3

 5        ZN=(WK+X(1))*(WK+Y(1))
          CALL CMPMY1(Z,IZ,X,IX,Y,IY)

          DO 7 I=J1,N1
            IF(I.EQ.K) GO TO 7
            DO 9 J=1,IZ
 9            X(J)=Z(J)

            IX=IZ
            Y(1)=-W(I)

            CALL CMPMY1(Z,IZ,X,IX,Y,IY)

            ZN=ZN*(WK-W(I))
 7        CONTINUE

          F1=F(K)
          DO 10 J=1,IZ
 10         Z(J)=Z(J)*F1/ZN
        
          DO 12 J=1,N1
 12         A(J)=A(J)+Z(J)

 1      CONTINUE
   
        RETURN
        END
