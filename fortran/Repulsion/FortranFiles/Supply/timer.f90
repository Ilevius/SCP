! prints computing time between two 
! calls of this subroutine

Subroutine Timer
Implicit None
Integer*2 Hour1,Min1,Sec1,dSec,T,Hour2,Min2,Sec2
Common/T/T,Hour1,Min1,Sec1

  Call GetTim(Hour2,Min2,Sec2,dSec)

  If (T .Ne. 1962) Then
     Hour1 = Hour2
     Min1  = Min2
     Sec1  = Sec2
     T     = 1962
   Else
     If (Sec1 .Le. Sec2) Then
        Sec2 = Sec2 - Sec1
      Else
        Sec2 = 60 - Sec1 + Sec2
        Min2 = Min2 - 1
     End If
     If (Min1 .Le. Min2) Then
        Min2  = Min2 - Min1
        Hour2 = Hour2 - Hour1
      Else
        Min2  = 60 - Min1 + Min2
        Hour2 = Hour2 - Hour1 - 1
      End If
      T = 0
      Print 10, Hour2,Min2, Sec2
      Write(2,10) Hour2,Min2, Sec2
10    Format(2X,'computing time: ', I3,' hours', I3,' min.', I3, ' sec.')

  End If
Return
End
