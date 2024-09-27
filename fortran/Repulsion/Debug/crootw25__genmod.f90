        !COMPILER-GENERATED INTERFACE MODULE: Thu Sep 26 11:40:12 2024
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE CROOTW25__genmod
          INTERFACE 
            SUBROUTINE CROOTW25(Y,DZ,EPZ,MAX,IP,F)
              COMPLEX(KIND=8) :: Y
              COMPLEX(KIND=8) :: DZ
              REAL(KIND=8) :: EPZ
              INTEGER(KIND=4) :: MAX
              INTEGER(KIND=4) :: IP
              COMPLEX(KIND=8) :: F
              EXTERNAL F
            END SUBROUTINE CROOTW25
          END INTERFACE 
        END MODULE CROOTW25__genmod
