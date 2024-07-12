! Calculates Green's matrix symbols (output via Mult_Glob)
!      K(alf,gm,z)- displacement vector-column
!      T(alf,gm,z)- vector-columns of stresses at z=const  
!  and tm(6,3,Ms) - vectors t_m(alf,gm)                       
! for an M-layered structure specified by the key 'ibot'
!      ibot = 0 - half-space,         ! input via Mult_Glob
!             1 - free laminate, 
!             2 - clamped laminate
!	          any other ibot yields nothing
!       key = 0 - t_m only
!             1 - t_m and matrix K 
!             2 - t_m and matrix T
!             any othe key - full calculation: t_m, K and T 
! 
! input via subroutine parameters:
!   alf=sqrt(al(1)^2+al(2)^2),  gm - gamma, z - depth z 

    subroutine MultiK_An(alf,gm,z)
    use Mult_Glob;  implicit none
    
	real(8) gm,z

    complex(8) alf

! allocation

	 if(.not.allocated(Ac))then

	   allocate(Ac(6,6,Ms),Am(6,6,Ms),Ap(6,6,Ms), &
	            Cm(6,6,Ms),Cp(6,6,Ms),Bm(6,6,Ms-1),tm(6,3,Ms), &
	            sgm(6,Ms),em(3,Ms),Mm(3,6,Ms),Nm(3,6,Ms))
	 
	   if((ibot < 0).or.(ibot > 2))then 
	     write(2,*)' *** bottom conditions undefined, ibot =',ibot
	     stop
	   end if ! ibot
	     
	 end if ! allocation
	  
! alf
    al(1)=alf*cos(gm);  
    al(2)=alf*sin(gm);
                   
! Eigenvalues and eigenvectors

	call Eigen(alf)

! Blocks	
	call Blocks

! Transfer matrix algorithm, vectors t_m	
	call TransMatr
	
	if(key == 0)return

! Green's matrices K and T

    if(key.ne.2) call Green_K(z); if(key == 1)return
    if(key.ne.1) call Green_T(z)  

    end
