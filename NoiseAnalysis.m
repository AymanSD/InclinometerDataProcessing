%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%% Inclinometer Data Analysis%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; format long g; clc; close all

%% Loading Data
A=load('170322_Nivel 2.out');
B= A(199:9977,:);
x = B(:,4);                         % inclination on x-axis
y = B(:,5);                         % inclination on y-axis 
time = zeros(9779,1);
for h=2:9779;
    time(h,1)= time(h-1,1)+0.2;
end

disX=1000*tan(x/1000);              % Inclination in the the longitudinal axis
disY=-1000*tan(y/1000);              % Inclination in the the longitudinal axis

%% Filtering the timeseries:

mean_samp_rate = 5.4;

x_filter = filter_2sides_highpass(disX);
y_filter = filter_2sides_highpass(disY);

%% Setting Time limits
timeAdjustmentFromVisual = [10 0 0 0 8 0 0 0 -6 0 0 0 4 0 5 0 5 4]';
eventsTimes = [517 578 590 635 675 702 826 879 965 1000 1063 1114 1200 ...
    1241 1345 1386 1485 1523]'
AdjustedEvents = eventsTimes+timeAdjustmentFromVisual+1.2;
limit1 = AdjustedEvents;
limit2 = AdjustedEvents;
for h= 1:9;
    limit1(2*h-1,1) = AdjustedEvents(2*h-1,1)-60
    limit2(2*h,1) = AdjustedEvents(2*h,1)+60   
end


%% Noise (1)
row1 = find(time>=limit1(1,1) & time<=limit2(1,1));
size_row1 = size(row1);
time_crop1 = time(row1(1,1):row1(size_row1(1,1)));
x_crop1 = x_filter(row1(1,1):row1(size_row1(1,1)));
y_crop1 = y_filter(row1(1,1):row1(size_row1(1,1)));

%% Cropping the 2nd Noise
row2 = find(time>=limit1(2,1) & time<=limit2(2,1));
size_row2 = size(row2);
time_crop2 = time(row2(1,1):row2(size_row2(1,1)));
x_crop2 = x_filter(row2(1,1):row2(size_row2(1,1)));
y_crop2 = y_filter(row2(1,1):row2(size_row2(1,1)));

%% Cropping the 3rd Noise
row3 = find(time>=limit1(3,1) & time<=limit2(3,1));
size_row3 = size(row3);
time_crop3 = time(row3(1,1):row3(size_row3(1,1)));
x_crop3 = x_filter(row3(1,1):row3(size_row3(1,1)));
y_crop3 = y_filter(row3(1,1):row3(size_row3(1,1)));

%% Cropping the 4th Noise
row4 = find(time>=limit1(4,1) & time<=limit2(4,1));
size_row4 = size(row4);
time_crop4 = time(row4(1,1):row4(size_row4(1,1)));
x_crop4 = x_filter(row4(1,1):row4(size_row4(1,1)));
y_crop4 = y_filter(row4(1,1):row4(size_row4(1,1)));

%% Cropping the 5th Noise
row5 = find(time>=limit1(5,1) & time<=limit2(5,1));
size_row5 = size(row5);
time_crop5 = time(row5(1,1):row5(size_row5(1,1)));
x_crop5 = x_filter(row5(1,1):row5(size_row5(1,1)));
y_crop5 = y_filter(row5(1,1):row5(size_row5(1,1)));

%% Cropping the 6th Noise
row6 = find(time>=limit1(6,1) & time<=limit2(6,1));
size_row6 = size(row6);
time_crop6 = time(row6(1,1):row6(size_row6(1,1)));
x_crop6 = x_filter(row6(1,1):row6(size_row6(1,1)));
y_crop6 = y_filter(row6(1,1):row6(size_row6(1,1)));

%% Cropping the 7th Noise
row7 = find(time>=limit1(7,1) & time<=limit2(7,1));
size_row7 = size(row7);
time_crop7 = time(row7(1,1):row7(size_row7(1,1)));
x_crop7 = x_filter(row7(1,1):row7(size_row7(1,1)));
y_crop7 = y_filter(row7(1,1):row7(size_row7(1,1)));

%% Cropping the 8th Noise
row8 = find(time>=limit1(8,1) & time<=limit2(8,1));
size_row8 = size(row8);
time_crop8 = time(row8(1,1):row8(size_row8(1,1)));
x_crop8 = x_filter(row8(1,1):row8(size_row8(1,1)));
y_crop8 = y_filter(row8(1,1):row8(size_row8(1,1)));

%% Cropping the 9th Noise
row9 = find(time>=limit1(9,1) & time<=limit2(9,1));
size_row9 = size(row9);
time_crop9 = time(row9(1,1):row9(size_row9(1,1)));
x_crop9 = x_filter(row9(1,1):row9(size_row9(1,1)));
y_crop9 = y_filter(row9(1,1):row9(size_row9(1,1)));

