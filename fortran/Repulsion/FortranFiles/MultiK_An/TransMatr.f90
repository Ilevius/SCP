! Forms matrix and recursively calculate t_m 

    subroutine TransMatr
    use Mult_Glob; implicit none
    
    integer m,Nd
	parameter(Nd=12)
	
	complex(8) As(Nd,Nd),Bs(Nd,Nd),rb1(Nd,Nd),rb2(Nd,Nd+3),fs(Nd,3), &	          
	           Amt(6,6),Bmt(6,6),Cmt(6,6),tmt(6,3), &
	           Cs(Nd,Nd),rm1(Nd),rm2(Nd),det  ! for dstar 	
	           
	common/det/det
		           	                
! r.h.p.

    fs=0d0; fs(1,1)=1d0; fs(2,2)=1d0; fs(3,3)=1d0
        
! Ms = 1
    if(Ms == 1)then
      As(1:3,1:6)=Cp(1:3,1:6,1)
      As(4:6,1:6)=Cm(1:3,1:6,1)
      
      call STAR5(As,fs,rb1,rb2,Nd,6,3,2)

      tm(1:6,1:3,1)=fs(1:6,1:3)

!      SUBROUTINE DSTAR(A,C,S,SM,DET,ND,N,KORT)
! ------------------

      Bs(1:6,1:6)=As(1:6,1:6)
      call DSTAR(Bs,Cs,rm1,rm2,det,Nd,6,2)

! -----------
     end if ! Ms = 1 

! Ms = 2
    if(Ms == 2)then
      As(1:3,1:6)=Cp(1:3,1:6,1); As(1:3,7:12)=0d0
      
      As(4:9,1:6)=Cm(1:6,1:6,1); As(4:9,7:12)  =-Cp(1:6,1:6,2)
      
      As(10:12,1:6)=0d0;         As(10:12,7:12)= Cm(1:3,1:6,2)
      
      call STAR5(As,fs,rb1,rb2,Nd,12,3,2)

      tm(1:6,1:3,1)=fs(1:6 ,1:3)
      tm(1:6,1:3,2)=fs(7:12,1:3)

!      SUBROUTINE DSTAR(A,C,S,SM,DET,ND,N,KORT)
! ------------------

      Bs(1:12,1:12)=As(1:12,1:12)
      call DSTAR(Bs,Cs,rm1,rm2,det,Nd,12,2)

! -----------
      
    end if ! Ms = 2 

! Ms > 2     
    if(Ms > 2)then

! Ms > 2, forming blocks Am_m, Ac_m, Ap_m in the m loop over layers 
    do m=1,Ms             
      if(m == 1)then      
        Ac(1:3,1:6,m)=Cp(1:3,1:6,m); Ap(1:3,1:6,m)=0d0
        Ac(4:6,1:6,m)=Cm(1:3,1:6,m); Ap(4:6,1:6,m)=-Cp(1:3,1:6,m+1)
      else
        Am(1:3,1:6,m)=Cm(4:6,1:6,m-1); Ac(1:3,1:6,m)=-Cp(4:6,1:6,m); 
        Am(4:6,1:6,m)=0d0;             Ac(4:6,1:6,m)= Cm(1:3,1:6,m);
        
        if(m < Ms)then
          Ap(1:3,1:6,m)=0d0
          Ap(4:6,1:6,m)=-Cp(1:3,1:6,m+1)
        end if ! m <Ms      
      end if ! m.ne.Ms
    end do ! m   
                            
! backward recursion for B_m
           
      do m=Ms,2,-1
        if(m == Ms)then
          As(1:6,1:6) = Ac(1:6,1:6,Ms)
          Bs(1:6,1:6) = Am(1:6,1:6,Ms)
        else
          Amt(1:6,1:6) = Ap(1:6,1:6,m); 
          Bmt(1:6,1:6) = Bm(1:6,1:6,m);  Cmt = MATMUL(Amt,Bmt); 
          
          As (1:6,1:6) = Ac(1:6,1:6,m) + Cmt(1:6,1:6)
          Bs (1:6,1:6) = Am(1:6,1:6,m)
        end if ! m == Ms

        call STAR5(As,Bs,rb1,rb2,Nd,6,6,2)
          
        Bm(1:6,1:6,m-1) = - Bs(1:6,1:6)            
      end do ! m

! t_1
      Amt(1:6,1:6) = Ap(1:6,1:6,1); 
      Bmt(1:6,1:6) = Bm(1:6,1:6,1);  Cmt = MATMUL(Amt,Bmt); 
      As (1:6,1:6) = Ac(1:6,1:6,1) + Cmt(1:6,1:6)

!      SUBROUTINE DSTAR(A,C,S,SM,DET,ND,N,KORT)
! ------------------

      Amt(1:6,1:6)=As(1:6,1:6)
      call DSTAR(Amt,Bmt,rm1,rm2,det,6,6,2)

! -----------

      call STAR5(As,fs,rb1,rb2,Nd,6,3,2)    
      tm(1:6,1:3,1)=fs(1:6,1:3)
          
! forward recursion for t_m, m > 1

      do m=2,Ms
        Amt(:,:) = Bm(:,:,m-1);  
        tmt(1:6,1:3) = tm(1:6,1:3,m-1); tm(1:6,1:3,m) = MATMUL(Amt,tmt); 
                                                  
!       Cmt = MATMUL(Amt,tmt); tm (1:6,1:3,m)= Cmt(1:4,1:2)
      end do ! m     
           
    end if ! Ms > 2
                                         
    end
