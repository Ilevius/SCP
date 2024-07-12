        !COMPILER-GENERATED INTERFACE MODULE: Thu Sep 30 18:11:05 2021
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE ZTRSV__genmod
          INTERFACE 
            SUBROUTINE ZTRSV(UPLO,TRANS,DIAG,N,A,LDA,X,INCX)
              INTEGER(KIND=4) :: LDA
              CHARACTER(LEN=1) :: UPLO
              CHARACTER(LEN=1) :: TRANS
              CHARACTER(LEN=1) :: DIAG
              INTEGER(KIND=4) :: N
              COMPLEX(KIND=8) :: A(LDA,*)
              COMPLEX(KIND=8) :: X(*)
              INTEGER(KIND=4) :: INCX
            END SUBROUTINE ZTRSV
          END INTERFACE 
        END MODULE ZTRSV__genmod
