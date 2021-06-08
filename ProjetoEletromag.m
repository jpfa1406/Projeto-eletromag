%% 
% Q1
Ir = 0.05;
Or = 0.15;
Nramos = 1;
Nvoltas = 5.25;
antA = spiralArchimedean('NumArms', Nramos, 'Turns', Nvoltas,  ...
    'InnerRadius', Ir, 'OuterRadius', Or, 'Tilt', 90);
show(antA)

% % --------------------------
%% 

% Q2
f = (30:0.09:44)*1e6;
imp = impedance(antA,f);
im = imag(imp);

plot(f,im)
ylim([-2200,2200])
grid on
xlabel('Frequencia [MHz]');
ylabel('Impedancia [ohms]');
title('Impedancia X Frequencia');

% % --------------------------
%% 

% Q3
antB = spiralArchimedean('NumArms', Nramos, 'Turns', Nvoltas,  ...
    'InnerRadius', Ir, 'OuterRadius', Or, 'Tilt', 90, 'TiltAxis', 'Y');
antA.TiltAxis = 'Y';


antAB = linearArray('Element',[antA antB]);
antAB.ElementSpacing= 0.3;
show(antAB);

% % --------------------------
%% 

% Q4 e Q5
ganhos = sparameters(antAB, f);
rfplot(ganhos,2,1,'abs');
xlabel('Frequencia [MHz]');
ylabel('Ganho');

% % --------------------------
%% 

% Q6
d = 0.1:0.05:0.5;
ganhos = zeros(length(d),length(f));
disp(length(d));
for i=1:length(d)
   antAB.ElementSpacing = i*0.05;
   ganhos(i,:) = rfparam(sparameters(antAB, f),2,1); 
   disp(i);
end
    
figure;
[X,Y] = meshgrid(f/1e6, d);
surf(X,Y,abs(ganhos),'EdgeColor','none'); 
view(150,20);
shading(gca,'interp');
axis tight;
xlabel('Frequencia [MHz]');
ylabel('Distancia [m]');
zlabel('Ganho');

% % --------------------------
%% 

% Q7
current(antA,37.8115e6);

% % --------------------------
%%      

% Q8
impedance(antA,f);
ylim([-2200,2200])
grid on




