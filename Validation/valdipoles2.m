% RMS E-FIELD COMPARISON WITH 4NEC2  (valdipoles2)
% 
% Example showing the using the plot_field_slice1.m function
%
% In this case two 1GHz dipoles are placed 2*lambda apart on the x-y plane.
% The waves propagating from each dipole interfere with each other, causing 
% regions of wave reinforcement and wave cancellation.
%
% The same model has been run in 4NEC2 for comparision. From the graphs it
% can be seen that ArrayCalc's near-field calculation is quite accurate at
% a distance of 1*lambda (0.3m) from the dipoles.
%

close all
clc
help valdipoles2

init;                              % Initialise global variables
arraypwr_config=100;               % Set array power to 100W
arrayeff_config=100;               % Set array efficiency to 100%
freq_config=1e9;                   % Set frequency (Hz)
lambda=3e8/(freq_config);          % Calculate wavelength (m)
dipole_config=lambda/2;            % Set dipole length to lambda/2 (m)

% *********  Array definition **********

single_element(0,-1*lambda,0,'dipole',0,0);
single_element(0,+1*lambda,0,'dipole',0,0);
yrot_array(90,1,2);
zrot_array(90,1,2);

% *****  Plot geometry and patterns ****

plot_geom3d(1,0);      % Plot 3D geometry with axis (uses standard figure1)
view([140,40]);        % Select view
plot_geom3d1(1,1,20);  % Plot 3D geometry with axis and element excitations in figure 20
view([140,40]);         % Select view
axis equal;

list_array(0);         % List the array x,y,z locations and excitations only
norm_array;
list_array(0);

calc_directivity(10,10);


% ******** Field slice plot *********

dBrange_config=40;  % Set dynamic range for field slice plots (dB)

xrng=1;      % Dimension of slice in local x-direction (m)
yrng=xrng;   % Dimension of slice in local y-direction (m)
xsteps=100;  % Number of steps in x
ysteps=100;  % Number of steps in y
xrot=90;       % Rotation about x-axis (deg)
yrot=0;        % Rotation about y-axis (deg)
zrot=0;        % Rotation about z-axis (deg)
xoff=0;                   % Offset in x (m)
yoff=lambda*1;            % Offset in y (m)
zoff=0;                   % Offset in z (m)
polarisation='tot';     % Plot parameter (string)
normalise='no';         % Normalisation option (string)
units='vm';             % Display units (string)
fignum1=1;              % Figure number for plot in global coordinates (numeric)
fignum2=21;             % Figure number for plot in local/global coords as appropriate (numeric)

% Generate field-slice plots in global and local coordinates, fignum1 / fignum2   
[XGC,YGC,ZGC,XLC,YLC,ZLC,PlotData]=plot_field_slice1(xrng,xsteps,yrng,ysteps,xrot,yrot,zrot,...
   xoff,yoff,zoff,polarisation,normalise,units,fignum1,fignum2);    

% Fine tune the plots generated by plot_field_slice1

figure(fignum2);  % Select the figure for the slice-plot in local coordinates
warning off;      % Lots of grumbling from Matlab about color data and shading, but seems to work OK
shading flat;
caxis([0,250]);
colorbar;

figure(fignum1);  % Select the figure for the slice plot in global coordinates.
                  % In this case figure1 which already has the 3D array geometry on it.
axis equal;
warning off;     % Lots of grumbling from Matlab about color data and shading, but seems to work OK
shading flat;
caxis([0,250]);
colorbar;

% Modify the title for 3D geometry plot in figure(fignum1)
title('3D Geometry TOT Field Slice (RMS V/m) at Y=0.3m');

% Plot flux density profile along X-axis
[acX,acE1]=plot_line_slice(-xrng/2,yoff,0,+xrng/2,yoff,0,101,polarisation,normalise,units,fignum1,25);
% Plot flux density profile along Z-axis
[acY,acE2]=plot_line_slice(0,yoff,-yrng/2,0,yoff,+yrng/2,101,polarisation,normalise,units,fignum1,26);

% Data from 4NEC2 Dipoles.nec nearfield analysis
% **********************************************

% Xcut for Z=0

