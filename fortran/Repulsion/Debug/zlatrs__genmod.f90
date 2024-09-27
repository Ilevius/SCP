        !COMPILER-GENERATED INTERFACE MODULE: Thu Sep 26 11:40:13 2024
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE ZLATRS__genmod
          INTERFACE 
            SUBROUTINE ZLATRS(UPLO,TRANS,DIAG,NORMIN,N,A,LDA,X,SCALE,   &
     &CNORM,INFO)
              INTEGER(KIND=4) :: LDA
              CHARACTER(LEN=1) :: UPLO
              CHARACTER(LEN=1) :: TRANS
              CHARACTER(LEN=1) :: DIAG
              CHARACTER(LEN=1) :: NORMIN
              INTEGER(KIND=4) :: N
              COMPLEX(KIND=8) :: A(LDA,*)
              COMPLEX(KIND=8) :: X(*)
              REAL(KIND=8) :: SCALE
              REAL(KIND=8) :: CNORM(*)
              INTEGER(KIND=4) :: INFO
            END SUBROUTINE ZLATRS
          END INTERFACE 
        END MODULE ZLATRS__genmod
