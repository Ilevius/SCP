        !COMPILER-GENERATED INTERFACE MODULE: Thu Sep 30 18:11:08 2021
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE ISPLINE__genmod
          INTERFACE 
            FUNCTION ISPLINE(U,X,Y,B,C,D,N)
              INTEGER(KIND=4) :: N
              REAL(KIND=8) :: U
              REAL(KIND=8) :: X(N)
              REAL(KIND=8) :: Y(N)
              REAL(KIND=8) :: B(N)
              REAL(KIND=8) :: C(N)
              REAL(KIND=8) :: D(N)
              REAL(KIND=8) :: ISPLINE
            END FUNCTION ISPLINE
          END INTERFACE 
        END MODULE ISPLINE__genmod
