        !COMPILER-GENERATED INTERFACE MODULE: Thu Sep 26 11:40:14 2024
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE ZGERC__genmod
          INTERFACE 
            SUBROUTINE ZGERC(M,N,ALPHA,X,INCX,Y,INCY,A,LDA)
              INTEGER(KIND=4) :: LDA
              INTEGER(KIND=4) :: M
              INTEGER(KIND=4) :: N
              COMPLEX(KIND=8) :: ALPHA
              COMPLEX(KIND=8) :: X(*)
              INTEGER(KIND=4) :: INCX
              COMPLEX(KIND=8) :: Y(*)
              INTEGER(KIND=4) :: INCY
              COMPLEX(KIND=8) :: A(LDA,*)
            END SUBROUTINE ZGERC
          END INTERFACE 
        END MODULE ZGERC__genmod
