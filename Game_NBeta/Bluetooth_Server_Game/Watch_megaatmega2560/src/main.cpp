//By the Super Human Team
//Bluetooth

#include <Arduino.h>
#include <SPI.h>
#include <Wire.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>
#include <IRremote.h>
//#include <SimpleTimer.h>

//Functions
void TheGame();//Show a message before the game start
void Laser_Points();//Count the laser impacts
void Laser_Weapon();//Activate the laser gun
void IR_Points();//Count the IR impacts
void SendPluse();//Send the laser pulse
void Special_Weapon();//Check if the Super Weapon is activated
void Special_Weapon_Activated();//If the bottom is pressed shoot the special weapon
void Special_Weapon_Shoot();//contain the IR coding
void oled_timer();//Display the time
void oled_LF();//Display of the life and impacts
void shoot_life();//format of the life and impacts
void timer();//format of the clock
void calculateTime();//Function that calculate the time
void Game_Over();//Function that is called when the game is over

// If using software SPI
#define OLED_MOSI  11
#define OLED_CLK   12
#define OLED_DC    9
#define OLED_CS    8
#define OLED_RESET 10
char buffer[10];
Adafruit_SSD1306 display(OLED_MOSI, OLED_CLK, OLED_DC, OLED_RESET, OLED_CS);

//Receptor

//Laser Point
int points = 0;
char Laser_Point;

//declare objects of SimpleTimer library
//SimpleTimer laser_read_serial;
//SimpleTimer IR_read_serial;

//IR Point
char IR_Point;

//Game_Over
int end = 0;

//Laser shoot
const int Laser_WeaponIn = 2;//pin for pullup resistor D2
int ledLaser = 13;//pin for laser
int laser_value = 0;
int last_laser_value = 0;// previous state of the button
int shoots = 0;// shoots counter variable
//IR shoot
IRsend irsend; //create a IRsend object just apply for pin 9 in ATMega328
char Super_Gun;//In this variable we will save the data that was send by the other Arduino
int ledIR_advice = 6;//if the special gun is activated a led will turn on
int IR_WeaponIn = 7;//here we read the bottom of the gun
int ledIR_state = 0;//if we push the bottom the gun will be shoot
int last_ledIR_state = 0;//Save the last state of the bottom
int special_weapon_active = 0;//Variable to know if the IR was shooted

void setup() {
        //Master of the Shoulder Bluetooth
        Serial1.begin(38400);
        //Slave of the server
        Serial2.begin(38400); // Start serial communication at 38400 bps
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
        //laser_read_serial.setInterval(1000, Laser_Points);//repeats every 1 second, can be changed
        //IR_read_serial.setInterval(1000, IR_Points);//repeats every 1 second, can be changed

}

void loop() {
        //Just will set this display for the first 5 seconds
        oled_timer();
        //Laser Points check if the user was hit by the laser gun
        Laser_Points();
        //laser_read_serial.run();
        //IR Points check if the user was hit by the Special Gun
        IR_Points();
        //IR_read_serial.run();
        //Check how many shoots did the player
        Laser_Weapon();
        //Check if we charge the super weapon
        Special_Weapon();
        //If is charged activate the weapo with a bottom
        Special_Weapon_Activated();
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
//Check the impact points that you received by laser
void Laser_Points() {
        if (Serial1.available()) { // If data is available to read
                Laser_Point = Serial1.read(); // read it and store it in val
                if (Laser_Point == '1') {
                        points = points + 1;
                        Serial2.write('1');
                        Laser_Point = '0';
                        oled_LF();
                        delay(2000);
                        end = points;
                        if (end >= 20) {
                                while(1) {
                                        Game_Over();
                                }
                        }
                }
        }
}
//Check the impact points that you received by IR
void IR_Points() {
        if (Serial1.available()) { // If data is available to read
                IR_Point = Serial1.read(); // read it and store it in val
                if (IR_Point == '3') {
                        points = points + 5;
                        Serial2.write('2');
                        oled_LF();
                        delay(2000);
                        end = points;
                        IR_Point = '0';
                        if(end >= 20) {
                                while(1) {
                                        Game_Over();
                                }
                        }
                }
        }
}
//Activate the laser gun
void Laser_Weapon() {
        laser_value = digitalRead(Laser_WeaponIn);
        if (laser_value != last_laser_value) {
                if (laser_value == LOW) {
                        shoots = shoots + 1;
                        Serial2.write('3');
                        delay(10);
                        oled_LF();
                        SendPluse(); //I call the function pulse
                }
        }
        last_laser_value = laser_value;//Evaluate the last state of the push buttom
}
//Shoot one time the laser gun
void SendPluse() {
        digitalWrite(ledLaser, HIGH);
        delay(2000);
        digitalWrite(ledLaser, LOW);
}
//Shoot the special Gun
void Special_Weapon() {
        if (Serial1.available()) { // If data is available to read
                Super_Gun = Serial1.read(); // read it and store it in val
                if (Super_Gun == '2') {
                        //this led advice that the weapon can be shoot
                        digitalWrite(ledIR_advice, HIGH);
                        Serial2.write('4');
                        delay(10);
                        //this varible will save the state that the special weapon is charged
                        special_weapon_active = 2;
                }
        }
}

void Special_Weapon_Activated() {
        //Check the state of the bottom
        ledIR_state = digitalRead(IR_WeaponIn);
        //Check if the state of the bottom changed
        if (ledIR_state != last_ledIR_state) {
                if (ledIR_state == HIGH) {//Maybe this change to low deppending of the configuration of the
                        //if the weapon is charged it will shoot
                        if (special_weapon_active == 2) {
                                Special_Weapon_Shoot();
                                Serial2.write('5');
                                special_weapon_active = 0;
                                Super_Gun = '0';
                        }
                }
        }
        last_ledIR_state = ledIR_state;//Evaluate the last state of the push buttom
}

void Special_Weapon_Shoot() {
        shoots = shoots + 5;
        irsend.sendSony(0x68B90, 20);// the second statement is the number of bits
        delay(500);
        digitalWrite(ledIR_advice, LOW);
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
