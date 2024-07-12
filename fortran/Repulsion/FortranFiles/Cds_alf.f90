! auxiliary function for poles finding by Crootw25
! in the complex plane alpha

    complex*16 function Cds_alf(alf)
    use Mult_Glob; implicit none

	integer i; real(8) gm; complex*16 alf,cs,c,det
	common/gm/gm/det/det


	call MultiK_An(alf,gm,0d0)
!	call MultiK_An(alf,gm,-hs(1)/3)
	 
!    c = 1d0/(Kaz(1,1)+Kaz(3,3)) ! Kaz(2,2)
!     c = 1d0/Kaz(1,1)
!    c = 1d0/Kaz(1,3)
!     c = 1d0/Kaz(2,2)
    c = 1d0/Kaz(3,3)

!    c = det/cs**(6*Ms)

! already found roots

    do i=1,N0
	  c=c/(alf-w*dzs0(i))
    end do

! cuts    
!    do i=1,Ms
!      c=c/((cs-sp(i))*(cs-ss(i)))
!    end do
	  
	Cds_alf = c
		
	end