        !COMPILER-GENERATED INTERFACE MODULE: Thu Sep 30 18:11:08 2021
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE ZGETF2__genmod
          INTERFACE 
            SUBROUTINE ZGETF2(M,N,A,LDA,IPIV,INFO)
              INTEGER(KIND=4) :: LDA
              INTEGER(KIND=4) :: M
              INTEGER(KIND=4) :: N
              COMPLEX(KIND=8) :: A(LDA,*)
              INTEGER(KIND=4) :: IPIV(*)
              INTEGER(KIND=4) :: INFO
            END SUBROUTINE ZGETF2
          END INTERFACE 
        END MODULE ZGETF2__genmod
