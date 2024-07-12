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
    !call simpleDcurves
    !call bottom_conditions
    !call SCP1(2.0998d-3, 0.0420587d0, 0.5d-3, fmax, 7) !1 ok
    !call SCP1(2.0998d-3, 0.0420587d0, 0.5d-3, fmax, 7) !2
    call SCP1(0.156084d0, 0.0273854d0, 0.5d-3, fmax, 7) !3
    !call SCP1(0.346065d0, 0.0457759d0, 0.5d-3, fmax, 7) !4 ok
    !call SCP1(0.526047d0, 0.0247028d0, 0.5d-3, fmax, 8) !5 ok
    !call SCP1(0.816d0, 0.0589583d0, 0.5d-3, fmax, 7) !6  ok
    !call SCP1(0.944d0, 0.0312388d0, 0.5d-3, fmax, 7) !7  ok

    end program SCP

