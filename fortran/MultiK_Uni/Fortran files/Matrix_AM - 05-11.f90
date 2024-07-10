! Forms matrix A for the system; case Y

    subroutine Matrix_AM
    use Global_Mult; implicit none
    
    integer i,j,i0,j0,k
	
	complex(8) Tk(2,4),Mk(4,4),Mkm(4,4),Mkp(4,4),Ckm(4,4),Ckp(4,4),Gk(4,4), &
	           ex(2),s1,s2,s11,s22,SM1(2,4),SMN(2,4)
	           	                
! initial values
    
    AM=0d0; t=0d0; t(1,1)=1d0; t(2,2)=1d0; Tk=0d0
    
    Gk=0d0; Gk(1,1)=1d0; Gk(2,3)=1d0; 
    
! cycle k over layers

    do k=1,Ns     

      s1=sg1(k); s2=sg2(k); s11=s1*s1; s22=s2*s2;
      
      ex(1)=exp(-s1*hs(k)); ex(2)=exp(-s2*hs(k))

! Tk, Gk, Mk, etc.

      Tk(1,1) = -bl(k)*al2; Tk(1,4) = blm(k); 
      Tk(2,2) = -ci*bm(k);  Tk(2,3) = Tk(2,2); 
      
      Gk(3:4,1:4) = Tk(1:2,1:4)
      
      Mk(1,1)=1d0;  Mk(1,2)=s2;     Mk(1,3)=1d0;  Mk(1,4)=-s2
      Mk(2,1)= s1;  Mk(2,2)=s22;    Mk(2,3)=-s1;  Mk(2,4)= s22
      Mk(3,1)= s1;  Mk(3,2)=al2;    Mk(3,3)=-s1;  Mk(3,4)= al2
      Mk(4,1)=s11;  Mk(4,2)=al2*s2; Mk(4,3)=s11;  Mk(4,4)=-al2*s2
      
      Mkp=Mk
      Mkp(1:4,3)=Mk(1:4,3)*ex(1); Mkp(1:4,4)=Mk(1:4,4)*ex(2); 
      
      if(k < Ns)then
        Mkm=Mk;
        Mkm(1:4,1)=Mk(1:4,1)*ex(1); Mkm(1:4,2)=Mk(1:4,2)*ex(2); 
      end if ! Mkm

      if(k == 1)then      
        SM1=MATMUL(Tk,Mkp);   AM(1:2,1:4)=SM1(1:2,1:4)
        
        if(Ns > 1)then        
          Ckm=MATMUL(Gk,Mkm); AM(3:6,1:4)=Ckm(1:4,1:4)
        end if ! Ns=1 
                
      else ! k .ne. 1
        if(k < Ns)then      
          Ckm=MATMUL(Gk,Mkm); Ckp=MATMUL(Gk,Mkp);
          
          if((k == Ns-1).and.(iK == 4))Ckm(1,1:4)=0d0 ! acoust bottom 
          
          i0=4*(k-2)+2; j0=4*(k-1)
                    
          AM(i0+1:i0+4,j0+1:j0+4)=-Ckp(1:4,1:4)
          AM(i0+5:i0+8,j0+1:j0+4)= Ckm(1:4,1:4)
          
        else ! k=Ns
! k=Ns         
          select case(iK)
            case(1)
              Ckp=MATMUL(Gk,Mkp); 
              SMN = 0d0; SMN(1,3)=1d0; SMN(2,4)=1d0;
            case(2)
              Ckp=MATMUL(Gk,Mkp); SMN=Tk
            case(3)
              Ckp=MATMUL(Gk,Mkp); 
              SMN = 0d0; SMN(1,1)=1d0; SMN(2,3)=1d0;
            case(4)
              Tk=0d0; Tk(1,1)=-w*w*rho(Ns); Gk(3:4,1:4)=Tk(1:2,1:4)
              Ckp=MATMUL(Gk,Mkp); 
              Ckp(1,1:4)=0d0; Ckm(1,2)=1d0
              SMN = 0d0; SMN(1,3)=1d0; SMN(2,4)=1d0;        
          end select ! iK
              
          i0=4*(k-2)+2; j0=4*(k-1)
                    
          AM(i0+1:i0+4,j0+1:j0+4)=-Ckp(1:4,1:4)
          AM(i0+5:i0+6,j0+1:j0+4)= SMN(1:2,1:4)
        
        end if ! k=Ns           
      end if ! k=1
      
    end do ! k
      
    end
