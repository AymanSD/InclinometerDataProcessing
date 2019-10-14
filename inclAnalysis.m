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
T = [10 34 5.2;11 02 54.4];
T_GPS = T(:,1)*3600 + T(:,2)*60 + T(:,3);
%% define the Time
h= B(:,1);                          % hours
m= B(:,2);                          % Minutes
s= B(:,3);                          % Seconds
time = (h*3600)+(m*60)+s;           % Conversion to seconds
% t = zeros(9779,1);
% for h=2:9779;
%     t(h,1)= t(h-1,1)+0.2;
% end

for i=1:9779;
    t(i,1) = time(i,1)-time(1,1)+1.2;   % Time from inclinometer
end
disX=1000*tan(x/1000);              % Inclination in the the longitudinal axis
disY=-1000*tan(y/1000);              % Inclination in the the longitudinal axis
f1 = scatter(disX,disY);
title('Bridge Behaviour')
ylabel('Displacement in Y-axis(mm)'); xlabel('Displacement in X-axis(mm)');
axis([-0.001 0.002 -0.005 0.005])
% saveas(f1,'Bridge Behaviour','jpg');

figure; 
f2=plot(t,x,'b')
title('Raw Data')
ylabel('Inclination (mm)'); xlabel('Time(s)'); legend('Longitudinal Axis');
% saveas(f2,'raw data x','jpg');
figure; 
f3=plot(t,y,'r')
title('Raw Data')
ylabel('Inclination (mm)'); xlabel('Time(s)'); legend('Lateral Axis');
% saveas(f3,'raw data y','jpg');

%% Filtering the timeseries:

mean_samp_rate = 5.4;

x_filter = filter_2sides_highpass(disX);
y_filter = filter_2sides_highpass(disY);

figure();
f4 = plot(t,y_filter,'r');
hold on;plot(t,x_filter,'b');
title('Filtering: High pass Filter')
ylabel('Displacement(mm)'); xlabel('Time(s)'); legend('Lateral axis','Longitudinal axis');
% saveas(f4,'High pass Filter','jpg');
hold off

%% add events

timeAdjustmentFromVisual = [10 0 0 0 8 0 0 0 -6 0 0 0 4 0 5 0 5 4]';
eventsTimes = [517 578 590 635 675 702 826 879 965 1000 1063 1114 1200 ...
    1241 1345 1386 1485 1523]'
AdjustedEvents = eventsTimes+timeAdjustmentFromVisual+1.2;

figure,
% axis([AdjustedEvents(1,1)-10 AdjustedEvents(18)+10 -4 4])
% f5 = plot(t,y_filter,'r');
hold on 
plot(t,x_filter,'b')
for idx = 1 : numel(eventsTimes)
%     plot([eventsTimes(idx) eventsTimes(idx)], [-0.004 0.004],'k','LineWidth',2);
    plot([AdjustedEvents(idx) AdjustedEvents(idx)], [-4 4],'g','LineWidth',2);
end
title('Time Adjustment')
ylabel('Displacement(mm)'); xlabel('Time(s)'); legend('Lateral axis',...
    'Longitudinal axis','Excitation Limits Before Adjustment','Excitation Limits After Adjustment');
hold off
% saveas(f5,'Time Adjustment','jpg');

%% Cropping the 1st Excitation

row1 = find(t>=AdjustedEvents(1,1)-30 & t<=AdjustedEvents(2,1))+30;
size_row1 = size(row1);
time_crop1 = t(row1(1,1):row1(size_row1(1,1)));
x_crop1 = x_filter(row1(1,1):row1(size_row1(1,1)));
y_crop1 = y_filter(row1(1,1):row1(size_row1(1,1)));

%% Cropping the 2nd Excitation
row2 = find(t>=AdjustedEvents(3,1)-30 & t<=AdjustedEvents(4,1))+30;
size_row2 = size(row2);
time_crop2 = t(row2(1,1):row2(size_row2(1,1)));
x_crop2 = x_filter(row2(1,1):row2(size_row2(1,1)));
y_crop2 = y_filter(row2(1,1):row2(size_row2(1,1)));

