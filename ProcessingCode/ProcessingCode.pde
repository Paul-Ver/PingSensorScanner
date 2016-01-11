import processing.serial.*;

Serial arduino;    // The serial port
String buffer;  // Input string from serial port
int value;
boolean fail = false;

void setup() {
  size(2100,11);
  strokeWeight(12);
  stroke(255,0,0);
  // List all the available serial ports:
  printArray(Serial.list());
  arduino = new Serial(this, Serial.list()[0], 115200);
  arduino.bufferUntil('\n');
}

void draw() {
  if(fail == false){
      background(0);
      line(0,6,round(value/10),6);
  }
    try{
    fail = false;
    value = Integer.parseInt(buffer);
  }catch(Exception e){
    e.printStackTrace();
    fail = true;
  }
  
  if(value == 0){
    fail = true;
  }
}

void serialEvent(Serial p) {
  buffer = p.readString();            //Read the string from buffer
  buffer = buffer.replace("\n","");   //Delete the line end.
  println(buffer);
}