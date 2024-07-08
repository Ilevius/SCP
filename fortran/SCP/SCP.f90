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
    implicit none

    call init_globals
    call simpleDcurves

    end program SCP

