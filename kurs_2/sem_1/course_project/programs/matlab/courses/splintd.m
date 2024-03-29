function splintd(action,s,ss)
% Spline interpolation Filtering Demo
% Detailed look in an information.
%
% Shelev@yahoo.com       

%       I.V.Shelevitsky 10-06-02
%       Revised  18/06/02
%       Copyright (c) 2002 by the Shelevitsky
%
   
if nargin==0,
   action = 'initialize';
end

switch action, 
case 'initialize',
   % Initialize Graphics

h0 = figure('Units','points', ...
        'NumberTitle','off',...
	'Color',[0.8 0.8 0.8], ...
	'PaperPosition',[18 180 576 432], ...
	'PaperUnits','points', ...
	'Position',[12 30.75 420 281.25], ...
	'Tag','Fig1', ...
        'Name','Spline interpolation Filtering Demo', ...  
	'ToolBar','none');
% Sliders
sl1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'ListboxTop',0, ...
	'Position',[0.823 0.8827 0.155 0.0533], ...
	'Style','slider', ...
        'Value',0.05,...
        'Min',0.001,'Max',0.25,...
        'CallBack','splintd(''recal'')',...
        'Tag','Slider1');
sl2 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'ListboxTop',0, ...
	'Position',[0.823 0.658 0.155 0.0533], ...
	'Style','slider', ...
        'Value',0.06,...
        'Min',0.001,'Max',0.2,...
        'CallBack','splintd(''recal'')',...
	'Tag','Slider2');

popstr1={'4' '6' '8' '10' '12' '14' '16'};
pm1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'ListboxTop',0, ...
	'Position',[0.823    0.7600    0.1054    0.0640], ...
	'SliderStep',[0.001 0.2], ...
        'String',popstr1,...
	'Style','popupmenu', ...
	'Tag','PopupMenu1', ...
        'UserData',str2double(popstr1),...
        'CallBack','splintd(''recal'')',... 
	'Value',3);

popstr2={'Hamming' 'Bartlett' 'Blackman' 'BoxCar' 'Hanning' 'Kaiser' 'Chebwin' 'Triang'};
pm2 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'ListboxTop',0, ...
	'Position',[0.823 0.53 0.157 0.069], ...
	'String',popstr2, ...
	'Style','popupmenu', ...
	'Tag','PopupMenu2', ...
        'UserData',popstr2,...
        'CallBack','splintd(''recal'')',... 
	'Value',1);

      uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'BackgroundColor',[0.75 0.75 0.75], ...
	'ListboxTop',0, ...
	'Position',[0.823 0.938 0.155 0.053], ...
	'String','Signal Fpass', ...
	'Style','text', ...
	'Tag','StaticText1');
      uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'ListboxTop',0, ...
	'Position',[0.823 0.826 0.151 0.053], ...
	'String','Interpolation', ...
	'Style','text', ...
	'Tag','StaticText2');
      uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'ListboxTop',0, ...
	'Position',[0.823 0.714 0.155 0.053], ...
	'String','Filter Fpass', ...
	'Style','text', ...
	'Tag','StaticText3');
      uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'ListboxTop',0, ...
	'Position',[0.823 0.6027 0.155 0.053], ...
	'String','Filter Window', ...
	'Style','text', ...
	'Tag','StaticText4');

e1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'ListboxTop',0, ...
	'Max',100, ...
	'Min',1, ...
	'Position',[0.823 0.475 0.05 0.053], ...
	'String','10', ...
	'Style','edit', ...
        'Enable','off', ...
	'Tag','EditText1', ...
        'CallBack','splintd(''edit1'')',... 
	'Value',10);
te1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'Position',[0.875 0.475 0.10 0.053], ...
	'String','b kaizer', ...
	'Style','text', ...
        'Enable','off', ...
	'Tag','StaticText4');

e2 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'ListboxTop',0, ...
	'Max',30, ...
	'Min',-30, ...
	'Position',[0.823 0.425 0.05 0.053], ...
	'String','6', ...
	'Style','edit', ...
        'Visible','on', ...
        'Enable','off', ...
	'Tag','EditText1', ...
        'CallBack','splintd(''edit2'')',... 
	'Value',6);
te2 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'Position',[0.875 0.425 0.10 0.053], ...
	'String','a chebwin', ...
	'Style','text', ...
        'Enable','off', ...
	'Tag','StaticText4');


