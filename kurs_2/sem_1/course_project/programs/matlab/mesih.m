x = sort([(0:7)/7,.01 .02, .4 .5])
y = sort([(0:4)/4,.02 .05, .2 .32])
[xx,yy] = ndgrid(x,y); % ������ ������������� ����� � x-y ������������
z = franke(xx,yy);

mesh(x,y,z.');%������������ ������� ���������� �� �������� �����, ������� ������������ � ������� �������; ������� ���������� ����� ���� �������� � ���� ��������: "����� ������-������������" (�������� � Spline ToolBox) � � ����������� ��� ������ � ��� �������� ���������� MATLAB (��. ���������� � ����������� �������� � ������� ���������� ������� MATLAB: Mathematics: Sparse Matrices);
xlabel('x'); ylabel('y');
view(150,50);
title('Data from the Franke Function');
figure(2);%������������� ����������� B-��������� � ������ ���������� ���������
ky = 3;
knotsy = augknt([0,.25,.5,.75,1],ky);
sp = spap2(knotsy,ky,y,z);
yy = -.1:.05:1.1;
vals = fnval(sp,yy);
mesh(x,yy,vals.');
xlabel('x'); ylabel('y');
view(150,50);
title('Simultaneous Approximation to All Curves in the Y-Direction');
figure(3);
coefsy = fnbrk(sp,'c');
kx = 4;
knotsx = augknt(0:.2:1,kx)
sp2 = spap2(knotsx,kx,x,coefsy.');
coefs = fnbrk(sp2,'c').';
xv = 0:.025:1; yv = 0:.025:1;
values = spcol(knotsx,kx,xv)*coefs*spcol(knotsy,ky,yv).';
mesh(xv,yv,values.');
xlabel('x'); ylabel('y');
view(150,50);
title('The Spline Approximant');