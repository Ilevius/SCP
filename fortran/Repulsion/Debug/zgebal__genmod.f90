        !COMPILER-GENERATED INTERFACE MODULE: Thu Sep 30 18:11:06 2021
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE ZGEBAL__genmod
          INTERFACE 
            SUBROUTINE ZGEBAL(JOB,N,A,LDA,ILO,IHI,SCALE,INFO)
              INTEGER(KIND=4) :: LDA
              CHARACTER(LEN=1) :: JOB
              INTEGER(KIND=4) :: N
              COMPLEX(KIND=8) :: A(LDA,*)
              INTEGER(KIND=4) :: ILO
              INTEGER(KIND=4) :: IHI
              REAL(KIND=8) :: SCALE(*)
              INTEGER(KIND=4) :: INFO
            END SUBROUTINE ZGEBAL
          END INTERFACE 
        END MODULE ZGEBAL__genmod
