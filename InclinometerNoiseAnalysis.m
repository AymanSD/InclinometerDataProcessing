%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%% Inclinometer Data Analysis%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; format long g; clc; close all

%% Loading Data
A=load('170322_Nivel 2.out');
B= A(199:9977,:);
x = B(:,4);                         % inclination on x-axis
y = B(:,5);                         % inclination on y-axis 
Temp = B(:,6);                      % Tempurature
t = zeros(9779,1);
for h=2:9779;
    t(h,1)= t(h-1,1)+0.2;
end
t = t + 1.2;
disX=1*tan(x/1000);              % Inclination in the the longitudinal axis
disY=-1*tan(y/1000);              % Inclination in the the longitudinal axis

%% Filtering the timeseries:

mean_samp_rate = 5.4;
x_filter = filter_2sides_highpass(disX);
y_filter = filter_2sides_highpass(disY);

%% Time Synchronisation

timeAdjustmentFromVisual = [10 0 0 0 8 0 0 0 -6 0 0 0 4 0 5 0 5 4]';
eventsTimes = [517 578 590 635 675 702 826 879 965 1000 1063 1114 1200 ...
    1241 1345 1386 1485 1523]';
AdjustedEvents = eventsTimes+timeAdjustmentFromVisual+1.2;


%% Cropping the 1st Excitation

row1 = find(t>=AdjustedEvents(2,1) & t<=AdjustedEvents(3,1));
size_row1 = size(row1);
time_crop1 = t(row1(1,1):row1(size_row1(1,1)));
x_crop1 = x_filter(row1(1,1):row1(size_row1(1,1)));
y_crop1 = y_filter(row1(1,1):row1(size_row1(1,1)));

%% Cropping the 2nd Excitation
row2 = find(t>=AdjustedEvents(4,1) & t<=AdjustedEvents(5,1));
size_row2 = size(row2);
time_crop2 = t(row2(1,1):row2(size_row2(1,1)));
x_crop2 = x_filter(row2(1,1):row2(size_row2(1,1)));
y_crop2 = y_filter(row2(1,1):row2(size_row2(1,1)));

%% Cropping the 3rd Excitation
row3 = find(t>=AdjustedEvents(6,1) & t<=AdjustedEvents(7,1));
size_row3 = size(row3);
time_crop3 = t(row3(1,1):row3(size_row3(1,1)));
x_crop3 = x_filter(row3(1,1):row3(size_row3(1,1)));
y_crop3 = y_filter(row3(1,1):row3(size_row3(1,1)));

%% Cropping the 4th Excitation
row4 = find(t>=AdjustedEvents(8,1) & t<=AdjustedEvents(9,1));
size_row4 = size(row4);
time_crop4 = t(row4(1,1):row4(size_row4(1,1)));
x_crop4 = x_filter(row4(1,1):row4(size_row4(1,1)));
y_crop4 = y_filter(row4(1,1):row4(size_row4(1,1)));

%% Cropping the 5th Excitation
row5 = find(t>=AdjustedEvents(10,1) & t<=AdjustedEvents(11,1));
size_row5 = size(row5);
time_crop5 = t(row5(1,1):row5(size_row5(1,1)));
x_crop5 = x_filter(row5(1,1):row5(size_row5(1,1)));
y_crop5 = y_filter(row5(1,1):row5(size_row5(1,1)));

%% Cropping the 6th Excitation
row6 = find(t>=AdjustedEvents(12,1) & t<=AdjustedEvents(13,1));
size_row6 = size(row6);
time_crop6 = t(row6(1,1):row6(size_row6(1,1)));
x_crop6 = x_filter(row6(1,1):row6(size_row6(1,1)));
y_crop6 = y_filter(row6(1,1):row6(size_row6(1,1)));

%% Cropping the 7th Excitation
row7 = find(t>=AdjustedEvents(14,1) & t<=AdjustedEvents(15,1));
size_row7 = size(row7);
time_crop7 = t(row7(1,1):row7(size_row7(1,1)));
x_crop7 = x_filter(row7(1,1):row7(size_row7(1,1)));
y_crop7 = y_filter(row7(1,1):row7(size_row7(1,1)));

