! Global constants and variables 

  Module Global_Mult
     implicit none
         	 
 ! input
 
     integer Ns,iK,iY,iN,Nsd,kz
     
     parameter(Nsd=101)
	 
     real(8) Vp(Nsd),Vs(Nsd),rho(Nsd),hs(Nsd)
     real(8) z,w
	 	     
! output

 	 complex(8) cM,cN,cP,cR,cS,cM1,cN1,cP1,cR1,cS1, &
 	            cMn(2),cNn(2),cPn(2),cRn(2),cSn(2)
      
! work

     integer NsM,NsN,Ns0,Mf

	 real(8), allocatable :: bl(:),bm(:),blm(:),zk(:)
 	 
 	 complex(8), allocatable :: AM(:,:),AN(:,:),t(:,:),s(:,:), &
 	                            sg1(:),sg2(:),rb1(:,:),rb2(:,:)
 	     
     complex(8) al,al2
     
! constant parameters

     complex(8) ci; parameter (ci=(0d0,1d0)) 
     
  end module Global_Mult