%% Cropping the 3rd Excitation
row3 = find(t>=AdjustedEvents(5,1)-30 & t<=AdjustedEvents(6,1))+30;
size_row3 = size(row3);
time_crop3 = t(row3(1,1):row3(size_row3(1,1)));
x_crop3 = x_filter(row3(1,1):row3(size_row3(1,1)));
y_crop3 = y_filter(row3(1,1):row3(size_row3(1,1)));

%% Cropping the 4th Excitation
row4 = find(t>=AdjustedEvents(7,1)-30 & t<=AdjustedEvents(8,1))+30;
size_row4 = size(row4);
time_crop4 = t(row4(1,1):row4(size_row4(1,1)));
x_crop4 = x_filter(row4(1,1):row4(size_row4(1,1)));
y_crop4 = y_filter(row4(1,1):row4(size_row4(1,1)));

%% Cropping the 5th Excitation
row5 = find(t>=AdjustedEvents(9,1)-30 & t<=AdjustedEvents(10,1))+30;
size_row5 = size(row5);
time_crop5 = t(row5(1,1):row5(size_row5(1,1)));
x_crop5 = x_filter(row5(1,1):row5(size_row5(1,1)));
y_crop5 = y_filter(row5(1,1):row5(size_row5(1,1)));

%% Cropping the 6th Excitation
row6 = find(t>=AdjustedEvents(11,1)-30 & t<=AdjustedEvents(12,1))+30;
size_row6 = size(row6);
time_crop6 = t(row6(1,1):row6(size_row6(1,1)));
x_crop6 = x_filter(row6(1,1):row6(size_row6(1,1)));
y_crop6 = y_filter(row6(1,1):row6(size_row6(1,1)));

%% Cropping the 7th Excitation
row7 = find(t>=AdjustedEvents(13,1)-30 & t<=AdjustedEvents(14,1))+30;
size_row7 = size(row7);
time_crop7 = t(row7(1,1):row7(size_row7(1,1)));
x_crop7 = x_filter(row7(1,1):row7(size_row7(1,1)));
y_crop7 = y_filter(row7(1,1):row7(size_row7(1,1)));

%% Cropping the 8th Excitation
row8 = find(t>=AdjustedEvents(15,1)-30 & t<=AdjustedEvents(16,1))+30;
size_row8 = size(row8);
time_crop8 = t(row8(1,1):row8(size_row8(1,1)));
x_crop8 = x_filter(row8(1,1):row8(size_row8(1,1)));
y_crop8 = y_filter(row8(1,1):row8(size_row8(1,1)));

%% Cropping the 9th Excitation
row9 = find(t>=AdjustedEvents(17,1)-30 & t<=AdjustedEvents(18,1))+30;
size_row9 = size(row9);
time_crop9 = t(row9(1,1):row9(size_row9(1,1)));
x_crop9 = x_filter(row9(1,1):row9(size_row9(1,1)));
y_crop9 = y_filter(row9(1,1):row9(size_row9(1,1)));

Sizes = [0 0;size(x_crop1);size(x_crop2);size(x_crop3);size(x_crop4);size(x_crop5);size(x_crop6);size(x_crop7);size(x_crop8);size(x_crop9)];

%% Plotting Excitation periods

x_crop_total =[x_crop1 x_crop2 x_crop3 x_crop4 x_crop5 x_crop6 x_crop7 x_crop8 x_crop9];
y_crop_total =[y_crop1 y_crop2 y_crop3 y_crop4 y_crop5 y_crop6 y_crop7 y_crop8 y_crop9];
t_crop_total =[time_crop1;time_crop2;time_crop3;time_crop4;time_crop5;time_crop6;time_crop7;time_crop8;time_crop9];
Colors = ['g','g','g','r','r','r','b','g','r'];
Titles = ['1st Excitation';'2nd Excitation';'3rd Excitation';'4th Excitation';...
    '5th Excitation';'6th Excitation';'7th Excitation';'8th Excitation';'9th Excitation'];

