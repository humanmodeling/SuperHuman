#define FIRSTLED_ALLOW_INTERRUPTS 0
#include <Arduino.h>
#include <WiFi.h>
#include <WiFiMulti.h>
#include <FastLED.h>

<<<<<<< HEAD
#define LED_PIN 27
#define NUM_LEDS 16
=======
#define NUM_LEDS 16
#define LED_PIN 27
>>>>>>> Beta

WiFiMulti WiFiMulti;
WiFiClient client_M5Stack;
WiFiClient client_ESP;
CRGB leds[NUM_LEDS];

//PGM Valve
int PGM_valve1 = 25;
int PGM_valve2 = 26;
int PGM_valve3 = 32;
int PGM_valve4 = 33;

//WiFi connection
int wifiLED = 4;

//Player life
int lifeCount = 5;

// Functions
void watch();
void server_raspberry();
void valves_actuation();

// Server objects for ESP
WiFiServer server(80);
//Server variables
const char *ssid = "Super_Human_HM";
const char *password = "1234superhuman";
char c;
// Client variables to send to raspberry
const uint16_t port = 5204;
const char *host = "192.168.0.101"; // ip or dns
// flag to print just one time the IP of the connected server
char flag_activated = 'N';

void watch()
{
  // listen for incoming clients
  client_M5Stack = server.available();
  if (client_M5Stack)
  {
    // if client connected
    Serial.println("New Client.");
    while (client_M5Stack.connected())
    {
      // loop while the client's connected
      if (client_M5Stack.available())
      {
        // if there's bytes to read from the client
        c = client_M5Stack.read();
        Serial.println(c);
        if (c == 'H')
        {
          lifeCount--;
        }
        // read a byte
        valves_actuation();
        // This function connect to the Raspberry
        server_raspberry();
        c = '0';
      }
    }
  }
}

void valves_actuation()
{
  if (lifeCount == 4)
  {
    digitalWrite(PGM_valve1, HIGH);
    digitalWrite(PGM_valve2, LOW);
    digitalWrite(PGM_valve3, LOW);
    digitalWrite(PGM_valve4, LOW);

    //start this part for first hit
    leds[0] = CRGB(255, 0, 0);
    FastLED.show();
<<<<<<< HEAD
    leds[1] = CRGB(255, 0, 0);
    FastLED.show();
    leds[2] = CRGB(255, 0, 0);
    FastLED.show();
    leds[3] = CRGB(255, 0, 0);
    FastLED.show();
=======
    delay(10);
    leds[1] = CRGB(255, 0, 0);
    FastLED.show();
    delay(10);
    leds[2] = CRGB(255, 0, 0);
    FastLED.show();
    delay(10);
    leds[3] = CRGB(255, 0, 0);
    FastLED.show();
    delay(10);
>>>>>>> Beta
  }
  else if (lifeCount == 3)
  {
    digitalWrite(PGM_valve1, HIGH);
    digitalWrite(PGM_valve2, HIGH);
    digitalWrite(PGM_valve3, LOW);
    digitalWrite(PGM_valve4, LOW);

    //start this part for second hit
<<<<<<< HEAD
    leds[4] = CRGB(0, 255, 0);
    FastLED.show();
    leds[5] = CRGB(0, 255, 0);
    FastLED.show();
    leds[6] = CRGB(0, 255, 0);
    FastLED.show();
    leds[7] = CRGB(0, 255, 0);
    FastLED.show();
=======
    leds[8] = CRGB(0, 0, 255);
    FastLED.show();
    delay(10);
    leds[9] = CRGB(0, 0, 255);
    FastLED.show();
    delay(10);
    leds[10] = CRGB(0, 0, 255);
    FastLED.show();
    delay(10);
    leds[11] = CRGB(0, 0, 255);
    FastLED.show();
    delay(10);
>>>>>>> Beta
  }
  else if (lifeCount == 2)
  {
    digitalWrite(PGM_valve1, HIGH);
    digitalWrite(PGM_valve2, HIGH);
    digitalWrite(PGM_valve3, HIGH);
    digitalWrite(PGM_valve4, LOW);

    //start this part for third hit
<<<<<<< HEAD
    leds[8] = CRGB(0, 0, 255);
    FastLED.show();
    leds[9] = CRGB(0, 0, 255);
    FastLED.show();
    leds[10] = CRGB(0, 0, 255);
    FastLED.show();
    leds[11] = CRGB(0, 0, 255);
    FastLED.show();
=======
    leds[4] = CRGB(0, 255, 0);
    FastLED.show();
    delay(10);
    leds[5] = CRGB(0, 255, 0);
    FastLED.show();
    delay(10);
    leds[6] = CRGB(0, 255, 0);
    FastLED.show();
    delay(10);
    leds[7] = CRGB(0, 255, 0);
    FastLED.show();
    delay(10);
>>>>>>> Beta
  }
  else if (lifeCount == 1)
  {
    digitalWrite(PGM_valve1, HIGH);
    digitalWrite(PGM_valve2, HIGH);
    digitalWrite(PGM_valve3, HIGH);
    digitalWrite(PGM_valve4, HIGH);

    //start this part for forth hit
    leds[12] = CRGB(255, 200, 20);
    FastLED.show();
<<<<<<< HEAD
    leds[13] = CRGB(255, 200, 20);
    FastLED.show();
    leds[14] = CRGB(255, 200, 20);
    FastLED.show();
    leds[15] = CRGB(255, 200, 20);
    FastLED.show();
=======
    delay(10);
    leds[13] = CRGB(255, 200, 20);
    FastLED.show();
    delay(10);
    leds[14] = CRGB(255, 200, 20);
    FastLED.show();
    delay(10);
    leds[15] = CRGB(255, 200, 20);
    FastLED.show();
    delay(10);
>>>>>>> Beta
  }
}

void server_raspberry()
{
  // Client connecting to raspberry
  // Print just one time the IP of the server
  if (flag_activated == 'N')
  {
    Serial.print("connecting to ");
    Serial.println(host);
    flag_activated = 'Y';
  }
  if (!client_ESP.connect(host, port))
  {
    Serial.println("connection failed");
    Serial.println("wait a little...");
    delay(10);
    return;
  }
  // This will send the request to the server
  if (c == 'H')
  {
    client_ESP.print("Z");
  }
}

void setup()
{
  Serial.begin(115200);
  //FastLED setup
  FastLED.addLeds<WS2812, LED_PIN, GRB>(leds, NUM_LEDS);
  FastLED.setBrightness(40);
  //delay(10);
  // PIN setup
  pinMode(PGM_valve1, OUTPUT);
  pinMode(PGM_valve2, OUTPUT);
  pinMode(PGM_valve3, OUTPUT);
  pinMode(PGM_valve4, OUTPUT);
  pinMode(wifiLED, OUTPUT);

  // ESP Server
  WiFi.begin(ssid, password);
  // Connecting to the network
  //assigned when connected to a WiFi network
  Serial.print("Wait for WiFi... ");
  while (WiFi.status() != WL_CONNECTED)
  {
    delay(100);
    Serial.print(".");
  }
  digitalWrite(wifiLED, HIGH);
  Serial.println("");
  Serial.println("WiFi connected");
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());
  //delay(500);
  // This is to start the Server (for the M5Stack)
  server.begin();
}

void loop()
{
  // This function connect the watch
  watch();
  //delay(10);
}
