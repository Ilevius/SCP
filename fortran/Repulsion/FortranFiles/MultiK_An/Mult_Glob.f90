! Global constants and arrays for Multic_An

     Module Mult_Glob
     implicit none
     
     integer Ms,Mode
     integer ibot  ! ibot - bottom case:
                           ! 0 - half-space, 1 - free laminate, 
                           ! 2 - clamped laminate
    
     integer key  !   key = 0 - t_m only
                  !         1 - t_m and matrix K 
                  !         2 - t_m and matrix T
                  !         any othe key - full calculation: t_m, K and T 
        
     real(8) w,f,f1,f2,hf
	        	 
	 complex(8) al(3),Kaz(3,3),Taz(3,3)
	                ! K(al,gm,z) and T(al,gm,z) - displ. and stress 
	                ! Green's matrices

! elastic constants C_6(6,6,Ms),C_3(3,3,3,3,Ms),rho(Ms),hs,zm

	integer, allocatable:: isym(:)

    real(8), allocatable:: C_6(:,:,:),C_3(:,:,:,:,:),rho(:), &
        zm(:),hs(:),xp(:,:)

   ! for isotropic
    real(8), allocatable:: V_p(:),V_s(:)
 
! matrix blocks
	 complex(8), allocatable:: Ac(:,:,:),Am(:,:,:),Ap(:,:,:), &
	    Cm(:,:,:),Cp(:,:,:),tm(:,:,:),Bm(:,:,:)

! for egen 	    
	 complex(8), allocatable:: sgm(:,:),Mm(:,:,:),Nm(:,:,:),em(:,:) 

! for ComplPoles
     integer Nn1,Nn2,Max,ip,N0
     real(8) eps
	 complex(8) cs0,zh
	 complex(8), allocatable:: dzs0(:) 

! file names
     character(24) compldzs ! file name for found complex slownesses 
     	    	 
! constants
	 real(8) pi;       parameter (pi=3.141592653589793d0)
	 complex(8) cci;   parameter(cci=(0d0,1d0))

     end module Mult_Glob
