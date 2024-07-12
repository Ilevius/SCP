  function SurfK(Kij,nf)

% surface of |K_ij(f,sl)|

% Kij = 1,2,3 or 4 ==> K11, K31, K13 or K33; else --> empty array
% nf - number of figure window 

% call example SurfK(4,1)

% units
% f0 = 310;   % kHz 
% v0 = 3.1;   % km/s
% s0 = 1/v0; % s/km
% l0 = 10; % mm

% dimensionless
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
 
% read arrays

a(1:4) = 0;  
 fid=fopen('inp_Kij.dat','rt');
  st=fgetl(fid);   a=sscanf(st,'%f'); 
  Nf = a(1);  ff1 = a(2); ff2 = a(3); hff = a(4);
  for i = 1:Nf;     ff(i) = ff1 + (i-1)*hff;   end
 
  st=fgetl(fid);   a=sscanf(st,'%f'); 
  Nsl = a(1);  sl1 = a(2); sl2 = a(3); hsl = a(4);
   for j = 1:Nsl;     sl(j) = sl1 + (j-1)*hsl;   end
  
   st=fgetl(fid);   a=sscanf(st,'%f');  h2 = a(1);
  
% dimensioning
   ff = ff.*f0;   sl = sl.*s0;   h2 = h2*l0;
  
% surface |aK(f,sl)|  
  
  if Kij == 1;  aK = load('aK11.dat'); end    
  if Kij == 2;  aK = load('aK31.dat'); end    
  if Kij == 3;  aK = load('aK13.dat'); end    
  if Kij == 4;  aK = load('aK33.dat'); end    
      
  bK = transpose(aK);  
  
  h=surf(ff,sl, -bK); hold on;
  colormap hot;        %   colormap jet; 
  % colormap summer
  
  set(h,'EdgeColor','none');   view(0,90);
   
   v=axis; axis([ff1*f0,ff2*f0,sl1*s0,sl2*s0]); hold on
   
  h2str=num2str(h2);
 if Kij == 1;  titK = '   |\omegaK_{11}(f,sl)|'; end
 if Kij == 2;  titK = '   |\omegaK_{31}(f,sl)|'; end
 if Kij == 3;  titK = '   |\omegaK_{13}(f,sl)|'; end
 if Kij == 4;  titK = '   |\omegaK_{33}(f,sl)|'; end

  titS=strcat('h_2 = ',h2str,'  [mm],',titK); % h2, K_ij for title 
  title (titS,'FontSize',13);
  
 %   xlabel('frequency [kHz]')  
   xlabel('frequency [GHz]')  
   ylabel('slowness [s/km]')

   fclose(fid);  % fclose all