for j = 1:9;
    Start(j,1)= sum(Sizes(1:j,2))+1; 
    End(j,1) = Start(j,1)-1+Sizes(j+1,2);
    
    %% Statistics

    Avrg_x(Start(j,1):End(j,1)) = mean(x_crop_total(Start(j,1):End(j,1)));
    Avrg_y(Start(j,1):End(j,1)) = mean(y_crop_total(Start(j,1):End(j,1)));
    sigma_x(j,1) = std(x_crop_total(Start(j,1):End(j,1)));
    sigma_y(j,1) = std(y_crop_total(Start(j,1):End(j,1)));
    Amp_x(Start(j,1):End(j,1)) = abs((Avrg_x(Start(j,1):End(j,1))+3*sigma_x(j,1))-...
        (Avrg_x(Start(j,1):End(j,1))-3*sigma_x(j,1)));
    Amp_y(Start(j,1):End(j,1)) = abs((Avrg_y(Start(j,1):End(j,1))+3*sigma_y(j,1))-...
        (Avrg_y(Start(j,1):End(j,1))-3*sigma_y(j,1)));
    
    %% Plotting 
    figure,
    P(j) = plot(t_crop_total(Start(j):End(j)),x_crop_total(Start(j,1):End(j,1)),'b')
    title(Titles(j,1:14))
    xlabel('Time (s)'); ylabel('inclination (mm)')
    hold on
    plot(t_crop_total(Start(j):End(j)),y_crop_total(Start(j,1):End(j,1)),'r')
    % Plotting the mean
    plot(t_crop_total(Start(j):End(j)),Avrg_x(Start(j,1):End(j,1)),'m')
    plot(t_crop_total(Start(j):End(j)),Avrg_y(Start(j,1):End(j,1)),'k')
    % Plotting the Confidence interval on X-axis
    plot(t_crop_total(Start(j):End(j)),Avrg_x(Start(j,1):End(j,1))+3*sigma_x(j),'g')
    plot(t_crop_total(Start(j):End(j)),Avrg_y(Start(j,1):End(j,1))+3*sigma_y(j),'c')
    % Plotting the Confidence interval on Y-axis
    plot(t_crop_total(Start(j):End(j)),Avrg_x(Start(j,1):End(j,1))-3*sigma_x(j),'g')
    plot(t_crop_total(Start(j):End(j)),Avrg_y(Start(j,1):End(j,1))-3*sigma_y(j),'c')
    
    legend('Longitudinal','Lateral','Mean_X','Mean_Y','99% confidence interval_X',...
       '99% confidence interval_Y','location','eastoutside')
   
   axis([AdjustedEvents(2*j-1) AdjustedEvents(2*j) -0.004 0.004])
   saveas(P(j),Titles(j,1),'jpg');
end

%%  Spectral Analysis: 1st Excitation

