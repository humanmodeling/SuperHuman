#include <Arduino.h>
#include <WiFi.h>
#include <WiFiMulti.h>

WiFiMulti WiFiMulti;
WiFiClient client;

// Functions
void server_raspberry();
void watch();

// Client variables to send to raspberry
const uint16_t port = 5204;
const char * host = "192.168.0.101"; // ip or dns

// Server objects
WiFiServer server(80);
//Server variables
const char* ssid     = "Super_Human_HM";
const char* password = "1234superhuman";
char c;

void watch() {
  // listen for incoming clients
  client = server.available();
  Serial.println(client);
  if (client) {
    // if client connected
    Serial.println("New Client.");
    // make a String to hold incoming data from the client
    String currentLine = "";
    //Serial.print('\n');
    while (client.connected()) {
      // loop while the client's connected
      if (client.available()) {
        // if there's bytes to read from the client
        c = client.read();
        // read a byte
        Serial.println(c);
        // print it out the serial monitor
        //Serial.print('\n');
      }
      // This function connect to the Raspberry
      server_raspberry();
    }
  }
}

void server_raspberry() {
  // Client connecting to raspberry
  Serial.print("connecting to ");
  Serial.println(host);
  if (!client.connect(host, port)) {
          Serial.println("connection failed");
          Serial.println("wait...");
          delay(10);
          return;
  }
  // This will send the request to the server
  client.print(c);
  delay(10);
}

void setup() {
    Serial.begin(115200);
    delay(10);
    // ESP Server
    WiFi.begin(ssid, password);
    // Connecting to the network
    Serial.print("Wait for WiFi... ");
    while (WiFi.status() != WL_CONNECTED) {
        delay(500);
        Serial.print(".");
    }
    Serial.println("");
    Serial.println("WiFi connected");
    Serial.println("IP address: ");
    Serial.println(WiFi.localIP());
    delay(500);
    // This is to start the Server
    server.begin();
    if (!client.connect(host, port)) {
          Serial.println("connection failed");
          Serial.println("wait...");
          delay(10);
          return;
  }
}

void loop() {
    // This function connect the watch
    watch();
    delay(500);
}
