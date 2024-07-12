        !COMPILER-GENERATED INTERFACE MODULE: Thu Sep 30 18:11:04 2021
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE ZAXPY__genmod
          INTERFACE 
            SUBROUTINE ZAXPY(N,ZA,ZX,INCX,ZY,INCY)
              INTEGER(KIND=4) :: N
              COMPLEX(KIND=8) :: ZA
              COMPLEX(KIND=8) :: ZX(*)
              INTEGER(KIND=4) :: INCX
              COMPLEX(KIND=8) :: ZY(*)
              INTEGER(KIND=4) :: INCY
            END SUBROUTINE ZAXPY
          END INTERFACE 
        END MODULE ZAXPY__genmod
