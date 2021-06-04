clear all;
clc;
a = arduino('COM4','Uno'); 
temp=0;
i=1;
tic
while toc<10
    temp(i)=round(100*(readVoltage(a,'A0')));
    t=toc;  
    disp(temp(i));
     i=i+1; 

end
%%    To send the data serially back to the arduino
 if ~isempty(instrfind)
 fclose(instrfind);
 delete(instrfind);
end
a=serial('COM4','BaudRate',9600);
fopen(a);
j=1;
while j<i
   fprintf(a, '%d', temp(j)); 
   j=j+1;
end

plot(temp);