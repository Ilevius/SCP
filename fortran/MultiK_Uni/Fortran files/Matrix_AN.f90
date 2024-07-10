! Forms matrix A for the system; case X
! Forms Ck+, Ck-
! Nk - matrix of eigenvectors 

    subroutine Matrix_AN
    use Global_Mult; implicit none
    
    integer i,j,i0,j0,k

	complex(8) Lk(1,2),Nk(2,2),Nkm(2,2),Nkp(2,2),Ckm(2,2),Ckp(2,2),Hk(2,2), &
	           ex2,s2,SM1(1,2),SMN(1,2)
	           	                
! initial values
    
    AN=0d0; s=0d0; s(1,1)=1d0; Lk(1,1)=0d0
    
    Hk(1,1)=1d0; Hk(1,2)=0d0; 
    
! cycle k over layers

    do k=1,Ns     

      s2=sg2(k); ex2=exp(-s2*hs(k))
      
! Lk, Hk, Nk, etc.

      Lk(1,2) = -ci*bm(k)
          
      Hk(2,1:2) = Lk(1,1:2)
      
      Nk(1,1)=1d0;  Nk(1,2)=1d0    
      Nk(2,1)= s2;  Nk(2,2)=-s2

      Nkp=Nk; Nkp(1:2,2)=Nk(1:2,2)*ex2 
      
      Nkm=Nk; Nkm(1:2,1)=Nk(1:2,1)*ex2 

      Ckm=MATMUL(Hk,Nkm); Ckp=MATMUL(Hk,Nkp);

      if(k == 1)then      
        AN(1,1:2)=Ckp(2,1:2)

        if(Ns > 1)then        
          AN(2:3,1:2)=Ckm(1:2,1:2)
        else
          go to 1  ! k=Ns        
        end if ! Ns=1
                
      else ! k .ne. 1
          
        if((k == Ns-1).and.(iK == 4))Ckm(1,1:2)=0d0 ! acoust bottom 
          
        i0=2*(k-2)+1; j0=2*(k-1)

! -Ck+                    
        if((k == Ns).and.(iK == 4))then
! acoust bottom Ck+
          Ckp=0d0; Ckp(1,1)=1d0 
        end if

        AN(i0+1:i0+2,j0+1:j0+2)=-Ckp(1:2,1:2)
!  Ck-           
        if(k < Ns)then                
          AN(i0+3:i0+4,j0+1:j0+2)= Ckm(1:2,1:2)
        end if ! k < Ns
          
      end if ! k=1
      
    end do ! k

! k=Ns         
 
 1  k=Ns
  
    select case(iK)
      case(1)
        SMN(1,1)=0d0; SMN(1,2)=1d0;
      case(2)
        SMN(1,1:2)=Ckm(2,1:2)
      case(3)
        SMN(1,1:2)=Ckm(1,1:2)
      case(4)
        SMN(1,1)=0d0; SMN(1,2)=1d0;
      end select ! iK
 
      i0=2*(k-2)+1; j0=2*(k-1)
                    
      AN(i0+3,j0+1:j0+2)= SMN(1,1:2)        
     
    end
