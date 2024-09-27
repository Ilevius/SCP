        !COMPILER-GENERATED INTERFACE MODULE: Thu Sep 26 11:40:09 2024
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE ZGETRI__genmod
          INTERFACE 
            SUBROUTINE ZGETRI(N,A,LDA,IPIV,WORK,LWORK,INFO)
              INTEGER(KIND=4) :: LDA
              INTEGER(KIND=4) :: N
              COMPLEX(KIND=8) :: A(LDA,*)
              INTEGER(KIND=4) :: IPIV(*)
              COMPLEX(KIND=8) :: WORK(*)
              INTEGER(KIND=4) :: LWORK
              INTEGER(KIND=4) :: INFO
            END SUBROUTINE ZGETRI
          END INTERFACE 
        END MODULE ZGETRI__genmod