rb1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'ListboxTop',0, ...
	'Position',[0.823 0.36 0.155 0.053], ...
	'String','B form spline', ...
	'Style','radiobutton', ...
        'value',1,'Userdata','b', ...
        'Callback','splintd(''radio'',1,''b'');', ...
	'Tag','Radiobutton1');
rb2 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'ListboxTop',0, ...
	'Position',[0.823 0.31 0.155 0.053], ...
	'String','Hermite spline', ...
	'Style','radiobutton', ...
        'Callback','splintd(''radio'',2,''h'');', ...
	'Tag','Radiobutton2');

pb0 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'ListboxTop',0, ...
	'Position',[0.823 0.22 0.156 0.08], ...
	'String','Base spline', ...
        'Callback','splintd(''spline'')', ...
	'Tag','Pushbutton0');
pb1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'ListboxTop',0, ...
	'Position',[0.823 0.12 0.156 0.08], ...
	'String','Info', ...
        'Callback','splintd(''info'')', ...
	'Tag','Pushbutton1');
pb2 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'ListboxTop',0, ...
	'Position',[0.823 0.02 0.156 0.08], ...
	'String','Close', ...
        'Callback','splintd(''done'')', ...
	'Tag','Pushbutton2');


    fss=0.05;
    fsp=0.06;
    iord=8;
    fwind='Hamming';
    fspl='b';
    bk=10;
    bc=6;
    [x,y,z,t,ti]=update_signal(fss,fsp,iord,fwind,bk,bc,fspl);

% Graphics
a1 = axes('Parent',h0, ...
	'Color',[1 1 1], ...
	'YLimMode','manual', ...
	'YLim',[-3 3], ...
	'Position',[0.023 0.690 0.775 0.248], ...
	'Tag','Axes1'); plot(t,x);
        axis([1,length(x),-3,3]);
         ttl1=title('Input signal');
   set(gca,'XTick',[])
a2 = axes('Parent',h0, ...
	'Color',[1 1 1], ...
	'YLimMode','manual', ...
	'YLim',[-3 3], ...
	'Position',[0.023 0.380 0.775 0.248], ...
	'Tag','Axes2'); plot(z);
        axis([1,length(z),-3,3]);
         ttl2=title('Spline interpolation signal');
   set(gca,'XTick',[])
a3 = axes('Parent',h0, ...
	'Color',[1 1 1], ...
	'YLimMode','manual', ...
	'YLim',[-2 2], ...
	'Position',[0.023 0.07 0.775 0.248], ...
	'Tag','Axes3'); plot(x-z);
        axis([1,length(x),-1,1]);
         ttl3=title('Error interpolation');

    hndlList=[sl1 sl2 pm1 pm2 rb1 rb2 a1 a2 a3 ttl1 ttl2 ttl3 e1 e2 te1 te2];
    set(h0,'UserData',hndlList);

    update_gui(fss,fsp,iord,fwind,bk,bc,fspl);

case 'recal',
    hndlList=get(gcf,'Userdata');
    fss=get(hndlList(1),'Value');
    fsp=get(hndlList(2),'Value');
    indx=get(hndlList(3),'Value');
    aord=get(hndlList(3),'Userdata');
    iord=aord(indx);
    indx=get(hndlList(4),'Value');
    aord=strvcat(get(hndlList(4),'Userdata'));
    fwind=aord(indx,:);
    fspl=get(hndlList(5),'Userdata');
    bk=get(hndlList(13),'Value');
    bc=get(hndlList(14),'Value');
    if strcmp(cellstr(fwind),'Kaiser')>0
       set(hndlList(13),'Enable','on');
       set(hndlList(15),'Enable','on');
    else
       set(hndlList(13),'Enable','off');
       set(hndlList(15),'Enable','off');
    end
    if strcmp(cellstr(fwind),'Chebwin')>0
       set(hndlList(14),'Enable','on');
       set(hndlList(16),'Enable','on');
    else
       set(hndlList(14),'Enable','off');
       set(hndlList(16),'Enable','off');
    end
    update_gui(fss,fsp,iord,fwind,bk,bc,fspl);

case 'radio',
    hndlList=get(gcf,'Userdata');
    for i=5:6,
      set(hndlList(i),'value',0)   % Disable all the buttons
    end
    set(hndlList(s+4),'value',1)   % Enable selected button
    set(hndlList(5),'Userdata',ss) % Remember selected button
    splintd('recal')
    return
