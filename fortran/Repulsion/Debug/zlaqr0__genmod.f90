        !COMPILER-GENERATED INTERFACE MODULE: Thu Sep 26 11:40:11 2024
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE ZLAQR0__genmod
          INTERFACE 
            SUBROUTINE ZLAQR0(WANTT,WANTZ,N,ILO,IHI,H,LDH,W,ILOZ,IHIZ,Z,&
     &LDZ,WORK,LWORK,INFO)
              INTEGER(KIND=4) :: LDZ
              INTEGER(KIND=4) :: LDH
              LOGICAL(KIND=4) :: WANTT
              LOGICAL(KIND=4) :: WANTZ
              INTEGER(KIND=4) :: N
              INTEGER(KIND=4) :: ILO
              INTEGER(KIND=4) :: IHI
              COMPLEX(KIND=8) :: H(LDH,*)
              COMPLEX(KIND=8) :: W(*)
              INTEGER(KIND=4) :: ILOZ
              INTEGER(KIND=4) :: IHIZ
              COMPLEX(KIND=8) :: Z(LDZ,*)
              COMPLEX(KIND=8) :: WORK(*)
              INTEGER(KIND=4) :: LWORK
              INTEGER(KIND=4) :: INFO
            END SUBROUTINE ZLAQR0
          END INTERFACE 
        END MODULE ZLAQR0__genmod
