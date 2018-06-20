#include <Arduino.h>
#include <WiFi.h>
#include <WiFiMulti.h>

WiFiMulti WiFiMulti;
// Use WiFiClient class to create TCP connections
WiFiClient client;

// Functions declaration
void wifi_connection_esp();

// This port and IP are the ones that we will use to connect to ESP32
const uint16_t port = 80;
const char * host = "192.168.0.111"; // ip or dns
// WiFi variables
const char* ssid     = "Super_Human_HM";
const char* password = "1234superhuman";

void wifi_connection_esp() {
  // This string will be send to the server
  client.print("T");
  Serial.println("Stack is online");
  delay(10);
}

void setup() {
  Serial.begin(115200);
  delay(10);
  // We start by connecting to a WiFi network
  WiFiMulti.addAP(ssid, password);
  Serial.print("Wait for WiFi... ");
  //Start the connection of the client and wait until connect to the lan
  while(WiFiMulti.run() != WL_CONNECTED) {
          Serial.print(".");
          delay(100);
  }
  Serial.println("");
  Serial.println("WiFi connected");
  Serial.println("IP address: ");
  //print the IP assigned to the device
  Serial.println(WiFi.localIP());
  delay(500);
  Serial.print("connecting to ");
  Serial.println(host);
  if (!client.connect(host, port)) {
          Serial.println("connection failed");
          Serial.println("wait...");
          delay(10);
          return;
  }
}

void loop() {
  wifi_connection_esp();
}