NECdata1=[-0.50        103.92
         -0.49        100.99
         -0.48         97.96
         -0.47         94.91
         -0.46         91.99
         -0.45         89.34
         -0.44         87.20
         -0.43         85.82
         -0.42         85.50
         -0.41         86.51
         -0.40         89.10
         -0.39         93.39
         -0.38         99.43
         -0.37        107.11
         -0.36        116.26
         -0.35        126.64
         -0.34        137.98
         -0.33        149.99
         -0.32        162.37
         -0.31        174.78
         -0.30        186.91
         -0.29        198.41
         -0.28        208.95
         -0.27        218.17
         -0.26        225.72
         -0.25        231.27
         -0.24        234.50
         -0.23        235.13
         -0.22        232.89
         -0.21        227.59
         -0.20        219.10
         -0.19        207.34
         -0.18        192.35
         -0.17        174.25
         -0.16        153.27
         -0.15        129.80
         -0.14        104.48
         -0.13         78.41
         -0.12         54.21
         -0.11         39.70
         -0.10         47.02
         -0.09         69.52
         -0.08         96.27
         -0.07        123.20
         -0.06        148.63
         -0.05        171.55
         -0.04        191.25
         -0.03        207.15
         -0.02        218.83
         -0.01        225.96
             0        228.36
          0.01        225.96
          0.02        218.83
          0.03        207.15
          0.04        191.25
          0.05        171.55
          0.06        148.63
          0.07        123.20
          0.08         96.27
          0.09         69.52
          0.10         47.02
          0.11         39.70
          0.12         54.21
          0.13         78.41
          0.14        104.48
          0.15        129.80
          0.16        153.27
          0.17        174.25
          0.18        192.35
          0.19        207.34
          0.20        219.10
          0.21        227.59
          0.22        232.89
          0.23        235.13
          0.24        234.50
          0.25        231.27
          0.26        225.72
          0.27        218.17
          0.28        208.95
          0.29        198.41
          0.30        186.91
          0.31        174.78
          0.32        162.37
          0.33        149.99
          0.34        137.98
          0.35        126.64
          0.36        116.26
          0.37        107.11
          0.38         99.43
          0.39         93.39
          0.40         89.10
          0.41         86.51
          0.42         85.50
          0.43         85.82
          0.44         87.20
          0.45         89.34
          0.46         91.99
          0.47         94.91
          0.48         97.96
          0.49        100.99
          0.50        103.92];
 
 necX=NECdata1(:,1);
 necE1=NECdata1(:,2);
 
 % Zcut for X=0
 
NECdata2=[-0.50         71.40
         -0.49         73.52
         -0.48         75.72
         -0.47         78.00
         -0.46         80.36
         -0.45         82.80
         -0.44         85.33
         -0.43         87.94
         -0.42         90.65
         -0.41         93.46
         -0.40         96.35
         -0.39         99.34
         -0.38        102.43
         -0.37        105.61
         -0.36        108.90
         -0.35        112.28
         -0.34        115.76
         -0.33        119.33
         -0.32        123.01
         -0.31        126.77
         -0.30        130.62
         -0.29        134.56
         -0.28        138.58
         -0.27        142.67
         -0.26        146.83
         -0.25        151.04
         -0.24        155.31
         -0.23        159.61
         -0.22        163.93
         -0.21        168.27
         -0.20        172.61
         -0.19        176.93
         -0.18        181.20
         -0.17        185.43
         -0.16        189.57
         -0.15        193.62
         -0.14        197.55
         -0.13        201.34
         -0.12        204.97
         -0.11        208.41
         -0.10        211.65
         -0.09        214.65
         -0.08        217.40
         -0.07        219.89
         -0.06        222.08
         -0.05        223.96
         -0.04        225.53
         -0.03        226.76
         -0.02        227.64
         -0.01        228.18
             0        228.36
          0.01        228.18
          0.02        227.64
          0.03        226.76
          0.04        225.53
          0.05        223.96
          0.06        222.08
          0.07        219.89
          0.08        217.40
          0.09        214.65
          0.10        211.65
          0.11        208.41
          0.12        204.97
          0.13        201.34
          0.14        197.55
          0.15        193.62
          0.16        189.57
          0.17        185.43
          0.18        181.20
          0.19        176.93
          0.20        172.61
          0.21        168.27
          0.22        163.93
          0.23        159.61
          0.24        155.31
          0.25        151.04
          0.26        146.83
          0.27        142.67
          0.28        138.58
          0.29        134.56
          0.30        130.62
          0.31        126.77
          0.32        123.01
          0.33        119.33
          0.34        115.76
          0.35        112.28
          0.36        108.90
          0.37        105.61
          0.38        102.43
          0.39         99.34
          0.40         96.35
          0.41         93.46
          0.42         90.65
          0.43         87.94
          0.44         85.33
          0.45         82.80
          0.46         80.36
          0.47         78.00
          0.48         75.72
          0.49         73.52
          0.50         71.40];
 
 necY=NECdata2(:,1);
 necE2=NECdata2(:,2);
 
figure(27);
hold on;
p1=plot(acX,acE1,'r','linewidth',2);
p2=plot(necX,necE1,'r+','linewidth',1);
p3=plot(acY,acE2,'b','linewidth',2);
p4=plot(necY,necE2,'b+','linewidth',1);

T1=sprintf('ACalc Xcut for Z=0');
T2=sprintf('4NEC2 Xcut for Z=0');
T3=sprintf('ACalc Zcut for X=0');
T4=sprintf('4NEC2 Zcut for X=0');

legend([p1,p2,p3,p4],T1,T2,T3,T4,4);
xlabel('Distance (m)')
ylabel('RMS E-field (V/m)');
title('TOT E-field along central axes of field-slice at Y=0.3m');
axis([-xrng/2 +xrng/2 0 250]);
hold on;
grid on
zoom on
set(gcf,'name','4NEC2 Comparison');