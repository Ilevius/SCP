        !COMPILER-GENERATED INTERFACE MODULE: Thu Sep 26 11:40:12 2024
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE ZDOTU__genmod
          INTERFACE 
            FUNCTION ZDOTU(N,ZX,INCX,ZY,INCY)
              INTEGER(KIND=4) :: N
              COMPLEX(KIND=8) :: ZX(*)
              INTEGER(KIND=4) :: INCX
              COMPLEX(KIND=8) :: ZY(*)
              INTEGER(KIND=4) :: INCY
              COMPLEX(KIND=8) :: ZDOTU
            END FUNCTION ZDOTU
          END INTERFACE 
        END MODULE ZDOTU__genmod
