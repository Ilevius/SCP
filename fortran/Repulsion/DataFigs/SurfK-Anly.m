  function SurfK(fname,nf)

% surface of |K_33(lmbd,f)|
% fname - the name of the input file
% nf - number of figure windows 

% call example SurfK('aK_33.dat',5)

  fid=fopen(fname,'rt');
  st=fgetl(fid);   Nn=sscanf(st,'%f'); 
  Nlb = Nn(1);  Nf = Nn(2);
  
  lmb(1:Nlb) = 0d0;  ff(1:Nf) = 0d0;  aK(1:Nf,1:Nlb)=0d0;
  sx(1:Nlb)=0d0; sy(1:Nf)=0d0;  ax(1:Nlb)=0d0; ay(1:Nf)=0d0;
  
   sx=fgetl(fid);  
   ax=sscanf(sx,'%f');  
   lmb(1:Nlb) = ax(1:Nlb);
   sy=fgetl(fid);   ff=sscanf(sy,'%f');
 
  for j=1:Nf
      st=fgetl(fid); ax=sscanf(st,'%f');
      for i=1:Nlb       
          if ax(i) > 0.5;    ax(i) = 0.5;    end
  %       if ax(i) > 0.25;    ax(i) = 0.25;    end
  %          if ax(i) > 1.;    ax(i) = 1.;    end
      end
      aK(j,1:Nlb) = ax(1:Nlb);
  end

 % Fig. No nf
   figure(nf); hold off
   
Fig=[];   %% fig handles. if Fig=[] or  Fig var doesn't exist then the function FigAttribute is for all of open figures
%% font style
FontName='Times New Roman'; %% font name 
FontSizeAx=14;  %% axes fontsize
FontSizeLbl=20; %% label fontsize
FontSizeTxt=16; %% text fontsize

if(~exist('Fig','var') | isempty(Fig)), Fig=findobj('type','figure'); end
Hax=findall(Fig,'type','axes');  if(isempty(Hax)), return; end;

if(exist('FontName','var')), set(Hax,'FontName',FontName); end;
if(exist('FontSizeAx','var')), set(Hax,'FontSize',FontSizeAx); end;
 
% surface |K_33|  in lambda-f
  
%   h=surf(lmb, ff, -aK); hold on;
    h=surf(lmb, ff, -aK); hold on;
  colormap hot;    %   colormap jet; 
  
   set(h,'EdgeColor','none');   view(0,90);
   
    v=axis; axis([v(1),v(2),v(3),v(4)]); hold on
   
   % experimental data

 % exp data for Pt-HSQ600-NW-Si, B112D15
exper = [2.7    0.810
2.7    1.142
4.     0.661   
4.     0.825   
5.85   0.523   
5.85   0.628   
8.5    0.386  
8.5    0.463   
11.    0.326
11.    0.427   
13.95  0.273   
13.95  0.383 ];

Nn = size(exper); Nt = Nn(1);

  plot(exper(:,1),1000*exper(:,2),'b.','Markersize',20) ;  hold on  %,'linewidth',3) %)     
  
%  title('HSQ/Si111, h = 1 micron ','FontSize',13)
 %title('Ni/HSQ-5/Si111, h1 = 0.015, h2 = 1 [micron] ','FontSize',13)
 %title('Pt/HSQ-5/Si111, h1 = 0.15, h2 = 0.25 [micron], |K_{33}(\lambda,f)| ','FontSize',13)

 % title('surface  |K_{33}(\lambda,f)| for Pt/HSQ400/Si without NWs','FontSize',13)
title('Pt/HSQ400NW/Si\_B098C15,  3-layer model','FontSize',13)

   xlabel('wavelength [micron]')
   ylabel('frequency [MHz]')  

   % surface |K_33|  in f-alf

%  figure(nf+1); hold off
   
 % bK = transpose(aK); 
  %    for i=1:Nlb       
   %      alf(i)  = 2*pi/ lmb(i);
    %  end
  
 % h=surf(ff,alf, -bK);
 % colormap hot;    %   colormap jet; 
% set(h,'EdgeColor','none');   view(0,90);
 
  % v=axis; axis([v(1),v(2),0,7]);
  
% xlabel('frequency [GHz]')
% ylabel('wavenumber [1/micron]')

fclose(fid);