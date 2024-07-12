! Global constants and arrays for PropRestore

    Module PropRest2_Glob
    implicit none
     
    integer Nexp,mt
    
    real(8), allocatable:: Ex(:), Ex1(:),Ex2(:), Ez(:),Ez1(:),Ez2(:), &
            muz(:),mz1(:),mz2(:),rhot(:),rh1(:),rh2(:), &
            hst(:),hs1(:),hs2(:), nux(:),nx1(:),nx2(:), &
            nuz(:),nz1(:),nz2(:)
             
   real(8) hv,fh1,fh2,hpol,lmb(50),fexp(50),PGw(7,3)

   integer, allocatable:: mEx(:),mEz(:),mmuz(:),mrhot(:),mhst(:), &
                         mnux(:),mnuz(:),ism(:)
   
   end module PropRest2_Glob
