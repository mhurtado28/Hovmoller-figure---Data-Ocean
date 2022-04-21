clc 
clear all 

%addpath("C:\CursoSerieTiempo\PRAC\DATA")
%addpath("C:\CursoSerieTiempo\PRAC\SUBR")


cd 'C:\CursoSerieTiempo'

%%
%TEMPERATURA SUPERFICIAL 

filetsm = ('g4.areaAvgTimeSeries.MODISA_L3m_SST_8d_4km_R2019_0_sst.20030101-20220101.74W_11N_73W_11N.nc');
ncdisp(filetsm)

%fecha
time_tsm = ncread (filetsm,'time');
time_tsm = double(time_tsm);
time_tsm=datenum(1970,01,01,0,0,time_tsm);
fechatsm=datevec(time_tsm);

%temperatura
temp = ncread(filetsm, 'MODISA_L3m_SST_8d_4km_R2019_0_sst')

%%VISUALIZACION

% Reorganiza la serie de tiempo
yy = unique(fechatsm(:,1));
mm = 1 : 13;
ny = length(yy);

ST = NaN(ny,13);
for k = 1 : ny
    iy = find( fechatsm(:,1)==yy(k) );
    m  = fechatsm(iy,2);
    ST(k,m) = temp(iy);
end

yc = 2002;
iy = find( yy >= yc );
yy = yy(iy);
ST = ST(iy,:);

mes = char('E','F','M','A','M','J','J','A','S','O','N','D'); 

% Visualiza la serie de tiempo
figure()
pcolor(mm,yy,ST)
title('Sea Surface Temperature (°C)')
shading faceted
colormap(jet(15))
colorbar( )
set(gca,"xtick",mm+0.5, "xticklabel",mes,"Linewidth",1,"fontsize",10,...
        "xlim",[1 13],"ytick",[2003:1:2021],"ylim",[2003,2021])





%%
% MAGNITUD VIENTO U. LEER ARCHIVOS DESCARGADOS
data1 = ('adaptor.mars.internal-1648301302.5747235-14608-6-3b94295e-8b4f-43ed-bea9-c13ada4f23a5.nc');
ncdisp(data1) %2000en-2002dic

data2 = ('adaptor.mars.internal-1648423185.5840676-3414-9-020e0efe-b91d-4d81-916c-44b0ee31d204.nc');
ncdisp(data2) %2003en-2004dic


data3 = ('adaptor.mars.internal-1648424736.229285-16865-5-2abb1292-78f2-4d4a-90de-6d7c110837ad.nc');
ncdisp(data3) %2005en-2010dic

data4 = ('adaptor.mars.internal-1648780296.090407-7833-6-24d86b40-4290-4db0-bd3e-e0b07e6fdc56.nc');
ncdisp(data4) %2011

data5 = ('adaptor.mars.internal-1647807516.7567246-29846-5-d6c70b37-14c6-42c1-bfd2-ec736b6d2d49.nc');
ncdisp(data5) %2012-2017

data6 = ('adaptor.mars.internal-1647797702.4552197-18981-5-ab30951c-cb39-4a80-bdcd-17962bdbcb49.nc');
ncdisp(data6) %2018-2022


%% time
time1 = ncread (data1,'time');
time1 = double(time1)
time1 = datenum(1900,1,1,time1,0,0);
fecha=datevec(time1);

time2 = ncread (data2,'time');
time2 = double(time2)
time2 = datenum(1900,1,1,time2,0,0);
fecha2=datevec(time2);

time3 = ncread (data3,'time');
time3 = double(time3)
time3 = datenum(1900,1,1,time3,0,0);
fecha3=datevec(time3);

time4 = ncread (data4,'time');
time4 = double(time4)
time4 = datenum(1900,1,1,time4,0,0);
fecha4=datevec(time4);

time5 = ncread (data5,'time');
time5 = double(time5)
time5 = datenum(1900,1,1,time5,0,0);
fecha5=datevec(time5);

time6 = ncread (data6,'time');
time6 = double(time6)
time6 = datenum(1900,1,1,time6,0,0);
fecha6=datevec(time6);

%EXTRAER VALORES DE MAGNITUD U
vec_u1 = ncread(data1, 'u');
vec_u2 = ncread(data2, 'u');
vec_u3 = ncread(data3, 'u');
vec_u4 = ncread(data4, 'u');
vec_u5 = ncread(data5, 'u');
vec_u6 = ncread(data6, 'u');


% EXTRAER las magnitudes en la posicion  2--> 11.30 y  3-->-73.95
u1 = vec_u1(2,3,:);
u2 = vec_u2(2,3,:);
u3 = vec_u3(2,3,:);
u4 = vec_u4(2,3,:);
u5 = vec_u5(2,3,:);
u6 = vec_u6(2,3,:);


