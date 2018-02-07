#include <SPI.h>
#include <Wire.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>
// If using software SPI (the default case):
#define OLED_MOSI  11   //D1
#define OLED_CLK   12   //D0
#define OLED_DC    9
#define OLED_CS    8
#define OLED_RESET 10
char buffer[10];
Adafruit_SSD1306 display(OLED_MOSI, OLED_CLK, OLED_DC, OLED_RESET, OLED_CS);
//counter to begin the game
int count = 0;
//Receptor
int points = 0;
const int analogInPin = A0;
int LaserValue = 0;
//Emisor

// the setup routine runs once when you press reset:
void setup() {
  // initialize serial communication at 9600 bits per second:
  Serial.begin(9600);
  display.begin(SSD1306_SWITCHCAPVCC);
  display.display();
  //delay(1000);
  display.clearDisplay();
  display.setTextSize(2);
  display.setTextColor(BLACK, WHITE); 
  TheGame();
}

// the loop routine runs over and over again forever:
void loop() {
  //Just will set this display for the first 5 seconds
  oled_display();
  //Read the input on analog pin 0:
  LaserValue = analogRead(analogInPin);  
  Serial.print(LaserValue);
  Serial.print("\n");
  Points();  
  //delay(300);
}

void TheGame() {
  //Draw a counter of the time to begin the game  
  for (int i=0; i < 6; i++) {
    display.clearDisplay();
    display.setCursor(0,0);
    int xy = i;
    display.print("          ");
    display.print("  Ready?      ");
    display.print(xy);
    display.print("               ");
    delay(1000);
    display.display();
  }   
}

void Points() {
  if(LaserValue > 901) {
      points = points + 1;    
      delay(1000);  
  }  
  LaserValue = 0;
}

void oled_display() {
  display.clearDisplay();
  display.setCursor(0,0);
  timer();
  display.display();
  delay(1000);  
  //draw shoots
  display.clearDisplay();
  display.setCursor(0,0);
  shootgun();
  display.display();
  delay(1000); 
  //draw shoots received
  display.clearDisplay();
  display.setCursor(0,0);
  life();
  display.display();
  delay(1000); 
  //draw gas
  display.clearDisplay();
  display.setCursor(0,0);
  gas();
  display.display();
  delay(1000); 
}

void life() {
  display.print("          ");
  display.print(" Impacts      ");
  display.print(points);//counter  
  display.print("     ");
  display.print("          ");
}

void shootgun() {  
  display.print("        ");
  display.print("    Shoots  ");
  //display.print(x);//counter
  display.print("          ");
  display.print("          ");
}

void gas() {
  display.print("          ");
  display.print("    CO2   ");
  //display.print(x);//counter
  display.print("          ");
  display.print("          ");
}

void timer() {
  display.print("        ");
  display.print("    Timer    ");
  calculateTime();
  display.print("          ");
}

void calculateTime(){
  long t= millis()/1000 ;
  int horas = t/3600 ;
  int minutos = (t % 3600) / 60;
  int segs = (t - horas*3600 - minutos * 60) % 60 ;
  int n = sprintf(buffer, "%02d:%02d:%02d ", horas, minutos, segs);  
  display.print(buffer); 
}

