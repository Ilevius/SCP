        !COMPILER-GENERATED INTERFACE MODULE: Thu Sep 26 11:40:11 2024
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE ZGEHRD__genmod
          INTERFACE 
            SUBROUTINE ZGEHRD(N,ILO,IHI,A,LDA,TAU,WORK,LWORK,INFO)
              INTEGER(KIND=4) :: LDA
              INTEGER(KIND=4) :: N
              INTEGER(KIND=4) :: ILO
              INTEGER(KIND=4) :: IHI
              COMPLEX(KIND=8) :: A(LDA,*)
              COMPLEX(KIND=8) :: TAU(*)
              COMPLEX(KIND=8) :: WORK(*)
              INTEGER(KIND=4) :: LWORK
              INTEGER(KIND=4) :: INFO
            END SUBROUTINE ZGEHRD
          END INTERFACE 
        END MODULE ZGEHRD__genmod
