! C_6 from input ==> matrix S and Ex,Ez, etc. for a current 'm'
  
    subroutine MaterConsts1(m)
    use PropRest2_Glob; use Mult_Glob; implicit none
    
    integer i,j,m
 
    real(8) aC1(3,3),aC2(4:6),aS1(3,3),aS2(4:6), &
            Exx,Ezz,muxx,muzz,rhott,hstt,nuxx,nuzz
 
    complex(8) C1(3,3),S1(3,3),rb1(3,3),rb2(3,6)
 	  
! C ==> S transfer
	
      C1(1:3,1:3) = C_6(1:3,1:3,m);
    
      S1 = 0d0; S1(1,1)=1d0; S1(2,2)=1d0; S1(3,3)=1d0;   
      
      call STAR5(C1,S1,rb1,rb2,3,3,3,2)
    
      aS1 = real(S1)  ! S1
       
      do i=4,6; aS2(i)= 1d0/C_6(i,i,m); end do
   
 !     write(2,2)((aS1(i,j),j=1,3),i=1,3),(aS2(i),i=4,6)
 2    format('   S1'/3(3f12.4/)/ &
             '   S2'/3f12.4)

! material constants       
      
      Exx = 1d0/aS1(1,1); nuxx = -aS1(1,2)*Exx
      Ezz = 1d0/aS1(3,3); nuzz = -aS1(1,3)*Ezz
      
      muxx = Exx/(2d0*(1d0 + nuxx))
      muzz = 1d0/aS2(4); rhott = rho(m); hstt = hs(m)
      
      write(2,33)Exx,Ezz,muxx,muzz,rhott,hstt,nuxx,nuzz
33    format( '! Ex,Ez,mux,muz =',4f12.5/ &
              '!        rho,hs =',2f12.5/ &
              '!       nux,nuz =',2f12.5/)
                 
    end ! MaterConsts
