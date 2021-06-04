
clc;
clear all;

name =input('Enter the name of the person  : ','s');
gen=input('Enter M for Male or F for Female  : ','s');

if isempty(gen)
          gen = 'M';
end

age=input('Enter the age between 10 to 80  : ');
age=round(age/10);
     
switch gen
    case 'M'
        switch age
            case 1
                SV=94;
            case 2
                SV=102;
            case 3
                SV=98;
            case 4
                SV=91;
            case 5
                SV=85;
            case 6
                SV=78;
            case 7
                SV=71;
            case 8
                SV=71;
            otherwise 
                display('age is incorrect');
        end
case 'F'
        switch age
             case 1
                SV=84;
            case 2
                SV=81;
            case 3
                SV=77;
            case 4
                SV=74;
            case 5
                SV=71;
            case 6
                SV=69;
            case 7
                SV=66;
            case 8
                SV=66;
            otherwise 
                display('age is incorrect');
        end
    
end



 if ~isempty(instrfind)
 fclose(instrfind);
 delete(instrfind);
 end
v=zeros(1e3,1);
ppgv=zeros(1e3,1);
temp=zeros(1e3,1);
HR=0;
tempavg=0;
 input('When ready press enter','s');
a = arduino('COM3');
a.Baudrate=115200;
a.Terminator='CR';

tic                                 % Starts Timer
figure
h = animatedline;
ax = gca;
ax.YGrid = 'on';
ax.YLim = [-1 5];

i=1;
startTime = datetime('now');
while toc<10
    % Read current voltage value
    v(i) = readVoltage(a,'A8');
    % Calculate temperature from voltage (based on data sheet)
       
    % Get current time
    t =  datetime('now') - startTime;
    % Add points to animation
    addpoints(h,datenum(t),v(i))
    % Update axes
    ax.XLim = datenum([t-seconds(15) t]);
    datetick('x','keeplimits')
    drawnow
    % Check stop condition
    i=i+1;
end
%     
%    subplot(3,1,2)
%    
%     bx = gca;
%     bx.YGrid = 'on';
%     bx.YLim = [0 5];
%     % Read current voltage value
%     ppg = readVoltage(a,'A1');
%     ppgv(i)=ppg;
%     % Get current time
%     t1 =  datetime('now')- startTime;
%     % Add points to animation
%     addpoints(l,datenum(t1),ppg)
%     % Update axes
%     bx.XLim = datenum([t1-seconds(15) t1]);
%     datetick('x','keeplimits')
%    % xlabel(['SpO2 is ' num2str(HR1)]);
%     drawnow
%     
%     subplot(3,1,3)
%    
%     cx = gca;
%     cx.YGrid = 'on';
%     cx.YLim = [20 40];
%     % Read current voltage value
%     temp = readVoltage(a,'A3');
%     temp=100*temp;
%     % Get current time
%     t2 =  datetime('now') - startTime;
%     % Add points to animation
%     addpoints(j,datenum(t2),temp)
%     % Update axes
%     cx.XLim = datenum([t2-seconds(15) t2]);
%     datetick('x','keeplimits')
%     xlabel(['Temperature is ' num2str(tempavg)]);
%     drawnow
    
 
 v=v(1:i);

if rem(toc,10)==0                        % Record data for 10s
beat=0;
y=max(v);
for k = 1 : length(v)-1;
    if(v(k) > v(k-1) && v(k) > v(k+1) && v(k) > (0.70*y))
        beat=beat+1; 
    end
    
    
end

for k = 2 : length(temp)-2
tempsmooth=smooth(temp,5);
tempavg=mean(tempsmooth);
end

disp(beat);
HR= beat*6;
disp('Heart rate = ',HR);
end

   
T = table(v);
filename = 'ecg.xlsx';
% Write table to file 
writetable(T,filename)
% Print confirmation to command line
% fprintf('Results table with %g ecg measurements saved to file %s\n')
   