%% Cropping the 10th Noise
row10 = find(time>=limit1(10,1) & time<=limit2(10,1));
size_row10 = size(row10);
time_crop10 = time(row10(1,1):row10(size_row10(1,1)));
x_crop10 = x_filter(row10(1,1):row10(size_row10(1,1)));
y_crop10 = y_filter(row10(1,1):row10(size_row10(1,1)));

%% Cropping the 11th Noise
row11 = find(time>=limit1(11,1) & time<=limit2(11,1));
size_row11 = size(row11);
time_crop11 = time(row11(1,1):row11(size_row11(1,1)));
x_crop11 = x_filter(row11(1,1):row11(size_row11(1,1)));
y_crop11 = y_filter(row11(1,1):row11(size_row11(1,1)));

%% Cropping the 12th Noise
row12 = find(time>=limit1(12,1) & time<=limit2(12,1));
size_row12 = size(row12);
time_crop12 = time(row12(1,1):row12(size_row12(1,1)));
x_crop12 = x_filter(row12(1,1):row12(size_row12(1,1)));
y_crop12 = y_filter(row12(1,1):row12(size_row12(1,1)));

%% Cropping the 13th Noise
row13 = find(time>=limit1(13,1) & time<=limit2(13,1));
size_row13 = size(row13);
time_crop13 = time(row13(1,1):row13(size_row13(1,1)));
x_crop13 = x_filter(row13(1,1):row13(size_row13(1,1)));
y_crop13 = y_filter(row13(1,1):row13(size_row13(1,1)));

%% Cropping the 14th Noise
row14 = find(time>=limit1(14,1) & time<=limit2(14,1));
size_row14 = size(row14);
time_crop14 = time(row14(1,1):row14(size_row14(1,1)));
x_crop14 = x_filter(row14(1,1):row14(size_row14(1,1)));
y_crop14 = y_filter(row14(1,1):row14(size_row14(1,1)));

%% Cropping the 15th Noise
row15 = find(time>=limit1(15,1) & time<=limit2(15,1));
size_row15 = size(row15);
time_crop15 = time(row15(1,1):row15(size_row15(1,1)));
x_crop15 = x_filter(row15(1,1):row15(size_row15(1,1)));
y_crop15 = y_filter(row15(1,1):row15(size_row15(1,1)));

%% Cropping the 16th Noise
row16 = find(time>=limit1(16,1) & time<=limit2(16,1));
size_row16 = size(row16);
time_crop16 = time(row16(1,1):row16(size_row16(1,1)));
x_crop16 = x_filter(row16(1,1):row16(size_row16(1,1)));
y_crop16 = y_filter(row16(1,1):row16(size_row16(1,1)));

%% Cropping the 17th Noise
row17 = find(time>=limit1(17,1) & time<=limit2(17,1));
size_row17 = size(row17);
time_crop17 = time(row17(1,1):row17(size_row17(1,1)));
x_crop17 = x_filter(row17(1,1):row17(size_row17(1,1)));
y_crop17 = y_filter(row17(1,1):row17(size_row17(1,1)));

%% Cropping the 18th Noise
row18 = find(time>=limit1(18,1) & time<=limit2(18,1));
size_row18 = size(row18);
time_crop18 = time(row18(1,1):row18(size_row18(1,1)));
x_crop18 = x_filter(row18(1,1):row18(size_row18(1,1)));
y_crop18 = y_filter(row18(1,1):row18(size_row18(1,1)));

%% Forming on Martix for Each component
Sizes = [0 0;size(x_crop1);size(x_crop2);size(x_crop3);size(x_crop4); ...
    size(x_crop5);size(x_crop6);size(x_crop7);size(x_crop8);size(x_crop9);size(x_crop10); ...
    size(x_crop11);size(x_crop12);size(x_crop13);size(x_crop14);size(x_crop15); ...
    size(x_crop16);size(x_crop17);size(x_crop18)];

x_crop_total =[x_crop1 x_crop2 x_crop3 x_crop4 x_crop5 x_crop6 x_crop7 x_crop8 x_crop9 x_crop10 ...
    x_crop11 x_crop12 x_crop13 x_crop14 x_crop15 x_crop16 x_crop17 x_crop18];
y_crop_total =[y_crop1 y_crop2 y_crop3 y_crop4 y_crop5 y_crop6 y_crop7 y_crop8 y_crop9 y_crop10 ...
    y_crop11 y_crop12 y_crop13 y_crop14 y_crop15 y_crop16 y_crop17 y_crop18];
t_crop_total =[time_crop1;time_crop2;time_crop3;time_crop4;time_crop5;time_crop6; ...
    time_crop7;time_crop8;time_crop9;time_crop10;time_crop11;time_crop12;time_crop13; ...
    time_crop14;time_crop15;time_crop16;time_crop17;time_crop18];
