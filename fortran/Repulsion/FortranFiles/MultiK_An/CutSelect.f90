! Anly: select alpha position with respect to the vertical cuts
!       in the 1st quadrant of the complex plane alpha 

    subroutine CutSelect(alf)
    use Mult_Glob;  implicit none
    
    integer i(3),in,n; logical mask(3)
    
    real(8) ralf,xpw(3),xpw2(3),rb(3)
    real(8) a,b,c,xp1,xp2  ! for test roots
    
    complex(8) alf,sgr(6),Mmr(3,6),xn2(3)
    complex(8) alf2,ssg1,ssg2,p,q,ssg(3),ssgm(3),dt  

    if(imag(alf)<-1d-12)return ! lower half-plane, no action    
   
    ralf=real(alf); xpw(1:3)=xp(1:3,Ms)*w
    
! to the right of all breakpoints, no action 
    if(ralf.ge.xpw(3))return    
    
! to the left of all breakpoints, full exchange
    if(ralf.le.xpw(1))then 
      sgr(1:3) = sgm(4:6,Ms); Mmr(:,1:3) = Mm(:,4:6,Ms)
      sgr(4:6) = sgm(1:3,Ms); Mmr(:,4:6) = Mm(:,1:3,Ms)
      
      sgm(:,Ms)= sgr(:);      Mm(:,:,Ms) = Mmr(:,:); return           
    end if ! Re(alf) < xp1

! analitic roots for proper numbering

    a = C_6(1,1,Ms);   xp1 = sqrt(rho(Ms)/a)
    b = C_6(4,4,Ms);   xp2 = sqrt(rho(Ms)/b)
    c = C_6(1,3,Ms) 
    
    alf2 = alf**2;     ssg1 = alf2 - xp1**2 
                       ssg2 = alf2 - xp2**2 
                       
    p = (alf2*(b+c)**2 - a**2*ssg1 - b**2*ssg2)/(a*b)
    q = ssg1*ssg2;  dt = sqrt(p**2/4d0 - q)
    
    ssg(1) = -p/2 + dt
    ssg(2) = -p/2 - dt;   ssg(3) = ssg2
    
    ssgm(1:3) = sgm(1:3,Ms)**2
    
!    write(2,*)' sgm^2 numeric / sgm^2 analitic'
!    write(2,7)ssgm,ssg
 7  format(2(3(2f12.4,2x)/))
    
! rearrangement of 'sgm' and 'Mm' 
! in accordance with analitic roots 'ssg'
         
    mask=.true. 
    do n=1,3
      rb(:) = abs(ssg(n)-ssgm(:))
      i(n)  = minloc(rb,1,mask); mask(i(n))=.false.     
    end do
 
! write(2,*)' i(n) =',i
 
    do n=1,3
      in = i(n)
      sgr(n)  = sgm(in  ,Ms); Mmr(:,n  ) = Mm(:,in  ,Ms)
      sgr(n+3)= sgm(in+3,Ms); Mmr(:,n+3) = Mm(:,in+3,Ms)    
    end do

    sgm(:,Ms)= sgr(:); Mm(:,:,Ms) = Mmr(:,:)          
   
! xp1 < Re(alf) < xp2, exchange  (2,3) <--> (5,6)
    if((ralf > xpw(1)).and.(ralf < xpw(2)))then 
      sgr(1)   = sgm(1,Ms);   Mmr(:,1)   = Mm(:,1,Ms)
      sgr(4)   = sgm(4,Ms);   Mmr(:,4)   = Mm(:,4,Ms)
    
      sgr(2:3) = sgm(5:6,Ms); Mmr(:,2:3) = Mm(:,5:6,Ms)
      sgr(5:6) = sgm(2:3,Ms); Mmr(:,5:6) = Mm(:,2:3,Ms)
      
      sgm(:,Ms)= sgr(:);      Mm(:,:,Ms) = Mmr(:,:); return           
    end if ! xp1 < Re(alf) < xp2
    
! xp2 < Re(alf) < xp3, exchange  3 <--> 6
    if((ralf.ge.xpw(2)).and.(ralf < xpw(3)))then 
      sgr(3) = sgm(6,Ms); Mmr(:,3) = Mm(:,6,Ms)
      sgr(6) = sgm(3,Ms); Mmr(:,6) = Mm(:,3,Ms)
      
      sgm(3,Ms)= sgr(3);  Mm(:,3,Ms) = Mmr(:,3);
      sgm(6,Ms)= sgr(6);  Mm(:,6,Ms) = Mmr(:,6); return                  
    end if ! xp1 < Re(alf) < xp2
 
    end
