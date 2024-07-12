function RealPoles_points(fname,f1,f2,nf)

% Real dispersion curves by points 

%   fname -  file with the pole data computed  RealPoles
              
% [f1,f2] - frequency range for the axis of abscissa
%  nf - starting number of figure windows to be opened

% Call example: RealPoles_points('rpoles.dat',0,1.2,1)

% key = 0 - wavenumbers; 1 - slowness, 2 - phase velocity; 3 - wavelength 
     key = 0;

% Figure attributes
  figure(nf); hold off;  % figure(nf+1); hold off
   
Fig=[];   %% fig handles. if Fig=[] or  Fig var doesn't exist then the function FigAttribute is for all of open figures
%% font style
%FontName='Times New Roman'; %% font name 
FontName='Arial'; %% font name 
FontSizeAx=14;  %% axes fontsize
FontSizeLbl=20; %% label fontsize
FontSizeTxt=16; %% text fontsize

if(~exist('Fig','var') | isempty(Fig)), Fig=findobj('type','figure'); end
Hax=findall(Fig,'type','axes');  if(isempty(Hax)), return; end;

if(exist('FontName','var')), set(Hax,'FontName',FontName); end;
if(exist('FontSizeAx','var')), set(Hax,'FontSize',FontSizeAx); end;

% data file, size estimation
fid=fopen(fname,'rt');   a(1:53)=0;

for it=1:1000000
   st=fgetl(fid);   a = sscanf(st,'%f');     if a(1) < 0;      break ;   end
end
frewind(fid);   Nf = it-1;  % number of lines in the file

% array formatting
ff(1:Nf)=0.;   Ndz(1:Nf ) = 0; sl(1:Nf,1:20)=0.; 

%read data from the file into arrays

% body wave slownesses 
 st=fgetl(fid);   a = sscanf(st,'%f');
 Ms = a(1); 
 sp(1:Ms)=0;  ss1(1:Ms)=0; ss2(1:Ms)=0;
 for m=1:Ms
     st=fgetl(fid);   a = sscanf(st,'%f'); 
     sp(m)=a(1);  ss1(m)=a(2);  ss2(m)=a(3);
 end 
     
 % frequency plot
for it=1:Nf
   st=fgetl(fid);   a = sscanf(st,'%f');   f=a(1);  % f -- frequency in GHz
    if f < 0;    break;   end
   
   if((f > f1-1d-8) && (f < f2+1d-8))      
      ff(it)=a(1);   % ff -- frequency in MHz
 %     ff(it)=1000*a(1);   % ff -- frequency in MHz
      nw=a(3); Ndz(it)=nw; sl(it,1:nw)=a(4:nw+3);
   end % if
end % it

% frequency-slowness
 figure(nf); hold off;  
 
for it=1:Nf        
   nw=Ndz(it); 
   if nw > 0
      plot(ff(it),sl(it,1:nw),'b.','Markersize',12);  hold on         
   end  % nw > 0
end  % it

 x(1)=f1; x(2)=f2;    
 % axis([x(1),x(2),0.,0.7]); v=axis; 
 axis([x(1),x(2),0.,1.5]); v=axis; 
    
 xlabel('frequency [MHz]')
 ylabel('slowness  [s/km]')
% title('Al/Pol, perfect coupling','FontSize',13)
 
 % body wave levels
    for m = 1:Ms
%       if or (m==1, m==Ms) 
        mstr = num2str(m);   
         
       Vp_str=strcat('{p}' ,mstr);     % Vp_str=strcat('{\kappa_p}' ,mstr);                                                 
        y(1)=sp(m); y(2)=y(1);
         plot(x,y,'k--'); hold on;   text(1.002*x(2),y(2),Vp_str,'FontSize',13,'FontName',FontName)  
         
         Vs_str=strcat('{s}' ,mstr);    % Vs_str=strcat('{\kappa_s}' ,mstr);            
         y(1)=ss1(m); y(2)=y(1);
         plot(x,y,'k--'); hold on;    text(1.002*x(2),y(2),Vs_str,'FontSize',13,'FontName',FontName)
        
%         y(1)=ss2(m); y(2)=y(1);
 %        plot(x,y,'k-'); hold on;   % text(1.002*x(2),y(2),Vs_str,'FontSize',13,'FontName',FontName)
%       end % if
    end % m

% title('Pt/HSQ400NW/Si\_B095C15,  3-layer model','FontSize',13)


fclose(fid);