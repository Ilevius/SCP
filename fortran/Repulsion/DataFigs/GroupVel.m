function GroupVel(fname,f1,f2,nf)

% Real dispersion curves for Multi_ZGV by lines 

%   fname -  file with the pole data computed in RealPoles (fslown.dat)
% [f1,f2] - frequency range for the axis of abscissa [kHz]
%  nf - number of figure window to be opened

% Call example:  GroupVel('fs_AP.dat',0.,2,5)

% dimensional units
 f0 = 1;   % MHz 
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

fid=fopen(fname,'rt');   a(1:10)=0;

%  file size estimation, array formatting
is = 0;  st=fgetl(fid);
for it=1:1000000
   st=fgetl(fid);   a = sscanf(st,'%f');     if a(1) < 0;   is = is+1;   end
   if is == 2; break; end
end

ff(1:is)=0; al(1:is)=0; 

frewind(fid);

%read data from the file into arrays

% body wave slownesses 
 st=fgetl(fid);    st=fgetl(fid); a = sscanf(st,'%f');
 Ms = a(1); 
 sp(1:Ms)=0;  ss1(1:Ms)=0; ss2(1:Ms)=0;
 for m=1:Ms
     st=fgetl(fid);   a = sscanf(st,'%f'); 
     sp(m)=a(1);  ss1(m)=a(2);  ss2(m)=a(3);
 end 
      
% n cycle over branches
n = 1;
while n > 0
    f=1; it=0;
    st=fgetl(fid);    a = sscanf(st,'%f');  n=a(1); 
    if n < 0; break; end
        
    while f > 0
     
        st=fgetl(fid);    a = sscanf(st,'%f');  f=a(1); 
        alf=2*pi*f*a(2); 
 
        if((f > f1-1d-8) && (f < f2+1d-8))      
           it = it+1; ff(it) = a(1);  al(it) =alf;
        end
         
    end % while f > 0
      
 % numerical differentiation
    
    Nf = it; ff = ff(1:Nf); al = al(1:Nf);
 
  if(Nf > 2)
      
        if al(1) > al(Nf)
            at(1:Nf) = 0; ft(1:Nf) = 0;
            for it =1:Nf
                at(it) = al(Nf-it+1);
                ft(it) = ff(Nf-it+1);
            end
            ff = ft(1:Nf); al = at(1:Nf);                
        end  % al(1) > al(Nf)
      
        hal = (al(Nf) - al(1))/(Nf-1);  
   
       if hal > 0.0001;      hal = 0.0001;  end
        
        ali =[al(1):hal:al(Nf)]; Ni = length(ali); Ni1 = Ni - 1;
        
       for i = 2:Nf
            if al(i) > al(i-1); continue; end
               n
             ifail = i
             ff(i)
            al(i)
             break
        end
         
        ffi = interp1(al,ff,ali,'spline');      
  
% group velocity gr
% test 
Ni = Nf;  Ni1 = Ni - 1;
ali(1:Nf) = al(1:Nf);  ffi(1:Nf) = ff(1:Nf);
% test

        gr(1:Ni) = 0;    gr = gr(1:Ni) ;
  
        for is=1:Ni1;
            df  = ffi(is+1)-ffi(is);
            dal = ali(is+1)-ali(is);
       
            gr(is)=2*pi*df/dal;
        end
        gr(Ni) = gr(Ni1);

        plot(ffi(1:Ni)*f0,gr(1:Ni)*v0,'LineStyle','-','Color',LC{n},'LineWidth',2) ;  hold on          
                   
    end % Nf > 2
      
 end % while n > 0

 x(1) = f1; x(2) = f2;    v=axis; 
  axis([x(1),x(2),v(3),v(4)]);  
 % axis([x(1),x(2),-0.5,2]); 
  % axis([x(1),x(2),0,4]); 

    
 xlabel('frequency f [kHz]')
 ylabel('group velocity   v_n [km/s]')
 
%   title('Al/Pol','FontName',FontName)
    title('Al/Pol10/Pol','FontName',FontName)
% title('Al/Pol, perfect coupling','FontSize',13)

 
 % body wave levels
for m = 1:Ms
    mstr = num2str(m);   
         
    Vp_str=strcat('{p}' ,mstr);     % Vp_str=strcat('{\kappa_p}' ,mstr);                                                 
    y(1)=v0/sp(m); y(2)=y(1);          
    plot(x,y,'k--'); hold on;   text(1.002*x(2),y(2),Vp_str,'FontSize',13,'FontName',FontName)  
         
    Vs_str=strcat('{s}' ,mstr);    % Vs_str=strcat('{\kappa_s}' ,mstr);            
    y(1)=v0/ss1(m); y(2)=y(1);
    plot(x,y,'k--'); hold on;    text(1.002*x(2),y(2),Vs_str,'FontSize',13,'FontName',FontName)
       
    y(1) = 0;   y(2)=y(1);
    plot(x,y,'k-','LineWidth',0.5)
end % m
    
fclose(fid);