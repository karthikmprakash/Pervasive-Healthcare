/*
  LiquidCrystal Library - Serial Input

 Demonstrates the use a 16x2 LCD display.  The LiquidCrystal
 library works with all LCD displays that are compatible with the
 Hitachi HD44780 driver. There are many of them out there, and you
 can usually tell them by the 16-pin interface.

 This sketch displays text sent over the serial port
 (e.g. from the Serial Monitor) on an attached LCD.

 The circuit:
 * LCD RS pin to digital pin 12
 * LCD Enable pin to digital pin 11
 * LCD D4 pin to digital pin 5
 * LCD D5 pin to digital pin 4
 * LCD D6 pin to digital pin 3
 * LCD D7 pin to digital pin 2
 * LCD R/W pin to ground
 * 10K resistor:
 * ends to +5V and ground
 * wiper to LCD VO pin (pin 3)

 Library originally added 18 Apr 2008
 by David A. Mellis
 library modified 5 Jul 2009
 by Limor Fried (http://www.ladyada.net)
 example added 9 Jul 2009
 by Tom Igoe
 modified 22 Nov 2010
 by Tom Igoe

 This example code is in the public domain.

 http://www.arduino.cc/en/Tutorial/LiquidCrystalSerial
 */

// include the library code:
#include <LiquidCrystal.h>
#include<Wire.h>

int data[]={0,0,0,0};
// initialize the library with the numbers of the interface pins
LiquidCrystal lcd(52, 50, 48, 46, 44, 42);
char HeartRate,Temp,SyV,DyV;
void setup() {
  Wire.begin(8);
  lcd.begin(16, 2);
  Serial.begin(9600);
  Wire.onRequest(requestEvent);
}

void loop() {
   while(Serial.available()) {
      delay(100);
     lcd.clear();
    for(int i=0;i<4;i++){
   if(Serial.available() > 0){
   data[i]=lcd.write(Serial.read());
   delay(50);
   }
    }
    lcd.print(data[0]);
    }
//     lcd.setCursor(0,0);
//     lcd.print("HR=");
//   
     
//   
//   //char Temp=Serial.read();
//      lcd.setCursor(7,0);
//      lcd.write("Tmp=");
//      lcd.write(Temp);
//      
//      
// // char SyV=Serial.read();
//     
//      lcd.setCursor(0,1);
//      lcd.write("Sys=");
//      lcd.write(SyV);
//      
//      
//  // char DyV=Serial.read();
//     
//      lcd.setCursor(7,1);
//      lcd.write("Dia=");
//      lcd.write(DyV);
//     
     
      
  
}

void requestEvent() {

  
       Wire.write(HeartRate);
delay(100);
       Wire.write(Temp); 
delay(100);
       Wire.write(SyV);
delay(100);
       Wire.write(DyV);
delay(100);
       
       }
 
  

