        !COMPILER-GENERATED INTERFACE MODULE: Thu Sep 26 11:40:05 2024
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE ZROT__genmod
          INTERFACE 
            SUBROUTINE ZROT(N,CX,INCX,CY,INCY,C,S)
              INTEGER(KIND=4) :: N
              COMPLEX(KIND=8) :: CX(*)
              INTEGER(KIND=4) :: INCX
              COMPLEX(KIND=8) :: CY(*)
              INTEGER(KIND=4) :: INCY
              REAL(KIND=8) :: C
              COMPLEX(KIND=8) :: S
            END SUBROUTINE ZROT
          END INTERFACE 
        END MODULE ZROT__genmod