dt1 = mean(diff(t_crop_total(Start(1,1):End(1,1))));
nbr_freq1 = size(t_crop_total(Start(1,1):End(1,1)),1)/2;
[freqx1,Amplix1,Phasex1,ax1,bx1] = DFT(t_crop_total(Start(1,1):End(1,1)),...
    x_crop_total(Start(1,1):End(1,1))',dt1,nbr_freq1,0);
[freqy1,Ampliy1,Phasey1,ay1,by1] = DFT(t_crop_total(Start(1,1):End(1,1)),...
    y_crop_total(Start(1,1):End(1,1))',dt1,nbr_freq1,0);
figure, 
f6 = plot(freqx1,Amplix1,'b');
title('Spectral Analysis: 1st Excitation')
ylabel('Amplitude'); xlabel('Frequency (Hz)'); legend('Longitudinal Axis','Location','northeast');
axis([0 3 0 0.00015])
saveas(f6,'Spectral Analysis - 1st ExcitationX','jpg');
figure, 
f7 = plot(freqy1,Ampliy1,'r');
title('Spectral Analysis: 1st Excitation')
ylabel('Amplitude'); xlabel('Frequency (Hz)'); legend('Lateral Axis','Location','northeast');
axis([0 3 0 0.003])
saveas(f7,'Spectral Analysis - 1st ExcitationY','jpg');

%%  Spectral Analysis: 2nd Excitation

dt2 = mean(diff(t_crop_total(Start(2,1):End(2,1))));
nbr_freq2 = size(t_crop_total(Start(2,1):End(2,1)),1)/2;
[freqx2,Amplix2,Phasex2,ax2,bx2] = DFT(t_crop_total(Start(2,1):End(2,1)),...
    x_crop_total(Start(2,1):End(2,1))',dt2,nbr_freq2,0);
[freqy2,Ampliy2,Phasey2,ay2,by2] = DFT(t_crop_total(Start(2,1):End(2,1)),...
    y_crop_total(Start(2,1):End(2,1))',dt2,nbr_freq2,0);
figure, 
f8 = plot(freqx2,Amplix2,'b');
title('Spectral Analysis: 2nd Excitation')
ylabel('Amplitude'); xlabel('Frequency (Hz)'); legend('Longitudinal Axis','Location','northeast');
axis([0 3 0 0.00015])
saveas(f8,'Spectral Analysis - 2st ExcitationX','jpg');
figure, 
f9 = plot(freqy2,Ampliy2,'r');
title('Spectral Analysis: 2nd Excitation')
ylabel('Amplitude'); xlabel('Frequency (Hz)'); legend('Lateral Axis','Location','northeast');
axis([0 3 0 0.003])
saveas(f9,'Spectral Analysis - 2st ExcitationY','jpg');

%%  Spectral Analysis: 3rd Excitation

dt3 = mean(diff(t_crop_total(Start(3,1):End(3,1))));
nbr_freq3 = size(t_crop_total(Start(3,1):End(3,1)),1)/2;
[freqx3,Amplix3,Phasex3,ax3,bx3] = DFT(t_crop_total(Start(3,1):End(3,1)),...
    x_crop_total(Start(3,1):End(3,1))',dt3,nbr_freq3,0);
[freqy3,Ampliy3,Phasey3,ay3,by3] = DFT(t_crop_total(Start(3,1):End(3,1)),...
    y_crop_total(Start(3,1):End(3,1))',dt3,nbr_freq3,0);
figure, 
f10 = plot(freqx3,Amplix3,'b');
title('Spectral Analysis: 3rd Excitation')
ylabel('Amplitude'); xlabel('Frequency (Hz)'); legend('Longitudinal Axis','Location','northeast');
axis([0 3 0 0.00015]);
saveas(f10,'Spectral Analysis - 3st ExcitationX','jpg');
figure, 
f11 = plot(freqy3,Ampliy3,'r');
title('Spectral Analysis: 3rd Excitation')
ylabel('Amplitude'); xlabel('Frequency (Hz)'); legend('Lateral Axis','Location','northeast');
axis([0 3 0 0.003]);
saveas(f11,'Spectral Analysis - 3st ExcitationY','jpg');

%%  Spectral Analysis: 4th Excitation

dt4 = mean(diff(t_crop_total(Start(4,1):End(4,1))));
nbr_freq4 = size(t_crop_total(Start(4,1):End(4,1)),1)/2;
[freqx4,Amplix4,Phasex4,ax4,bx4] = DFT(t_crop_total(Start(4,1):End(4,1)),...
    x_crop_total(Start(4,1):End(4,1))',dt4,nbr_freq4,0);
[freqy4,Ampliy4,Phasey4,ay4,by4] = DFT(t_crop_total(Start(4,1):End(4,1)),...
    y_crop_total(Start(4,1):End(4,1))',dt4,nbr_freq4,0);
figure, 
f12 = plot(freqx4,Amplix4,'b');
title('Spectral Analysis: 4th Excitation')
ylabel('Amplitude'); xlabel('Frequency (Hz)'); legend('Longitudinal Axis','Location','northeast');
axis([0 3 0 0.00015])
saveas(f12,'Spectral Analysis - 4st ExcitationX','jpg');
figure, 
f13 = plot(freqy4,Ampliy4,'r');
title('Spectral Analysis: 4th Excitation')
ylabel('Amplitude'); xlabel('Frequency (Hz)'); legend('Lateral Axis','Location','northeast');
axis([0 3 0 0.003]);
saveas(f13,'Spectral Analysis - 4st ExcitationY','jpg');

%%  Spectral Analysis: 5th Excitation

dt5 = mean(diff(t_crop_total(Start(5,1):End(5,1))));
nbr_freq5 = size(t_crop_total(Start(5,1):End(5,1)),1)/2;
[freqx5,Amplix5,Phasex5,ax5,bx5] = DFT(t_crop_total(Start(5,1):End(5,1)),...
    x_crop_total(Start(5,1):End(5,1))',dt5,nbr_freq5,0);
[freqy5,Ampliy5,Phasey5,ay5,by5] = DFT(t_crop_total(Start(5,1):End(5,1)),...
    y_crop_total(Start(5,1):End(5,1))',dt5,nbr_freq5,0);
figure, 
f14 = plot(freqx5,Amplix5,'b');
title('Spectral Analysis: 5th Excitation')
ylabel('Amplitude'); xlabel('Frequency (Hz)'); legend('Longitudinal Axis','Location','northeast');
axis([0 3 0 0.00015])
saveas(f14,'Spectral Analysis - 5st ExcitationX','jpg');
figure,
f15 = plot(freqy5,Ampliy5,'r');
title('Spectral Analysis: 5th Excitation')
ylabel('Amplitude'); xlabel('Frequency (Hz)'); legend('Lateral Axis','Location','northeast');
axis([0 3 0 0.003]);
saveas(f15,'Spectral Analysis - 5st ExcitationY','jpg');

%%  Spectral Analysis: 6th Excitation

dt6 = mean(diff(t_crop_total(Start(6,1):End(6,1))));
nbr_freq6 = size(t_crop_total(Start(6,1):End(6,1)),1)/2;
[freqx6,Amplix6,Phasex6,ax6,bx6] = DFT(t_crop_total(Start(6,1):End(6,1)),...
    x_crop_total(Start(6,1):End(6,1))',dt6,nbr_freq6,0);
[freqy6,Ampliy6,Phasey6,ay6,by6] = DFT(t_crop_total(Start(6,1):End(6,1)),...
    y_crop_total(Start(6,1):End(6,1))',dt6,nbr_freq6,0);
figure, 
f16 = plot(freqx6,Amplix6,'b');
title('Spectral Analysis: 6th Excitation')
ylabel('Amplitude'); xlabel('Frequency (Hz)'); legend('Longitudinal Axis','Location','northeast');
axis([0 3 0 0.00015])
saveas(f16,'Spectral Analysis - 6st ExcitationX','jpg');
figure, 
f17 = plot(freqy6,Ampliy6,'r');
title('Spectral Analysis: 6th Excitation')
ylabel('Amplitude'); xlabel('Frequency (Hz)'); legend('Lateral Axis','Location','northeast');
axis([0 3 0 0.003]);
saveas(f17,'Spectral Analysis - 6st ExcitationY','jpg');

%%  Spectral Analysis: 7th Excitation

dt7 = mean(diff(t_crop_total(Start(7,1):End(7,1))));
nbr_freq7 = size(t_crop_total(Start(7,1):End(7,1)),1)/2;
[freqx7,Amplix7,Phasex7,ax7,bx7] = DFT(t_crop_total(Start(7,1):End(7,1)),...
    x_crop_total(Start(7,1):End(7,1))',dt7,nbr_freq7,0);
[freqy7,Ampliy7,Phasey7,ay7,by7] = DFT(t_crop_total(Start(7,1):End(7,1)),...
    y_crop_total(Start(7,1):End(7,1))',dt7,nbr_freq7,0);
figure, 
f18 = plot(freqx7,Amplix7,'b');
title('Spectral Analysis: 7th Excitation')
ylabel('Amplitude'); xlabel('Frequency (Hz)'); legend('Longitudinal Axis','Location','northeast');
axis([0 3 0 0.00015])
saveas(f18,'Spectral Analysis - 7st ExcitationX','jpg');
figure, 
f19 = plot(freqy7,Ampliy7,'r');
title('Spectral Analysis: 7th Excitation')
ylabel('Amplitude'); xlabel('Frequency (Hz)'); legend('Lateral Axis','Location','northeast');
axis([0 3 0 0.003]);
saveas(f19,'Spectral Analysis - 7st ExcitationY','jpg');

%%  Spectral Analysis: 8th Excitation

dt8 = mean(diff(t_crop_total(Start(8,1):End(8,1))));
nbr_freq8 = size(t_crop_total(Start(8,1):End(8,1)),1)/2;
[freqx8,Amplix8,Phasex8,ax8,bx8] = DFT(t_crop_total(Start(8,1):End(8,1)),...
    x_crop_total(Start(8,1):End(8,1))',dt8,nbr_freq8,0);
[freqy8,Ampliy8,Phasey8,ay8,by8] = DFT(t_crop_total(Start(8,1):End(8,1)),...
    y_crop_total(Start(8,1):End(8,1))',dt8,nbr_freq8,0);
figure, 
f20 = plot(freqx8,Amplix8,'b');
title('Spectral Analysis: 8th Excitation')
ylabel('Amplitude'); xlabel('Frequency (Hz)'); legend('Longitudinal Axis','Location','northeast');
axis([0 3 0 0.00015])
saveas(f20,'Spectral Analysis - 8st ExcitationX','jpg');

figure, 
f21 = plot(freqy8,Ampliy8,'r');
title('Spectral Analysis: 8th Excitation')
ylabel('Amplitude'); xlabel('Frequency (Hz)'); legend('Lateral Axis','Location','northeast');
axis([0 3 0 0.003]);
saveas(f21,'Spectral Analysis - 8st ExcitationY','jpg');

%%  Spectral Analysis: 9th Excitation

dt9 = mean(diff(t_crop_total(Start(9,1):End(9,1))));
nbr_freq9 = size(t_crop_total(Start(9,1):End(9,1)),1)/2;
[freqx9,Amplix9,Phasex9,ax9,bx9] = DFT(t_crop_total(Start(9,1):End(9,1)),...
    x_crop_total(Start(9,1):End(9,1))',dt9,nbr_freq9,0);
[freqy9,Ampliy9,Phasey9,ay9,by9] = DFT(t_crop_total(Start(9,1):End(9,1)),...
    y_crop_total(Start(9,1):End(9,1))',dt9,nbr_freq9,0);
figure, 
f22 = plot(freqx9,Amplix9,'b');
title('Spectral Analysis: 9th Excitation')
ylabel('Amplitude'); xlabel('Frequency (Hz)'); legend('Longitudinal Axis','Location','northeast');
axis([0 3 0 0.00015])
saveas(f22,'Spectral Analysis - 9st ExcitationX','jpg');
figure, 
f23=plot(freqy9,Ampliy9,'r');
title('Spectral Analysis: 9th Excitation')
ylabel('Amplitude'); xlabel('Frequency (Hz)'); legend('Lateral Axis','Location','northeast');
axis([0 3 0 0.003]);
saveas(f23,'Spectral Analysis - 9st ExcitationY','jpg');
%% Time Difference
% figure
% plot(t,'o')
% figure,
% hist(x_filter);
% figure,
% hist(y_filter);
% figure,
% plot(t,x_filter,'g')
% hold on 
% plot(t, y_filter, 'r')
% figure,
% hist(hist(t,unique(t)))

