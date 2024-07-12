        !COMPILER-GENERATED INTERFACE MODULE: Thu Sep 30 18:11:07 2021
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE HALFC5__genmod
          INTERFACE 
            SUBROUTINE HALFC5(F,TMIN,TMAX,HT,EPS,NMAX,DZ,NX)
              INTEGER(KIND=4) :: NMAX
              COMPLEX(KIND=8) :: F
              EXTERNAL F
              REAL(KIND=8) :: TMIN
              REAL(KIND=8) :: TMAX
              REAL(KIND=8) :: HT
              REAL(KIND=8) :: EPS
              REAL(KIND=8) :: DZ(NMAX)
              INTEGER(KIND=4) :: NX
            END SUBROUTINE HALFC5
          END INTERFACE 
        END MODULE HALFC5__genmod
