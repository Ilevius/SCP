function RealPolesSW_dim(fname,key,fd1,fd2,nf)

% Real dispersion curves for PlateWax by lines -- dimensional

%   fname -  file with the pole data computed in RealPoles
 % key = 0 - wavenumbers; 1 - slowness    
% [fd1,fd2] - frequency range for the axis of abscissa [kHz]
%  nf - starting number of figure windows to be opened

% Call example: RealPolesSW_dim('fs_Steel.dat',1,0,200,1)

% units
f0 = 310;   % kHz 
v0 = 3.1;   % km/s
s0 = 1/v0; % s/km
l0 = 10; % mm

% dimensionless
 % f0 = 1;   % kHz 
% v0 = 1;   % km/s
% s0 = 1; % s/km
% l0 =  1; % mm

 f1 = fd1/f0;  f2 = fd2/f0;  % dimensionless frequencies

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

fid=fopen(fname,'rt');   a(1:10)=0;  sa(1:3)=0;

%  file size estimation, array formatting
is = 0;  st=fgetl(fid);
for it=1:1000000
   st=fgetl(fid);   a = sscanf(st,'%f');     if a(1) < 0;   is = is+1;   end
   if is == 2; break; end
end

Nf = it-1;  % number of lines in the file
ff(1:Nf)=0.;  sl(1:Nf)=0.; dz(1:Nf)=0.; 
frewind(fid);

%read data from the file into arrays

% body wave slownesses 
 st=fgetl(fid);  st=fgetl(fid);  ma = sscanf(st,'%f');
 Ms = ma(1); 
 sp(1:Ms)=0;  ss1(1:Ms)=0; ss2(1:Ms)=0;
 for m=1:Ms
     st=fgetl(fid);   sa = sscanf(st,'%f'); 
     sp(m)=sa(1);  ss1(m)=sa(2);  ss2(m)=sa(3);
 end 
     
 % frequency plot
 
% n cycle
n = 1;
while n > 0
    f=1; it=0;
    st=fgetl(fid);    na = sscanf(st,'%f');  n=na(1); 
    if n < 0; break; end;  a(1:10)=0;   
     
    while f > 0
     
        st=fgetl(fid);    a = sscanf(st,'%f');  f=a(1);   s=a(2);    
 
        if((f > f1-1d-8) && (f < f2+1d-8))      
           it = it+1; ff(it) = a(1)*f0;  
           if key ==0; dz(it) =2*pi*f*s/l0; end
           if key ==1; sl(it) =s*s0; end
        end
         
    end % while f > 0
      
    Nf = it; if(Nf > 0)
        if key == 0  % wavenumbers
           plot(ff(1:Nf),dz(1:Nf),'LineStyle','-','Color',LC{n},'LineWidth',2) ;  hold on          
 %           plot(2*pi*ff(1:Nf),dz(1:Nf),'LineStyle','-','Color',LC{n},'LineWidth',2) ;  hold on          
       end 
      
        if key == 1  % slownesses
          plot(ff(1:Nf),sl(1:Nf),'LineStyle','-','Color',LC{n},'LineWidth',2) ;  hold on          
 %          plot(ff(1:Nf),sl(1:Nf),'.','Markersize',12) ;  hold on          
        end
    end % Nf > 0
      
end % while n > 0

 x(1) = fd1; x(2) = fd2;    v=axis; 
 if key == 0  % wavenumbersf 
     axis([x(1),x(2),0.,v(4)]); 
 end
 
 if key == 1  % slownesses
 % axis([x(1),x(2),0.,v(4)]); 
  axis([x(1),x(2),0.,1.5]); 
 end
     
    xlabel('frequency f [kHz]')
  if key == 0  ylabel('wavenumbers  \zeta_n [1/mm]');   end
  if key == 1  ylabel('slownesses   s_n [s/km]');   end
   
 % body wave levels
    for m = 1:Ms
        mstr = num2str(m);   
         
       Vp_str=strcat('{p}' ,mstr);     % Vp_str=strcat('{\kappa_p}' ,mstr);                                                 
         if key == 0 y(1)=2*pi*f1*sp(m)/l0; y(2)=2*pi*f2*sp(m)/l0; end
         if key == 1 y(1)=sp(m)*s0; y(2)=y(1); end
         
         plot(x,y,'k--'); hold on;   text(1.002*x(2),y(2),Vp_str,'FontSize',13,'FontName',FontName)  
         
         Vs_str=strcat('{s}' ,mstr);    % Vs_str=strcat('{\kappa_s}' ,mstr);            
         if key == 0 y(1)=2*pi*f1*ss1(m)/l0; y(2)=2*pi*f2*ss1(m)/l0; end
         if key == 1 y(1)=ss1(m)*s0; y(2)=y(1); end

         plot(x,y,'k--'); hold on;    text(1.002*x(2),y(2),Vs_str,'FontSize',13,'FontName',FontName)
        
    end % m
    
fclose(fid);