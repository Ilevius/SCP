        !COMPILER-GENERATED INTERFACE MODULE: Thu Sep 26 11:40:14 2024
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE ZDOTC__genmod
          INTERFACE 
            FUNCTION ZDOTC(N,ZX,INCX,ZY,INCY)
              INTEGER(KIND=4) :: N
              COMPLEX(KIND=8) :: ZX(*)
              INTEGER(KIND=4) :: INCX
              COMPLEX(KIND=8) :: ZY(*)
              INTEGER(KIND=4) :: INCY
              COMPLEX(KIND=8) :: ZDOTC
            END FUNCTION ZDOTC
          END INTERFACE 
        END MODULE ZDOTC__genmod