%% Cropping the 8th Excitation
row8 = find(t>=AdjustedEvents(16,1)-30 & t<=AdjustedEvents(17,1))+30;
size_row8 = size(row8);
time_crop8 = t(row8(1,1):row8(size_row8(1,1)));
x_crop8 = x_filter(row8(1,1):row8(size_row8(1,1)));
y_crop8 = y_filter(row8(1,1):row8(size_row8(1,1)));

%% Fuse the Noise in one Matrix

Sizes = [0 0;size(x_crop1);size(x_crop2);size(x_crop3);size(x_crop4);size(x_crop5);size(x_crop6);size(x_crop7);size(x_crop8)];
x_crop_total =[x_crop1 x_crop2 x_crop3 x_crop4 x_crop5 x_crop6 x_crop7 x_crop8];
y_crop_total =[y_crop1 y_crop2 y_crop3 y_crop4 y_crop5 y_crop6 y_crop7 y_crop8];
t_crop_total =[time_crop1;time_crop2;time_crop3;time_crop4;time_crop5;time_crop6;time_crop7;time_crop8];
Titles = ['1st Noise Level';'2nd Noise Level';'3rd Noise Level';'4th Noise Level';...
    '5th Noise Level';'6th Noise Level';'7th Noise Level';'8th Noise Level'];
Displacements = ['Longitudinal' 'Lateral'];

%% Statistics
for j = 1:8;
    Start(j,1)= sum(Sizes(1:j,2))+1; 
    End(j,1) = Start(j,1)-1+Sizes(j+1,2);

    Avrg_x(Start(j,1):End(j,1)) = mean(x_crop_total(Start(j,1):End(j,1)));
    Avrg_y(Start(j,1):End(j,1)) = mean(y_crop_total(Start(j,1):End(j,1)));
    sigma_x(j,1) = std(x_crop_total(Start(j,1):End(j,1)));
    sigma_y(j,1) = std(y_crop_total(Start(j,1):End(j,1)));
    Amp_x(Start(j,1):End(j,1)) = abs((Avrg_x(Start(j,1):End(j,1))+3*sigma_x(j,1))-...
        (Avrg_x(Start(j,1):End(j,1))-3*sigma_x(j,1)));
    Amp_y(Start(j,1):End(j,1)) = abs((Avrg_y(Start(j,1):End(j,1))+3*sigma_y(j,1))-...
        (Avrg_y(Start(j,1):End(j,1))-3*sigma_y(j,1)));
    
    %% Plotting Lateral Component
    figure,
    P(j) = plot(t_crop_total(Start(j):End(j)),y_crop_total(Start(j,1):End(j,1)),'r');
    title(strcat(Titles(j,1:15),'-',Displacements(13:19)))
    xlabel('Time (s)'); ylabel('displacement (m)')
    hold on
    plot(t_crop_total(Start(j):End(j)),Avrg_y(Start(j,1):End(j,1)),'k','LineWidth',1)
    plot(t_crop_total(Start(j):End(j)),Avrg_y(Start(j,1):End(j,1))+3*sigma_y(j),'c','LineWidth',2)
    plot(t_crop_total(Start(j):End(j)),Avrg_y(Start(j,1):End(j,1))-3*sigma_y(j),'c','LineWidth',2)
    legend('Lateral','Mean','99% confidence interval','location','eastoutside')
    hold off
%     axis([limits(2*j-1) limits(2*j) -0.5 0.5])
%     saveas(P(j),Titles(j,1),'jpg');
    
    %% Plotting Longitudinal Component
   
    figure,
    k(j) = plot(t_crop_total(Start(j):End(j)),x_crop_total(Start(j,1):End(j,1)),'b');
    title(strcat(Titles(j,1:15),'-',Displacements(1:12)))
    xlabel('Time (s)'); ylabel('displacement (m)')
    hold on
    plot(t_crop_total(Start(j):End(j)),Avrg_x(Start(j,1):End(j,1)),'k','LineWidth',1)
    plot(t_crop_total(Start(j):End(j)),Avrg_x(Start(j,1):End(j,1))+3*sigma_x(j),'c','LineWidth',2)
    plot(t_crop_total(Start(j):End(j)),Avrg_x(Start(j,1):End(j,1))-3*sigma_x(j),'c','LineWidth',2)
    hold off
    legend('Longitudinal','Mean','99% confidence interval','location','eastoutside')
%     axis([limits(2*j-1) limits(2*j) -0.1 0.1])
%    saveas(P(j),Titles(j,1),'jpg');
end