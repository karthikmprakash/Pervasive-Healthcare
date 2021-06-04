 //This is the output pin on the Arduino
int HeartRate, Temp,Sys, Dia;
void setup()
{
  Serial.begin(9600);
  
 
}
void loop()
{
if(Serial.available()>0)
{
    HeartRate = Serial.read();
    Temp = Serial.read();
    Sys = Serial.read();
    Dia = Serial.read();
    
}
}
