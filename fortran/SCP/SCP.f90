!  SCP.f90 
!
!  FUNCTIONS:
!  SCP - Entry point of console application.
!

!****************************************************************************
!
!  PROGRAM: SCP
!
!  PURPOSE:  Entry point for the console application.
!
!****************************************************************************

    program SCP
    use globals
    use ThreeLayerCase
    use tests
    implicit none

    call init_globals
    call simpleDcurves
    call bottom_conditions

    end program SCP

