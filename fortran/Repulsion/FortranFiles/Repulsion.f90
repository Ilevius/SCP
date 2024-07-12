!  Repulsion -- calculation of GW dispersion curves and   
!    frequency responses of a multilayered elastic waveguide 
!    for investigating repulsion and ZGV-resonance phenomena
 
    program Repulsion
    use Mult_Glob; implicit none
  
! Initiation

	call Init_RP

	if(Mode ==  0) call RealPoles_RP
!	if(Mode ==  1) call ComplPoles
!	if(Mode ==  2) call ComplRes
    if(Mode ==  3) call Spectrum_Kf_sl
    if(Mode ==  4) call Response

! tests
	if(Mode ==-1) call test_print_K
 !   if(Mode == -2) call TestSpline
             
	end 