%de 3D a 1D
[n,m,p] = size(u1)
u1 = reshape(u1,n*m,p)';

[n,m,p2] = size(u2)
u2 = reshape(u2,n*m,p2)';

[n,m,p3] = size(u3)
u3 = reshape(u3,n*m,p3)';

[n,m,p4] = size(u4)
u4 = reshape(u4,n*m,p4)';

[n,m,p5] = size(u5)
u5 = reshape(u5,n*m,p5)';

[n,m,p6] = size(u6)
u6 = reshape(u6,n*m,p6)';

u6(find(isnan(u6)))=[]


%UNIR VECTORES
u = [u1; u2; u3; u4; u5; u6]; % DEL AÑO 2000 AL 2010

fecha_u = [fecha; fecha2; fecha3; fecha4; fecha5; fecha6];

time_u = [time1; time2; time3; time4; time5; time6];


%HOMWOLLER Reorganiza la serie de tiempo
yyu = unique(fecha_u(:,1));
mmu = 1 : 13;
nyu = length(yyu);

STu = NaN(nyu,13);
for ku = 1 : nyu
    iyu = find( fecha_u(:,1)==yyu(ku) );
    mu  = fecha_u(iyu,2);
    STu(ku,mu) = u(iyu);
end

ycu = 2000;
iyu = find( yyu >= ycu );
yyu = yyu(iyu);
STu = STu(iyu,:);

mes = char('E','F','M','A','M','J','J','A','S','O','N','D'); 

% Visualiza HOVMOLLER
figure()
pcolor(mmu,yyu,STu)
title('WIND (U COMPONENT)')
shading faceted
colormap(jet(15))
colorbar( )
set(gca,"xtick",mmu+0.5, "xticklabel",mes,"Linewidth",2,"fontsize",12,...
        "xlim",[1 13],"ytick",[2000:1:2022],"ylim",[2000,2022])

%MAGNITUDES DE VIENTO U MAYORES A -0.5
tu  = -0.5;
STa = STu;
STa(STa<tu) = NaN;

figure()
pcolor(mmu,yyu,STa)
title('WIND (U Component)greater than -0.5')
shading faceted
colormap(jet(15))
colorbar()
set(gca,"xtick",mmu+0.5, "xticklabel",mes,"Linewidth",2,"fontsize",12,...
        "xlim",[1 13],"ytick",[2000:1:2021],"ylim",[2000,2021])



%%
%%DATOS LLUVIA; DATOS DE REANÁLISIS
%%-74.1028,11.228,-73.6798,11.4258
datlluvia = ('g4.areaAvgTimeSeries.TRMM_3B42_Daily_7_precipitation.20000101-20191231.74W_11N_73W_11N.nc');
ncdisp(datlluvia) 

%organiza fechas
time_llu = ncread (datlluvia,'time');
time_llu = double(time_llu)
time_llu = datenum(1970,1,1,0,0,time_llu)
fecha_llu=datevec(time_llu);

%extrae datos lluvia
lluvia = ncread(datlluvia,'TRMM_3B42_Daily_7_precipitation');

%HOMWOLLER Reorganiza la serie de tiempo
yyt = unique(fecha_llu(:,1));
mmt = 1 : 13;
nyt = length(yyt);

STt = NaN(nyt,13);
for kt = 1 : nyt
    iyt = find( fecha_llu(:,1)==yyt(kt) );
    mt  = fecha_llu(iyt,2);
    STt(kt,mt) = lluvia(iyt);
end

yct = 2000;
iyt = find( yyt >= yct );
yyt = yyt(iyt);
STt = STt(iyt,:);

mes = char('E','F','M','A','M','J','J','A','S','O','N','D'); 

% Visualiza HOVMOLLER
figure()
pcolor(mmt,yyt,STt)
title('PRECIPITATION RATE')
shading faceted
colormap(jet(15))
colorbar( )
set(gca,"xtick",mmt+0.5, "xticklabel",mes,"Linewidth",2,"fontsize",12,...
        "xlim",[1 13],"ytick",[2000:1:2021],"ylim",[2000,2021])
           
    
tb  = 1;
STb = STt;
STb(STb<tb) = NaN;

figure()
pcolor(mmt,yyt,STb)
title('PRECIPITATION RATE > 1')
shading faceted
colormap(jet(15))
colorbar()
set(gca,"xtick",mmu+0.5, "xticklabel",mes,"Linewidth",2,"fontsize",12,...
        "xlim",[1 13],"ytick",[2000:1:2021],"ylim",[2000,2021])   
    