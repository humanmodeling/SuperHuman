//By the Super Human Team
//Bluetooth

#include <Arduino.h>
#include <SPI.h>
#include <Wire.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>
#include <IRremote.h>

//Functions
void TheGame();//Show a message before the game start
void Points();
void Laser_Weapon();//Activate the laser gun
void Special_Weapon();//Check if the Super Weapon is activated
void Special_Weapon_Activated();//If the bottom is pressed shoot the special weapon
void Special_Weapon_Shoot();//contain the IR coding
void oled_timer();//Display the time
void oled_LF();//Display of the life and impacts
void shoot_life();//format of the life and impacts
void timer();//format of the clock
void calculateTime();//Function that calculate the time
void Game_Over();//Function that is called when the game is over
void Serial_Reader();//Read Serial1

//Oled display settings
// If using software SPI
#define OLED_MOSI  11
#define OLED_CLK   12
#define OLED_DC    9
#define OLED_CS    8
#define OLED_RESET 10
char buffer[10];
Adafruit_SSD1306 display(OLED_MOSI, OLED_CLK, OLED_DC, OLED_RESET, OLED_CS);

//Receptor
//Serial reader
char Serial_Universal_Reader = 0;
//Point Variable
int points = 0;
//Laser shoot
const int Laser_WeaponIn = 2;//pin for pullup resistor D2
int ledLaser = 13;//Pin for laser
int laser_value = 0;//Check the last state of the buttom
int last_laser_value = 0;//Previous state of the button
int shoots = 0;//Shoots counter variable
//IR shoot
IRsend irsend; //create a IRsend object just apply for pin 9 in ATMega328
char Super_Gun = 0;//In this variable we will save the data that was send by the other Arduino
int ledIR_advice = 6;//if the special gun is activated a led will turn on
int IR_WeaponIn = 7;//here we read the bottom of the gun
int ledIR_state = 0;//if we push the bottom the gun will be shoot
int last_ledIR_state = 0;//Save the last state of the bottom
int special_weapon_active = 0;//Variable to know if the IR was shooted
//Game_Over
int end = 0;

void setup() {
        //Master of the Shoulder Bluetooth
        Serial1.begin(38400);
        //Slave of the server
        Serial2.begin(115200); // Start serial communication at 115200 bps
        //OLED configuration
        display.begin(SSD1306_SWITCHCAPVCC);
        display.display();
        display.clearDisplay();
        display.setTextSize(2);
        display.setTextColor(BLACK, WHITE);
        //Display a game message
        TheGame();
        //Laser shoot configuration
        pinMode(ledLaser, OUTPUT); //Set pin 13 as output
        //IR shoot configuration
        pinMode(ledIR_advice, OUTPUT); //Set pin 6 as output
        //Laser Pull Up bottom
        pinMode(Laser_WeaponIn, INPUT); //Set pin 2 as input
        //IR Pull Up bottom
        pinMode(IR_WeaponIn, INPUT); //Set pin 7 as input
}

void loop() {
        //Just will set this display for the first 5 seconds
        oled_timer();
        //Read Serial
        Serial_Reader();
        //Laser and IR Points
        Points();
        //Check how many shoots did the player
        Laser_Weapon();
        //Check if we charge the super weapon
        Special_Weapon();
        //If is charged activate the weapo with a bottom
        Special_Weapon_Activated();
}

void TheGame() {
        //Draw a counter of the time to begin the game
        for(int i=5; i > 0; i--) {
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
        //This will activate the server
        Serial2.write('O');
        //the value of O is 79 in ASCII
}

void Serial_Reader() {
        if(Serial1.available()) {
                Serial_Universal_Reader = Serial1.read();
        }
}

//Check points
void Points() {
        if(Serial_Universal_Reader == '1') {
                points = points + 1;
                Serial2.write('1');
                oled_LF();
                delay(2000);
                end = points;
                Serial_Universal_Reader = 0;
                if (end >= 20) {
                        while(1) {
                                Game_Over();
                        }
                }
        }
        if(Serial_Universal_Reader == '3') {
                points = points + 5;
                Serial2.write('2');
                oled_LF();
                delay(2000);
                end = points;
                Serial_Universal_Reader = 0;
                if(end >= 20) {
                        while(1) {
                                Game_Over();
                        }
                }
        }

}
//Activate the laser gun
void Laser_Weapon() {
        laser_value = digitalRead(Laser_WeaponIn);
        if(laser_value != last_laser_value) {
                if(laser_value == LOW) {
                        shoots = shoots + 1;
                        Serial2.write('3');
                        delay(10);
                        oled_LF();
                        digitalWrite(ledLaser, HIGH);
                        delay(2000);
                        digitalWrite(ledLaser, LOW);
                }
        }
        last_laser_value = laser_value;//Evaluate the last state of the push buttom
}
//Shoot the special Gun
void Special_Weapon() {
        Super_Gun = Serial_Universal_Reader;         //Read the serial port value and store it
        if(Super_Gun == '2') {
                //this led advice that the weapon can be shoot
                digitalWrite(ledIR_advice, HIGH);
                Serial2.write('4');
                delay(10);
                Super_Gun = 0;
                //this varible will save the state that the special weapon is charged
                special_weapon_active = 2;
        }
}

void Special_Weapon_Activated() {
        //Check the state of the bottom
        ledIR_state = digitalRead(IR_WeaponIn);
        //Check if the state of the bottom changed
        if(ledIR_state != last_ledIR_state) {
                if(ledIR_state == LOW) {//Maybe this change to low deppending of the configuration of the
                        //if the weapon is charged it will shoot
                        if(special_weapon_active == 2) {
                                Special_Weapon_Shoot();
                                Serial2.write('5');
                                special_weapon_active = 0;
                                digitalWrite(ledIR_advice, LOW);
                        }
                }
        }
        last_ledIR_state = ledIR_state;//Evaluate the last state of the push buttom
}

void Special_Weapon_Shoot() {
        digitalWrite(ledIR_advice, LOW);
        shoots = shoots + 5;
        irsend.sendSony(0x68B90, 20);// the second statement is the number of bits
        oled_LF();
        delay(2000);
}
//Call the funtion that display the shoots and impacts
void oled_LF() {
        display.clearDisplay();
        display.setCursor(0,0);
        shoot_life();
        display.display();
}
//Format of the Shoots and impacts
void shoot_life() {
        display.print("  Shoots  ");
        display.print("    ");
        display.print(shoots);//counter
        display.print("     ");
        display.print(" Impacts  ");
        display.print("    ");
        display.print(points);//counter
        display.print("     ");
}
//Function that call the watch
void oled_timer() {
        display.clearDisplay();
        display.setCursor(0,0);
        timer();
        display.display();
}
//Format of the watch
void timer() {
        display.print("          ");
        display.print("  TIMER    ");
        calculateTime();
        display.print("          ");
        display.display();
}
//Function that calculate the time
void calculateTime() {
        long t = millis()/1000;
        int horas = t/3600;
        int minutos = (t % 3600) / 60;
        int segs = (t - horas*3600 - minutos * 60) % 60;
        int n = sprintf(buffer, "%02d:%02d:%02d ", horas, minutos, segs);
        display.print(buffer);
}
//Funtion that is used to display the end of the game
void Game_Over() {
        display.clearDisplay();
        display.setCursor(0,0);
        display.print("          ");
        display.print("   GAME   ");
        display.print("   OVER   ");
        display.print("          ");
        display.display();
}
