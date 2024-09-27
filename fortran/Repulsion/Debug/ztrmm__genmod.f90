        !COMPILER-GENERATED INTERFACE MODULE: Thu Sep 26 11:40:11 2024
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE ZTRMM__genmod
          INTERFACE 
            SUBROUTINE ZTRMM(SIDE,UPLO,TRANSA,DIAG,M,N,ALPHA,A,LDA,B,LDB&
     &)
              INTEGER(KIND=4) :: LDB
              INTEGER(KIND=4) :: LDA
              CHARACTER(LEN=1) :: SIDE
              CHARACTER(LEN=1) :: UPLO
              CHARACTER(LEN=1) :: TRANSA
              CHARACTER(LEN=1) :: DIAG
              INTEGER(KIND=4) :: M
              INTEGER(KIND=4) :: N
              COMPLEX(KIND=8) :: ALPHA
              COMPLEX(KIND=8) :: A(LDA,*)
              COMPLEX(KIND=8) :: B(LDB,*)
            END SUBROUTINE ZTRMM
          END INTERFACE 
        END MODULE ZTRMM__genmod
