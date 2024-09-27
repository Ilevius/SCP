        !COMPILER-GENERATED INTERFACE MODULE: Thu Sep 26 11:40:13 2024
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE ZLAHR2__genmod
          INTERFACE 
            SUBROUTINE ZLAHR2(N,K,NB,A,LDA,TAU,T,LDT,Y,LDY)
              INTEGER(KIND=4) :: LDY
              INTEGER(KIND=4) :: LDT
              INTEGER(KIND=4) :: LDA
              INTEGER(KIND=4) :: NB
              INTEGER(KIND=4) :: N
              INTEGER(KIND=4) :: K
              COMPLEX(KIND=8) :: A(LDA,*)
              COMPLEX(KIND=8) :: TAU(NB)
              COMPLEX(KIND=8) :: T(LDT,NB)
              COMPLEX(KIND=8) :: Y(LDY,NB)
            END SUBROUTINE ZLAHR2
          END INTERFACE 
        END MODULE ZLAHR2__genmod
