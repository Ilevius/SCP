        !COMPILER-GENERATED INTERFACE MODULE: Thu Sep 30 18:11:14 2021
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE ZTRTI2__genmod
          INTERFACE 
            SUBROUTINE ZTRTI2(UPLO,DIAG,N,A,LDA,INFO)
              INTEGER(KIND=4) :: LDA
              CHARACTER(LEN=1) :: UPLO
              CHARACTER(LEN=1) :: DIAG
              INTEGER(KIND=4) :: N
              COMPLEX(KIND=8) :: A(LDA,*)
              INTEGER(KIND=4) :: INFO
            END SUBROUTINE ZTRTI2
          END INTERFACE 
        END MODULE ZTRTI2__genmod
