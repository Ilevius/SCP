        !COMPILER-GENERATED INTERFACE MODULE: Thu Sep 26 11:40:08 2024
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE SPLINE__genmod
          INTERFACE 
            SUBROUTINE SPLINE(X,Y,B,C,D,N)
              INTEGER(KIND=4) :: N
              REAL(KIND=8) :: X(N)
              REAL(KIND=8) :: Y(N)
              REAL(KIND=8) :: B(N)
              REAL(KIND=8) :: C(N)
              REAL(KIND=8) :: D(N)
            END SUBROUTINE SPLINE
          END INTERFACE 
        END MODULE SPLINE__genmod
