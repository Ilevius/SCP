! Anly: Blocks A_k, B_k, C_k etc, which constitute the matrix A 
! ibot = 0 - half-space, 
!        1 - free laminate, 
!        2 - clamped laminate

    subroutine Blocks
    use Mult_Glob;  implicit none
    
    integer j,m
	
! cycle by m for Cp and Cm blocks

    do m=1,Ms
! Cp      
      Cp(1:3,1:3,m)=Nm(1:3,1:3,m); 
      do j=4,6
        Cp(1:3,j,m)=Nm(1:3,j,m)*em(j-3,m); 
      end do
      
      if(m.ne.1)then
! m .ne. 1
        Cp(4:6,1:3,m)=Mm(1:3,1:3,m); 
        do j=4,6
          Cp(4:6,j,m)=Mm(1:3,j,m)*em(j-3,m)
        end do
      end if ! m.ne.1
         
! Cm      
      if(m == Ms)then
! m == Ms
        select case(ibot)
          case(0)
! half-spase
            Cm(1:3,1:6,Ms) = 0d0; Cm(1,4,Ms) = 1d0;
            Cm(2,5,Ms) = 1d0;     Cm(3,6,Ms) = 1d0;
          
          case(1)
! free layer          
            do j=1,3
              Cm(1:3,j,m)=Nm(1:3,j,m)*em(j,m); 
            end do
            Cm(1:3,4:6,m)=Nm(1:3,4:6,m); 
          
          case(2)
! clamped layer          
            do j=1,3
              Cm(1:3,j,m) = Mm(1:3,j,m)*em(j,m); 
            end do
            Cm(1:3,4:6,m) = Mm(1:3,4:6,m); 
        
        end select ! ibot

      else ! m > Ms
! Sm^-
        do j=1,3
          Cm(1:3,j,m)=Nm(1:3,j,m)*em(j,m); 
        end do
        Cm(1:3,4:6,m)=Nm(1:3,4:6,m); 
! Mm^-        
        do j=1,3
          Cm(4:6,j,m) = Mm(1:3,j,m)*em(j,m); 
        end do
        Cm(4:6,4:6,m) = Mm(1:3,4:6,m); 

      end if ! m == Ms

    end do ! m
    
    end

