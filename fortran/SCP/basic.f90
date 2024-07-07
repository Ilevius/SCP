MODULE basic
use globals
IMPLICIT NONE

CONTAINS
    
    FUNCTION makeKappa(w, lambda, mu, rho)
    real*8 makeKappa(2), w, lambda, mu, rho
        makeKappa(1) = sqrt(rho*w**2/(lambda + 2d0*mu))
        makeKappa(2) = sqrt(rho*w**2/(mu))
    END FUNCTION makeKappa
    
    
    FUNCTION makeSigma(alfa, kappa)
    real*8 kappa(2)
    complex*16 alfa, makeSigma(2)
        if (Imag(alfa) == 0d0)  then 
                if (abs(alfa) < Kappa(1)) then
                    MakeSigma(1) = -ci*sqrt(Kappa(1)**2 - real(alfa)**2)
                else 
                    MakeSigma(1) = sqrt(real(alfa)**2 - Kappa(1)**2)
                endif    
                    
                if (abs(alfa) < Kappa(2)) then
                    MakeSigma(2) = -ci*sqrt(Kappa(2)**2 - real(alfa)**2)
                else 
                    MakeSigma(2) = sqrt(real(alfa)**2 - Kappa(2)**2)
                endif                
        else 
                MakeSigma(1) = sqrt(alfa**2 - cmplx(Kappa(1)**2))
                MakeSigma(2) = sqrt(alfa**2 - cmplx(Kappa(2)**2))
        endif  
    END 
    
    
    FUNCTION makeE(sigma, z_top, z_bot, z)
    real*8 z_top, z_bot, z
    complex*16 makeE(4,4), sigma(2)
        makeE = 0d0
        makeE(1,1) = exp(sigma(1)*(z-z_top)); makeE(2,2) = exp(-sigma(1)*(z-z_bot));
        makeE(3,3) = exp(sigma(2)*(z-z_top)); makeE(4,4) = exp(-sigma(2)*(z-z_bot));
    END FUNCTION makeE    
    
    FUNCTION makeT(alfa, lambda, mu)
    real*8 lambda, mu
    complex*16 makeT(2,4), alfa
        makeT = 0d0
        makeT(1,1) = -lambda*alfa**2; makeT(1,4) = lambda+2d0*mu;
        makeT(2,2) = -ci*mu*alfa**2; makeT(2,3) = -ci*mu*alfa**2;
    END FUNCTION makeT      
    
    FUNCTION makeP(alfa, sigma)
    complex*16 makeP(4,4), alfa, sigma(2)
    complex*16 m1(4,1), m2(4,1), m3(4,1), m4(4,1)
        m1(1,1) = 1d0; m1(2,1) = sigma(1); m1(3,1) = sigma(1); m1(4,1) = sigma(1)**2;
        
        m2(1,1) = 1d0; m2(2,1) = -sigma(1); m2(3,1) = -sigma(1); m2(4,1) = sigma(1)**2;
        
        m3(1,1) = sigma(2); m3(2,1) = sigma(2)**2; m3(3,1) = alfa**2; m3(4,1) = alfa**2*sigma(2);
        
        m4(1,1) = -sigma(2); m4(2,1) = sigma(2)**2; m4(3,1) = alfa**2; m4(4,1) = -alfa**2*sigma(2);
        
        makeP(:,1) = m1(:,1); makeP(:,2) = m2(:,1); makeP(:,3) = m3(:,1); makeP(:,4) = m4(:,1);
    END FUNCTION makeP    

    
END MODULE basic   