MODULE ThreeLayerCase
USE globals
USE basic
IMPLICIT NONE

CONTAINS
    



    FUNCTION makeA(alfa, sigma)

    complex*16 makeA(12,12), alfa, sigma(3,2)
    complex*16 S0(2,4), C1_bot(4,4), C2_top(4,4), C2_bot(4,4), C3_top(4,4), S3(2,4), temp_mat(4,4)
    complex*16 E(4,4), P(4,4), T(2,4)
        makeA = 0d0
        
        
        
        
                                                    ! SO - top surface load                           for U1
        E = makeE(sigma(1,:), z(1), z(2), z(1))
        P = makeP(alfa, sigma(1,:))
        T = makeT(alfa, lambda(1), mu(1))
        temp_mat = matmul(P, E); 
        S0 = matmul(T, temp_mat)

                                                    ! C1_bot - first interface load and displacement  for U1
        E = makeE(sigma(1,:), z(1), z(2), z(2))
        temp_mat = matmul(P, E); C1_bot(1,:) = temp_mat(1,:); C1_bot(2,:) = temp_mat(3,:);
        C1_bot(3:4, :) = matmul(T, temp_mat);
        
        
        
        
        
                                                    ! C2_top - first interface load and displacement  for U2
        E = makeE(sigma(2,:), z(2), z(3), z(2))
        P = makeP(alfa, sigma(2,:))
        T = makeT(alfa, lambda(2), mu(2))
        temp_mat = matmul(P, E); C2_top(1,:) = temp_mat(1,:); C2_top(2,:) = temp_mat(3,:);
        C2_top(3:4, :) = matmul(T, temp_mat);
        
                                                    ! C2_bot - second interface load and displacement for U2
        E = makeE(sigma(2,:), z(2), z(3), z(3))
        temp_mat = matmul(P, E); C2_bot(1,:) = temp_mat(1,:); C2_bot(2,:) = temp_mat(3,:);
        C2_bot(3:4, :) = matmul(T, temp_mat);
        
        
        
        
        
        
                                                    ! C3_top - second interface load and displacement for U3
        E = makeE(sigma(3,:), z(3), z(4), z(3))
        P = makeP(alfa, sigma(3,:))
        T = makeT(alfa, lambda(3), mu(3))
        temp_mat = matmul(P, E); C3_top(1,:) = temp_mat(1,:); C3_top(2,:) = temp_mat(3,:);
        C3_top(3:4, :) = matmul(T, temp_mat);
        
                                                    ! S3 - bottom surface load                        for U3
        E = makeE(sigma(3,:), z(3), z(4), z(4))
        temp_mat = matmul(P, E);
        S3 = matmul(T, temp_mat);
        
                                                    ! matrix A assembly
        makeA(1:2, 1:4) = S0;
        makeA(3:6, 1:4) = C1_bot; makeA(3:6, 5:8) = -C2_top;
                                  makeA(7:10, 5:8) = C2_bot; makeA(7:10, 9:12) = -C3_top;
                                                             makeA(11:12, 9:12) = S3;
    END FUNCTION makeA 
    
    
    FUNCTION makeG(alfa, w)
    integer i
    real*8 w, kappa(2)
    complex*16 makeG(12,2), alfa, sigma(3,2), A(12,12)
    complex*16 C(12,12), R(12,5)
        makeG = 0d0; makeG(1, 1) = 1d0; makeG(2, 2) = 1d0;
        do i = 1, 3
            kappa = makeKappa(w, lambda(i), mu(i), rho(i))
            sigma(i, :) = makeSigma(alfa, kappa)
        enddo
        A = makeA(alfa, sigma)
        call STAR5(A,makeG,C,R,12,12,2,2)
    END FUNCTION makeG 
    
    FUNCTION makeY(layNo, alfa, zz)
    integer layNo
    real*8 zz, kappa(2)
    complex*16 alfa, makeY(4,2), sigma(2), G(12,2), E(4,4), P(4,4), temp_mat(4,4)
        G = makeG(alfa, w)
        kappa = makeKappa(w, lambda(layNo), mu(layNo), rho(layNo))
        sigma = makeSigma(alfa, kappa)
        
        E = makeE(sigma, z(layNo), z(layNo+1), zz)
        P = makeP(alfa, sigma)
        

        temp_mat = matmul(P, E); 
        makeY = matmul(temp_mat, G(4*layNo-3:4*layNo, :))
    
    END FUNCTION makeY
  
    
    real*8 function haminDelta(alfa)
    implicit none
    real*8 alfa
    complex*16 G(12,2)
    complex*16 alfa_c
        alfa_c = cmplx(alfa)
        G = makeG(alfa_c, w)
        G = abs(G)
        haminDelta = 1d0/sum(G) 
    end
    
    
    
    SUBROUTINE simpleDcurves
    IMPLICIT NONE
    real*8 dz(10)
    integer i, j, Ndz
        open(1, file="C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\data\simpleDcurves.txt", FORM='FORMATTED');
        
        do i = 1, dotsNum
            f = fmin + fstep*(i-1); w = f*2d0*pi;
            call Hamin(haminDelta, dzMin, dzMax, haminStep, haminEps, 10, dz, Ndz)
            do j = 1, Ndz
                write(1, '(5E15.6E3)') f, dz(j), dz(j)/f, f/dz(j)
            enddo    
        enddo
        close(1)
    END SUBROUTINE simpleDcurves

    

END MODULE ThreeLayerCase