case 'edit1'
    hndlList=get(gcf,'Userdata');
    bk=str2num(get(hndlList(13),'String'));
    set(hndlList(13),'Value',bk(1));
    set(hndlList(13),'String',num2str(bk));
    splintd('recal');
    return;
case 'edit2'
    hndlList=get(gcf,'Userdata');
    bk=str2num(get(hndlList(14),'String'));
    set(hndlList(14),'Value',bk(1));
    set(hndlList(14),'String',num2str(bk));
    splintd('recal');
    return;
case 'spline'
   nfig = figure('NumberTitle','off',...
         'Name','Spline interpolation Filtering');     
   tposition8 = [.77 .06 .19 .1];
   uicontrol(...
      'String','Close',...
      'Units','normalized',...
      'ForegroundColor','black',...
      'Position',tposition8,...
      'Callback','splintd(''done'')');

    hndlList=get(gcbf,'Userdata');
    fss=get(hndlList(1),'Value');
    fsp=get(hndlList(2),'Value');
    indx=get(hndlList(3),'Value');
    aord=get(hndlList(3),'Userdata');
    iord=aord(indx);
    indx=get(hndlList(4),'Value');
    aord=strvcat(get(hndlList(4),'Userdata'));
    fwind=aord(indx,:);
    fspl=get(hndlList(5),'Userdata');
    bk=get(hndlList(13),'Value');
    bc=get(hndlList(14),'Value');

    bx=fir1(512,fss*2);
    [hb,w]=freqz(bx,1,400); hb=20*log10(abs(hb)/abs(hb(1))); w=w/(2*pi);

   if iscell(fwind)
      fwind=fwind{1}
   end
   switch deblank(fwind), 
    case 'Hamming',
       b=fir1(iord*2,fsp*2); 
    case 'Bartlett',
       b=fir1(iord*2,fsp*2,bartlett(iord*2+1)); 
    case 'Blackman',
       b=fir1(iord*2,fsp*2,blackman(iord*2+1)); 
    case 'BoxCar',
       b=fir1(iord*2,fsp*2,boxcar(iord*2+1)); 
    case 'Hanning',
       b=fir1(iord*2,fsp*2,hanning(iord*2+1)); 
    case 'Kaiser',
       b=fir1(iord*2,fsp*2,kaiser(iord*2+1,bk)); 
    case 'Chebwin',
       b=fir1(iord*2,fsp*2,chebwin(iord*2+1,bc)); 
    case 'Triang'
       b=fir1(iord*2,fsp*2,triang(iord*2+1)); 
    otherwise
       b=fir1(iord*2,fsp*2); 
   end
   f1=b; 
   bf=crbspl(f1,f1);
   nrm=sum(bf); bf=bf/nrm;
   [ph,er]=preints(bf(2*iord+1),bf(iord+1));
   bh=toHermit(bf);
   hf=freqz(bf,1,400); hf=20*log10(abs(hf)/abs(hf(1)));
   hh=freqz(bh,1,400); hh=20*log10(abs(hh)/abs(hh(1)));
   [hp,wp]=freqz(ph,1,200); hp=20*log10(abs(hp)/max(abs(hp)));
   w=w'; hf=hf'; hb=hb'; wp=wp/(2*pi);
   ww=[w/iord];
   Hb=[hb];  
   for i=1:iord/2
     ww=[ww i/iord-fliplr(w/iord) i/iord+w/iord];  
     Hb=[Hb fliplr(hb) hb];
   end
   subplot('Position',[.07 .70 .65 .23]); plot(ww,Hb,w,hf,w,hh);
   axis([0 0.5 -120. 20.0]);
   ttl1=title('Spectrum signal and spline'); 
   subplot('Position',[.77 .70 .20 .23]); plot(wp,hp);
   axis([0 0.5 min(hp)0]);
   ttl2=title('Fr response preFIR');  
   subplot('Position',[.07 .36 .65 .23]); stem(bf);
   a=axis; a(1)=1; a(2)=4*iord; a(3)=min(bf)-max(bf)*0.05; a(4)=max(bf)*1.1; axis(a);
   ttl2=title('B spline');  set(gca,'XTick',[]);
   subplot('Position',[.77 .36 .20 .23]); stem(ph);
   axis([1 length(ph) min(ph)*1.1 max(ph)*1.1]);
   ttl2=title(['preFIR \delta=' num2str(abs(er),'%8.5f')]);  set(gca,'XTick',[]);
   subplot('Position',[.07 .05 .65 .23]); stem(bh);
   axis([1 4*iord min(bh)*0.1-0.1 1.1]);
   ttl2=title('Hermite spline');       
