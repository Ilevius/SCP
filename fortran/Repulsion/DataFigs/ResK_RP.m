function ResK_RP(fname,keyr,Kij,f1,f2,nf)

% Residues of a K_ij element for Repulsion
%                            (Kij = 1,2,3 or 4 ==> K11, K31, K13 or K33,   else --> stop)
% amplitudes of each mode absr_n = abs(ResK_ij,n) and their sum Abres = Sum(absr_n)

%   fname -  file with the pole data computed in RealPoles_SW 
%   keyr = 0 - absr and Abres together; 1 - only Abres; 
%            =  2 and any other - only modes absr; 
%   Kij = 1,2,3 or 4 ==> K11, K31, K13 or K33, else --> stop
%   [f1,f2] - frequency range for the axis of abscissa
%    nf - number of figure window to be opened

% Call example:  ResK_RP('fs.dat',0,4,0,0.5,3)

%  if (Kij < 1). or. (Kij > 4); pause; end -- ???

% dimension plots
 f0 = 1;   % kHz 
 v0 = 1;   % km/s
 s0 = 1; % s/km
 l0 =  1; % mm

% Fig. No nf
   figure(nf); hold off
   
Fig=[];   %% fig handles. if Fig=[] or  Fig var doesn't exist then the function FigAttribute is for all of open figures
%% font style
FontName='Times New Roman'; %% font name 
FontSizeAx=14;  %% axes fontsize
FontSizeLbl=20; %% label fontsize
FontSizeTxt=16; %% text fontsize

if(~exist('Fig','var') || isempty(Fig)), Fig=findobj('type','figure'); end
Hax=findall(Fig,'type','axes');  if(isempty(Hax)), return; end;

if(exist('FontName','var')), set(Hax,'FontName',FontName); end;
if(exist('FontSizeAx','var')), set(Hax,'FontSize',FontSizeAx); end;

% curve's number n
LC={'b','r',[0,128,0]/255,'m',[0,128,192]/255,'g',[128,0,0]/255,'b','r',[0,128,0]/255,'m',[0,128,192]/255,'g',[128,0,0]/255,'b','r',[0,128,0]/255,'m',[0,128,192]/255,'g',[128,0,0]/255,'b','r',[0,128,0]/255,'m','g','b','r',[0,128,0]/255,'m','g',[128,0,0]/255,'b','r',[0,128,0]/255,'m','g','b','r',[0,128,0]/255,'m','g','b','r',[0,128,0]/255,'m','g',[128,0,0]/255,'c','m','g',[0,128,0]/255,'g','b',[0,0,128]/255,[0,128,0]/255,'c','g',[0,128,192]/255,[128,0,128]/255,[0,0,128]/255,[0,128,0]/255,'g','c','k'};

%read data from the file into arrays
fid=fopen(fname,'rt');   a(1:10)=0;  sa(1:3)=0;

% body wave slownesses 
 st=fgetl(fid);  st=fgetl(fid);  ma = sscanf(st,'%f');
 Ms = ma(1); 
 sp(1:Ms)=0;  ss1(1:Ms)=0; ss2(1:Ms)=0;
 for m=1:Ms
     st=fgetl(fid);   sa = sscanf(st,'%f'); 
     sp(m)=sa(1);  ss1(m)=sa(2);  ss2(m)=sa(3);
 end 
     
 % frequency plot
 
 % grid and arrays for plots
 hf = 0.0001;  fi = [f1:hf:f2];  Ni = length(fi);  Abres(1:Ni) = 0; absr(1:Ni) = 0;
  
% n cycle over branches
n = 1;
while n > 0
    f=1; it=0;
    st=fgetl(fid);    a = sscanf(st,'%f');  n=a(1); 
    if n < 0; break; end
        
    while f > 0   
        st=fgetl(fid);    a = sscanf(st,'%f');  f=a(1);    %  f  s  K11 K31 K13 K33
 
        if((f > f1-1d-8) && (f < f2+1d-8))      
           it = it+1; ff(it) = a(1);  
           if Kij == 1; absr(it) =sqrt(a(3)^2 + a(4)^2);  end;    % |K_11|
           if Kij == 2; absr(it) =sqrt(a(5)^2 + a(6)^2);   end;   % |K_31|
           if Kij == 3; absr(it) =sqrt(a(7)^2 + a(8)^2);   end;   % |K_13|
           if Kij == 4; absr(it) =sqrt(a(9)^2 + a(10)^2); end;  % |K_33|
        end
         
    end % while f > 0
      
     if it < 3; continue; end 
     Nf = it; ff  = ff(1:Nf); absr = absr(1:Nf);
     
     if ff(1) > ff(2)
          C (1:Nf,1:2)= 0;    C = C(1:Nf,1:2);
          C(1:Nf,1) = ff(1:Nf);   C(1:Nf,2) = absr(1:Nf);
          B = sortrows(C);
          ff(1:Nf) = B(1:Nf,1);  absr(1:Nf) = B(1:Nf,2);
     end
     
 %    if n > 5 
 %        n
 %        figure(nf+1);  stem(ff(1:Nf));
 %    end
 
 Fn = griddedInterpolant(ff,absr,'spline');
   
% plot branch 
    if keyr ~= 1
          plot(ff(1:Nf)*f0,absr(1:Nf),'LineStyle','--','Color',LC{n},'LineWidth',2) ;  hold on          
    end
    
  % interpolating and adding 'absr' to 'Abres'
    
    % new grid xi
    i = 0; it = 0;   x1 = ff(1); x2 = ff(Nf);
    
    for i = 1:Ni
        f = fi(i);    % it = it+1;
        if (f >= x1) && (f <= x2)      %  && and|| are 'and' and 'or' operator for scalar statements
              Abres(i) = Abres(i) + Fn(f);
        end
    end % i
         
end  % while n > 0

if keyr <= 2
    
    i = Ni;    while Abres(i) < 1d-5
                   i = i-1;     end
    Abres(i+1:Ni) = Abres(i);
 
 % plot Abs(Res)
    plot(fi(1:Ni)*f0,Abres(1:Ni),'-b','LineWidth',2) ;  hold on          
end

 x(1) = f1; x(2) = f2;    v=axis; 
axis([x(1),x(2),0,0.1]); 
% axis([x(1),x(2),0,v(4)]); 
    
 xlabel('frequency f [MHz]')
 % xlabel('frequency f')
 
if (Kij == 1);  ylabel('response a_{11}')';  end  % K_11            
if (Kij == 2);  ylabel('response a_{13} = a_{31}')';  end  % K_31            
if (Kij == 3);  ylabel('response a_{13} = a_{31}')';  end  % K_13            
if (Kij == 4);  ylabel('response a_{33}')';  end  % K_33            

%     title('Al/Pol','FontName',FontName)
     title('Al/Pol10/Pol','FontName',FontName)
%    title('Al/Pol, perfect coupling','FontSize',13)

fclose(fid);