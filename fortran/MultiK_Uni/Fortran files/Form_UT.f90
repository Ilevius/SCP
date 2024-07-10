! auxiliary function to form
! matrices K(al,z), K'(al,z) and vectors U and T 
! after call MultiK 

    subroutine form_UT(a1,a2,Q,U,Tau)
    use Global_Mult; implicit none

	complex(8) a1,a2,a11,a12,a22,U(3),Uz(3), &
	           Ka(3,3),Q(3),Tau(3)
	                          
    a11=a1*a1;  a12=a1*a2; a22=a2*a2  

    Ka(1,1)=-ci*(a11*cM+a22*cN)/al2; Ka(1,2)=-ci*a12*(cM-cN)/al2; Ka(1,3)=-ci*a1*cP 	
    Ka(2,1)=-ci*a12*(cM-cN)/al2; Ka(2,2)=-ci*(a22*cM+a11*cN)/al2; Ka(2,3)=-ci*a2*cP 
    Ka(3,1)= a1*cS/al2;          Ka(3,2)= a2*cS/al2;              Ka(3,3)= cR;

    U=Matmul(Ka,Q)  
    Ka(1,1)=-ci*(a11*cM1+a22*cN1)/al2; Ka(1,2)=-ci*a12*(cM1-cN1)/al2; Ka(1,3)=-ci*a1*cP1 	
    Ka(2,1)=-ci*a12*(cM1-cN1)/al2; Ka(2,2)=-ci*(a22*cM1+a11*cN1)/al2; Ka(2,3)=-ci*a2*cP1 
    Ka(3,1)= a1*cS1/al2;           Ka(3,2)= a2*cS1/al2;               Ka(3,3)= cR1;

    Uz=Matmul(Ka,Q)    
 
    Tau(1) = bm(kz)*(Uz(1)-ci*a1*U(3))   
    Tau(2) = bm(kz)*(Uz(2)-ci*a2*U(3))   
    Tau(3) = bl(kz)*(-ci*a1*U(1)-ci*a2*U(2)) + blm(kz)*Uz(3)        

	end