case 'info',
   hlpEng=['Not found'];
   hlpUkr=['Not found'];
   hlpRus=['Not found'];
   hlpStr=['']; 
   [df,mess]=fopen('splintd.txt','r');
   if df>0
      while 1
         line = fgetl(df);
         if ~isstr(line), break, end
         if strcmp(line,'$engl$')>0
            hlpEng=hlpStr;
            hlpStr=[' '];
            line='';
         end
         if strcmp(line,'$ukr$')>0
            hlpUkr=hlpStr;
            hlpStr=[' '];
            line='';
         end
         if strcmp(line,'$rus$')>0
            hlpRus=hlpStr;
            hlpStr=[' '];
            line='';
         end
         hlpStr=[hlpStr char(10) line];
      end
      fclose(df);
      hlpEng=withtxt(hlpEng,70);
      hlpUkr=withtxt(hlpUkr,70);
      hlpRus=withtxt(hlpRus,70);
      helpwin({'English. Others look in topics' hlpEng; ...
               'Ukraine. Others look in topics' hlpUkr; ...
               'Rusian.  Others look in topics' hlpRus },'Language');
   else
     helpwin(mess, 'splintd');
   end
   return
case 'done',
   close(gcf);
end        

function [x,y,z,t,ti]=update_signal(fss,fsp,iord,fwind,bk,bc,fspl)
%
%
r=normrnd(0,1,1,2048);
bx=fir1(512,fss*2);
x=filter(bx,1,r);
x=x/std(x);
y=x(1:iord:2048);
y=y(1:128);
if iscell(fwind)
   fwind=fwind{1};
end
switch deblank(fwind), 
  case 'Hamming',
       b=fir1(iord*2,fsp*2); 
  case 'Bartlett',
       b=fir1(iord*2,fsp*2,bartlett(iord*2+1)); 
  case 'Blackman',
       b=fir1(iord*2,fsp*2,blackman(iord*2+1)); 
  case 'BoxCar',
       b=fir1(iord*2,fsp*2,boxcar(iord*2+1)); 
  case 'Hanning',
       b=fir1(iord*2,fsp*2,hanning(iord*2+1)); 
  case 'Kaiser',
       b=fir1(iord*2,fsp*2,kaiser(iord*2+1,bk)); 
  case 'Chebwin',
       b=fir1(iord*2,fsp*2,chebwin(iord*2+1,bc)); 
  case 'Triang'
       b=fir1(iord*2,fsp*2,triang(iord*2+1)); 
  otherwise
       b=fir1(iord*2,fsp*2); 
end
bs=crbspl(b,b);
if strcmp(fspl,'b')
   z=bintfir(y,bs);
   x=x(64*iord-3*iord:128*iord-1-3*iord);
else
   bh=tohermit(bs);
   z=bintfir(y,bh,0);
   x=x(64*iord:128*iord-1);
end
t=1:length(x);
y=y(64:128);
ti=(0:64)*iord+1;
z=z(64*iord:128*iord-1);


function update_gui(fss,fsp,iord,fwind,bk,bc,fspl)
%
%
  [x,y,z,t,ti]=update_signal(fss,fsp,iord,fwind,bk,bc,fspl);
  hndlList=get(gcf,'Userdata');
  fss=get(hndlList(1),'Value');
  hd1 = get(hndlList(7),'Children');
  hd2 = get(hndlList(8),'Children');
  hd3 = get(hndlList(9),'Children');
  set(hd1,'XData',t);
  set(hd1,'YData',x);
  set(hd2,'XData',t);
  set(hd2,'YData',z);
  set(hd3,'XData',t);
  set(hd3,'YData',x-z);
  set(hndlList(10),'String',['Input signal Fpass=' num2str(fss,3) ' (' num2str(fss/iord,5) ')']);
  set(hndlList(11),'String',['Spline interpolation signal Fpass=' num2str(fsp,3)]);
  set(hndlList(12),'String',['Error interpolation \sigma=' num2str(std(x-z),3)]);

