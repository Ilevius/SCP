
        complex function cvalp*16(x,a,np)
        complex*16 a(1),x,s
        
        n2=np+2
        s=0d0
        
         do i=1,np
          i1=n2-i
          s=(s+a(i1))*x
         end do
        cvalp=s+a(1)
        return
        end