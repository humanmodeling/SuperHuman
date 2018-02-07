import processing.serial.*;

Serial myPort;  // Create object from Serial class
String val; // Data received from the serial port

void setup() {
        String portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match the port
        myPort = new Serial(this, portName, 38400);
}

void draw() {
        if ( myPort.available() > 0) {
                // If data is available
                val = myPort.readStringUntil('\n');
                // read it and store it in val
        }
        println(val); //print it out in the console
}
