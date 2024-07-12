function ComplResK_SW(fname,keyr,Kij,f1,f2,nf)

% Residues of a K_ij element from complex poles for SteelWax/Bones
%                            (Kij = 1,2,3 or 4 ==> K11, K31, K13 or K33,   else --> stop)
% amplitudes of each mode absr_n = abs(ResK_ij,n) and their sum Abres = Sum(absr_n)

%   fname -  file with the pole and residue data computed in CompleRes ("fcs_res.dat") 
%   keyr = 0 - absr and Abres together; 1 - only Abres; 
%            =  2 and any other - only modes absr; 
%   Kij = 1,2,3 or 4 ==> K11, K31, K13 or K33, else --> stop
%   [f1,f2] - frequency range for the axis of abscissa (for Bones in MHz)
%    nf - number of figure window to be opened

% Call example:  ComplResK_SW('fcs_res.dat',0,4,0,0.5,3)

%  if (Kij < 1). or. (Kij > 4); pause; end -- ???

% units SW
f0 = 0.310;   % MHz 
v0 = 3.1;   % km/s
s0 = 1/v0; % s/km
l0 = 10; % mm

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
fid=fopen(fname,'rt');   a(1:11)=0;  sa(1:3)=0; cc(1:6)=0;

% skip comments
st=fgetl(fid);  st=fgetl(fid); st=fgetl(fid);  st=fgetl(fid); 

% material characteristics (1+3*Ms) 
 st=fgetl(fid);  ma = sscanf(st,'%f'); Ms = ma(1); 
 for m=1:3*Ms
     st=fgetl(fid);  %  cc = sscanf(st,'%f'); 
   end 
     
 % frequency plot
 
 % grid and arrays for plots
% hf = 0.001;  fi = [f1:hf:f2]; Ni = length(fi);
 hf = 0.001;  fi = [f1:hf:f2]; Ni = length(fi);
 Abres(1:Ni) = 0; absr(1:Ni) = 0; 
 ff(1:Ni)=0;  rdz(1:Ni)=0;
  
% n cycle over branches

n = 1;
while n > 0
    f=1; it=0;
    st=fgetl(fid);    a = sscanf(st,'%f');  n=a(1); 
    if n < 0; break; end
        
    while f > 0   
        st=fgetl(fid);    a = sscanf(st,'%f');  f=a(1);   %  f  cs  K11 K31 K13 K33
 
        if((f > f1-1d-8) && (f < f2+1d-8))      
           it = it+1; ff(it) = a(1);  rdz(it) = 2*pi*f*a(2);
           if Kij == 1; absr(it) =sqrt(a(4)^2 + a(5)^2);  end;    % |K_11|
           if Kij == 2; absr(it) =sqrt(a(6)^2 + a(7)^2);   end;   % |K_31|
           if Kij == 3; absr(it) =sqrt(a(8)^2 + a(9)^2);   end;   % |K_13|
           if Kij == 4; absr(it) =sqrt(a(10)^2 + a(11)^2); end;  % |K_33|
        end
         
    end % while f > 0
      
     if it < 3; continue; end 
     Nf = it; ff  = ff(1:Nf); rdz = rdz(1:Nf); absr = absr(1:Nf); 
     
   %  if ff(1) > ff(2)
    %      C (1:Nf,1:2)= 0;    C = C(1:Nf,1:2);
    %      C(1:Nf,1) = rdz(1:Nf);   C(1:Nf,2) = absr(1:Nf);
    %      B = sortrows(C);
    %      rdz(1:Nf) = B(1:Nf,1);  absr(1:Nf) = B(1:Nf,2);
    % end
 %    Fn = griddedInterpolant(ff,absr,'spline');

% plot branch 
    if keyr ~= 1
          plot(ff(1:Nf),absr(1:Nf),'LineStyle','--','Color',LC{n},'LineWidth',2) ;  hold on          
    end
    
  % interpolating and adding 'absr' to 'Abres'

  if keyr <= 2
     Fnf = griddedInterpolant(rdz,ff,'spline');        % f = Fnf(dzt)
     Fns = griddedInterpolant(rdz,absr,'spline');  % Abres = Fns(dzt) 
       
 % new limits
    eps0 = 1d-20; x1 = min(ff)-eps0; x2 = max(ff)+eps0;
 
 % cycle over all fi(i) to sum Abres(i)   
    for i = 1:Ni
        f = fi(i);    % it = it+1;
        if (f >= x1) && (f <= x2)      %  && and|| are 'and' and 'or' operator for scalar statements
  
  % inner cycle over 'fi' to find all 'absr' contributing into Abres(i) at this f = fi(i)
  % [fj1, fj2] -- current interval (fj1 = fi(j-1),  fj2 = fi(j))
  % sf1 and sf2 -- goal function f-fj at these points
  
            fj1 = x1; sf1 = f-fj1;           
            for j = 1:Nf       
                fj2 = ff(j);  sf2 = f - fj2; 
  
% fi(i) == ff(j)              
                if abs(sf2) < 1d-20; 
                    Abres(i) = Abres(i) + absr(j); 
                end   % fi(i) == ff(j)     
                
               
                if sf1*sf2 < 0; 
                    if j == 1; dz1 = rdz(1); else
                                    dz1 = rdz(j-1);
                    end % j == 1
                    
                    dz2 = rdz(j);  %  dzt = (dz2 + dz1)/2;    ft = Fnf(dzt); sf = f - ft;    
                    dzt = (sf1*dz2 - sf2*dz1)/(sf1-sf2);
                                 
                    Abres(i) = Abres(i) + Fns(dzt);                 
                
                end % sf1*sf2 < 0
                
                sf1 = sf2;  % fj1 = fj2;
            end % j
            
        end  %  (f >= x1) && (f <= x2) 
    end % i
       
    i = Ni;    while Abres(i) < 1d-5
                   i = i-1;     end
    Abres(i+1:Ni) = Abres(i);
  end % if keyr <= 2
 
end  % while n > 0
  
 % plot Abs(Res)
  if keyr <= 2; 
      plot(fi(1:Ni),Abres(1:Ni),'-b','LineWidth',2) ;  hold on          
  end
  
% v=axis; axis([f1,f2,0,v(4)]); 
 axis([f1,f2,0,5]); 
    
 xlabel('frequency f [MHz]')

if (Kij == 1);  ylabel('response a_{11}')';  end  % K_11            
if (Kij == 2);  ylabel('response a_{31}')';  end  % K_31            
if (Kij == 3);  ylabel('response a_{13}')';  end  % K_13            
if (Kij == 4);  ylabel('response a_{33}')';  end  % K_33            

fclose(fid);