function ComplResponse_SW(fname,f1,f2,nf)

% Frequency responses C11 and C33 for SteelWax or Bones

%   fname -  file with the frequency spectra computed in Response ("resp.dat") 

%   [f1,f2] - frequency range for the axis of abscissa (for Bones in MHz)
%    nf - number of figure window to be opened

% Call example:  ComplResponse_SW('resp.dat',0,0.5,4)

% units SW
f0 = 1.;    % f0 = 0.310;   % MHz 
% v0 = 3.1;   % km/s
% s0 = 1/v0; % s/km
% l0 = 10; % mm

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
fid=fopen(fname,'rt');   a(1:5)=0;  

%  file size estimation, array formatting

is = 0;  
for it=1:1000000
   st=fgetl(fid);   a = sscanf(st,'%f');     if a(1) < 0;   is = is+1;   end
   if is == 2; break; end
end

ff(1:it)=0; c1(1:it)=0;  c3(1:it)=0;

frewind(fid);

% f-cycle

    f=1; it=0;
      
    while f > 0   
        st=fgetl(fid);    a = sscanf(st,'%f');  f=a(1);   %  f  cs  K11 K31 K13 K33
 
        if((f > f1-1d-8) && (f < f2+1d-8))      
           it = it+1; ff(it) = a(1);  c1(it)=sqrt(a(2)^2+a(3)^2);
                                                    c3(it)=sqrt(a(4)^2+a(5)^2);
%           it = it+1; ff(it) = a(1);  c1(it)=log(1+sqrt(a(2)^2+a(3)^2));
%                                                    c3(it)=log(1+sqrt(a(4)^2+a(5)^2));
       end % if
         
    end % while f > 0
      
   Nf = it; ff  = ff(1:Nf); c1 = c1(1:Nf); c3 = c3(1:Nf); 

   plot(ff(1:Nf)*f0,c1(1:Nf),'LineStyle','-','Color',LC{2},'LineWidth',2) ;  hold on          
   plot(ff(1:Nf)*f0,c3(1:Nf),'LineStyle','-','Color',LC{1},'LineWidth',2) ;  hold on          
    
% v=axis; axis([f1,f2,0,v(4)]); 
 axis([f1*f0,f2*f0,0,0.1]); 
    
 xlabel('frequency f [MHz]')
 ylabel('responses C_{1} and C_{3} ')             

fclose(fid);