% Colors = ['g','g','g','r','r','r','b','g','r'];
a1 = [' 1st Noise Level']; a2 = [' 2nd Noise Level']; a3 = [' 3rd Noise Level'];
a4 = [' 4th Noise Level']; a5 = [' 5th Noise Level']; a6 = [' 6th Noise Level'];
a7 = [' 7th Noise Level']; a8 = [' 8th Noise Level']; a9 = [' 9th Noise Level'];
a10 = ['10th Noise Level']; a11 = ['11th Noise Level']; a12 = ['12th Noise Level'];
a13 = ['13th Noise Level']; a14 = ['14th Noise Level']; a15 = ['15th Noise Level'];
a16 = ['16th Noise Level']; a17 = ['17th Noise Level']; a18 = ['18th Noise Level'];
Titles = [a1;a2;a3;a4;a5;a6;a7;a8;a9;a10;a11;a12;a13;a14;a15;a16;a17;a18];
Displacements = ['Longitudinal' 'Lateral' 'Vertical'];

%% Statistics
for j = 1:18;
    Start(j,1)= sum(Sizes(1:j,2))+1; 
    End(j,1) = Start(j,1)-1+Sizes(j+1,2);
    
    %% Statistics for tables
    average_x(j) = mean(x_crop_total(Start(j,1):End(j,1)));
    average_y(j) = mean(y_crop_total(Start(j,1):End(j,1)));
           
    %% Statistics for plotting
   
    Avrg_x(Start(j,1):End(j,1)) = mean(x_crop_total(Start(j,1):End(j,1)));
    Avrg_y(Start(j,1):End(j,1)) = mean(y_crop_total(Start(j,1):End(j,1)));
    sigma_x(j,1) = std(x_crop_total(Start(j,1):End(j,1)));
    sigma_y(j,1) = std(y_crop_total(Start(j,1):End(j,1)));
    Amp_x(Start(j,1):End(j,1)) = abs((Avrg_x(Start(j,1):End(j,1))+3*sigma_x(j,1))-...
        (Avrg_x(Start(j,1):End(j,1))-3*sigma_x(j,1)));
    Amp_y(Start(j,1):End(j,1)) = abs((Avrg_y(Start(j,1):End(j,1))+3*sigma_y(j,1))-...
        (Avrg_y(Start(j,1):End(j,1))-3*sigma_y(j,1)));
       %%
    Amplitude_x(j) = abs((average_x(j)+3*sigma_x(j,1))-...
        (average_x(j)-3*sigma_x(j,1)));
    Amplitude_y(j) = abs((average_y(j)+3*sigma_y(j,1))-...
        (average_y(j)-3*sigma_y(j,1)));
        
    %% Plotting Lateral Component
    figure,
    P(j) = plot(t_crop_total(Start(j):End(j)),y_crop_total(Start(j,1):End(j,1)),'r');
    title(strcat(Titles(j,1:16),'-',Displacements(13:19)))
    xlabel('Time (s)'); ylabel('displacement (mm)')
    hold on
    plot(t_crop_total(Start(j):End(j)),Avrg_y(Start(j,1):End(j,1)),'k','LineWidth',1)
    plot(t_crop_total(Start(j):End(j)),Avrg_y(Start(j,1):End(j,1))+3*sigma_y(j),'c','LineWidth',2)
    plot(t_crop_total(Start(j):End(j)),Avrg_y(Start(j,1):End(j,1))-3*sigma_y(j),'c','LineWidth',2)
    legend('Lateral','Mean','99% confidence interval','location','northeast')
    hold off
%     axis([limit1(j) limit2(j) -0.3 0.3])
%     saveas(P(j),strcat(Titles(j,1:16),'-',Displacements(13:19)),'jpg');
    
    %% Plotting Longitudinal Component
   
    figure,
    k(j) = plot(t_crop_total(Start(j):End(j)),x_crop_total(Start(j,1):End(j,1)),'b');
    title(strcat(Titles(j,1:16),'-',Displacements(1:12)))
    xlabel('Time (s)'); ylabel('displacement (mm)')
    hold on
    plot(t_crop_total(Start(j):End(j)),Avrg_x(Start(j,1):End(j,1)),'k','LineWidth',1)
    plot(t_crop_total(Start(j):End(j)),Avrg_x(Start(j,1):End(j,1))+3*sigma_x(j),'c','LineWidth',2)
    plot(t_crop_total(Start(j):End(j)),Avrg_x(Start(j,1):End(j,1))-3*sigma_x(j),'c','LineWidth',2)
    hold off
    legend('Longitudinal','Mean','99% confidence interval','location','northeast')
%     axis([limit1(j) limit2(j) -0.3 0.3])
%    saveas(P(j),strcat(Titles(j,1:16),'-',Displacements(1:12)),'jpg');

end

Stat = [average_x;average_y;3*sigma_x';3*sigma_y';Amplitude_x;Amplitude_y];