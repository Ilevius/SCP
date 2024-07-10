MODULE tests
USE globals
USE ThreeLayerCase
IMPLICIT NONE


CONTAINS
    SUBROUTINE bottom_conditions
    IMPLICIT NONE
    integer i, j, pointsNum, interfaceNo
    real*8 alfaMin, alfaMax, alfaStep, kappa(2), theResult
    complex*16 alfa_c, G(12,2), T(2,4), P(4,4), E(4,4), sigma(3,2), temp_mat(4,4), Y(4,2), stress(2,2), Y_top(4,2), Y_bot(4,2), T_top(2,2), T_bot(2,2), &
        P_top, P_bot, R_top, R_bot, M_top, M_bot, S_top, S_bot
        open(4, file="C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\data\tests\top_conditions.txt", FORM='FORMATTED');
        open(1, file="C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\data\tests\bottom_conditions.txt", FORM='FORMATTED');
        open(2, file="C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\data\tests\YtopvsYbot.txt", FORM='FORMATTED');
        open(3, file="C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\data\tests\TtopvsTbot.txt", FORM='FORMATTED');
        write(2,'(A)') "% 1) alfa; 2) Ptop;  3) Rtop;  4) Mtop;  5) Stop;  6) Pbot;  7) Rbot;  8) Mbot; 9) Sbot. ... REAL OR IMAG OR ABS  "
        alfaMin = -1d0; alfaMax = 1d0; pointsNum = 200; w = 1.5d0;
        alfaStep = (alfaMax - alfaMin)/pointsNum;
        do i = 1, pointsNum
            alfa_c = cmplx(alfaMin + (i-1)*alfaStep)
            
            ! Проверка нагрузки на верхней границе волновода
            Y = makeY(1, alfa_c, z(1))
            T = makeT(alfa_c, lambda(1), mu(1))
            stress = abs(matmul(T, Y))
            write(4, '(5E15.6E3)') real(alfa_c), imag(stress(1,1)), imag(stress(1,2)), imag(stress(2,1)), imag(stress(2,2))
            
            ! Проверка нагрузки на нижней границе волновода
            Y = makeY(3, alfa_c, z(4))
            T = makeT(alfa_c, lambda(3), mu(3))
            stress = abs(matmul(T, Y))
            write(1, '(5E15.6E3)') real(alfa_c), real(stress(1,1)), real(stress(1,2)), real(stress(2,1)), real(stress(2,2)) 
            
            
            ! Проверка непрерывности смещений и напряжений на границе слоев
            interfaceNo = 2 
            Y_top = makeY(interfaceNo-1, alfa_c, z(interfaceNo)); 
            Y_bot = makeY(interfaceNo, alfa_c, z(interfaceNo));
            T = makeT(alfa_c, lambda(interfaceNo-1), mu(interfaceNo-1)); T_top = matmul(T, Y_top);
            T = makeT(alfa_c, lambda(interfaceNo), mu(interfaceNo)); T_bot = matmul(T, Y_bot);
            
            P_top = Y_top(1,1); P_bot = Y_bot(1,1); 
            R_top = Y_top(3,1); R_bot = Y_bot(3,1); 
            M_top = Y_top(1,2); M_bot = Y_bot(1,2); 
            S_top = Y_top(3,2); S_bot = Y_bot(3,2);
            
            write(2, '(10E15.6E3)') real(alfa_c), real(P_top), real(R_top), real(M_top), real(S_top), real(P_bot), real(R_bot), real(M_bot), real(S_bot)
            write(3, '(10E15.6E3)') real(alfa_c), real(T_top(1,1)), real(T_top(1,2)), real(T_top(2,1)), real(T_top(2,2)), real(T_bot(1,1)), real(T_bot(1,2)), real(T_bot(2,1)), real(T_bot(2,2))
        enddo 
        close(1); close(2); close(3);
        
        
        
    ! 2024-07-10 При переходе границ z=z2, z=z3 слоев нет скачка Y1, Y2, TY1, TY2    
    ! 2024-07-10 На верхней и нижней поверхностях все хорошо
        
    END SUBROUTINE bottom_conditions
    
    
END MODULE tests     