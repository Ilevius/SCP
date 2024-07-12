function ComplDispCurves(fname,key,f1,f2,nf)

% Plots Re and Im branches of dispersion curves (slownesses) for SteelWax and Bones results 

% fname - name of the file loaded for plotting (charachter)
% [f1,f2] - frequency range for the abscissa axis
% key = 1 - slowness, 2 - phase velocity, 0 - wavenumbers
%  nf - number of figure window to be opened
   
% Call example: ComplDispCurves('fcs.dat',1,0,0.5,1)

% file heading

fid=fopen(fname,'rt');
Charact=fgetl(fid); Comm=sscanf(Charact,'%f');
Charact=fgetl(fid); Comm=sscanf(Charact,'%f');
Charact=fgetl(fid); Comm=sscanf(Charact,'%f');
Charact=fgetl(fid); Comm=sscanf(Charact,'%f');

Int=fgetl(fid); MMs=sscanf(Int,'%f');  Ms = MMs(1);  ibot = MMs(2);

for m=1:Ms
% three lines of material constants for each sublayer
    mCij=fgetl(fid);   mC=sscanf(mCij,'%f'); 
    C_11(m)=mC(2); C_22(m)=mC(3); C_33(m)=mC(4);
   
    mCij=fgetl(fid);   mC=sscanf(mCij,'%f'); 
    C_12(m)=mC(1); C_13(m)=mC(2); C_23(m)=mC(3);
  
    mCij=fgetl(fid);   mC=sscanf(mCij,'%f'); 
    C_44(m)=mC(1); C_55(m)=mC(2); C_66(m)=mC(3) ;  tet(m)=mC(4) ;  rho(m)=mC(5); h(m)=mC(5);
     
    vp(m)=sqrt(C_11(m)/rho(m));
    vs1(m)=sqrt(C_44(m)/rho(m));
    vs2(m)=sqrt(C_66(m)/rho(m));

end % m

% Figure attributes
  figure(nf); hold off;  
   
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

% curve's number n
% LC={'b','r',[0,128,0]/255,'m',[0,128,192]/255,'g',[128,0,0]/255,'b','r',[0,128,0]/255,'m',[0,128,192]/255,'g',[128,0,0]/255,'b','r',[0,128,0]/255,'m',[0,128,192]/255,'g',[128,0,0]/255,'b','r',[0,128,0]/255,'m','g','b','r',[0,128,0]/255,'m','g',[128,0,0]/255,'b','r',[0,128,0]/255,'m','g','b','r',[0,128,0]/255,'m','g','b','r',[0,128,0]/255,'m','g',[128,0,0]/255,'c','m','g',[0,128,0]/255,'g','b',[0,0,128]/255,[0,128,0]/255,'c','g',[0,128,192]/255,[128,0,128]/255,[0,0,128]/255,[0,128,0]/255,'g','c','k'};
% LC={'b','r',[0,128,0]/255,'m',[0,128,192]/255,'g',[128,0,0]/255,'r','b',[0,128,0]/255,'b','m',[0,128,192]/255,'g',[128,0,0]/255,'b','r',[0,128,0]/255,'m',[0,128,192]/255,'g',[128,0,0]/255,'b','r',[0,128,0]/255,'m','g','b','r',[0,128,0]/255,'m','g',[128,0,0]/255,'b','r',[0,128,0]/255,'m','g','b','r',[0,128,0]/255,'m','g','b','r',[0,128,0]/255,'m','g',[128,0,0]/255,'c','m','g',[0,128,0]/255,'g','b',[0,0,128]/255,[0,128,0]/255,'c','g',[0,128,192]/255,[128,0,128]/255,[0,0,128]/255,[0,128,0]/255,'g','c','k'};
 LC={'b','r',[0,128,0]/255,'m',[200,128,192]/255,'g','b','r',[0,128,0]/255,'m',[0,128,192]/255,'g','b','r',[0,128,0]/255,'m',[0,128,192]/255,'g','b','r',[0,128,0]/255,'m',[0,128,192]/255,'g','b','r',[0,128,0]/255,'m',[0,128,192]/255,'g'};

  Nc=fgetl(fid); n=sscanf(Nc,'%f');

% n cycle
while n > 0
    f=1; iw=0;
    while f > 0
      st=fgetl(fid);
      a = sscanf(st,'%f'); f=a(1);   
     
      if((f > f1-1d-8) && (f < f2+1d-8))       
          iw=iw+1; ft(iw)=f; re(iw)=a(2);   im(iw)=abs(a(3));    % dimensional    
      end;  % if f
    
    end; % while f > 0
 
 % plotting curves

 % slowness 
      if(key == 1)  
          plot(ft(1:iw),re(1:iw),'LineStyle','-','Color',LC{n},'LineWidth',2)  % Re s_n(f))
          hold on    
          plot(ft(1:iw),-im(1:iw),'LineStyle','--','Color',LC{n},'LineWidth',2)  % Im s_n(f))          
      end  % key = 1,  slowness
 
% phase velocities 
      if(key == 2)  
        for jj=1:iw
          cv(jj) = 1/(re(jj)+1i*im(jj));
          re(jj) = real(cv(jj));   im(jj) = imag(cv(jj));
        end % jj
  
          plot(ft(1:iw),re(1:iw),'LineStyle','-','Color',LC{n},'LineWidth',2)  % Re s_n(f))
          hold on    
          plot(ft(1:iw),-im(1:iw),'LineStyle','--','Color',LC{n},'LineWidth',2)  % Im s_n(f))
      end  % key = 2, phase velocities
      
      Nc=fgetl(fid); n=sscanf(Nc,'%f');
    
end % while n > 0

% horisonal lines
 
    x(1)=f1; x(2)=f2;    v=axis;
    axis([x(1),x(2),0,3]);  
    
    xlabel('f [MHz]','FontSize',13,'FontName',FontName)  % 'FontName',Arial

    if key==1
        ylabel('-Im {\its}_n                   Slownesses {\its}_n  [s/km]               Re {\its}_n','FontSize',13,'FontName',FontName)
    end
    if key==2
        ylabel('-Im {\its}_n              Phase Velocity {\its}_n  [km/s]               Re {\its}_n','FontSize',13,'FontName',FontName)
    end

if(key == 1) 
    for m = 1:Ms
         mstr = num2str(m);   Vs_str=strcat('{s}' ,mstr);                                                 
         y(1)=1/vs1(m); y(2)=y(1);
         plot(x,y,'k-'); hold on; text(1.002*x(2),y(2),Vs_str,'FontSize',13,'FontName',FontName)
  
        Vp_str=strcat('{p}' ,mstr);                                                 
        y(1)=1/vp(m); y(2)=y(1);
         plot(x,y,'k-'); hold on; text(1.002*x(2),y(2),Vp_str,'FontSize',13,'FontName',FontName)  
    end % m

end % key = 1 slowness

if(key == 2) 
    y(1)=vs1(Ms); y(2)=y(1);    % y(1)=vs(1);
    plot(x,y,'k-'); hold on; text(1.002*x(2),y(2),'{\it v_s}','FontSize',13,'FontName',FontName)

    y(1)=vp(Ms); y(2)=y(1);
    plot(x,y,'k-'); hold on; text(1.002*x(2),y(2),'{\it v_p}','FontSize',13,'FontName',FontName)
end % key = 2 phase velocities


%        title(' Ni/Si (M=2), half-space, h=5 [{\it \mu}m]','FontSize',13)
  
  y(1)=0; y(2)=y(1); plot(x,y,'k-'); hold on;
        
fclose(fid);

