import processing.serial.*;

Serial arduino;    // The serial port
String buffer="";  // Input string from serial port
int value;
boolean fail = false;

int rotation = 0;
int lenght = 0;
int[] lenghts = new int[180];

int maxPulseTime = 150;

void setup() {
  size(720,360);
  surface.setResizable(true);
  ellipseMode(RADIUS);
  ellipseMode(CENTER);
  strokeWeight(1);
  stroke(255,0,0);
  // List all the available serial ports:
  printArray(Serial.list());
  if(Serial.list().length>0){
    arduino = new Serial(this, Serial.list()[0], 115200);
    arduino.bufferUntil('\n');
    arduino.clear();
  }
}

void draw() {
  background(0);
  pushMatrix();
  translate(width/2,height);
  drawHud();
  int j = 0;
  stroke(0,255,255);
  strokeWeight(3);//Draw current line
  line(0,0,-max(width,height)*cos(radians(rotation)),-max(width,height)*sin(radians(rotation)));
  stroke(0,255,0);
  strokeWeight(1);
  for(int i : lenghts){//Draw history lines
    line(0,0,-(i*(width/maxPulseTime)/2)*cos(radians(j)),-(i*(height/maxPulseTime))*sin(radians(j)));
    j++;
  }
  popMatrix();
}

void serialEvent(Serial p) {
  buffer = p.readString();            //Read the string from buffer
  int start = buffer.indexOf(',');
  int end = buffer.indexOf('\n');
  if(start>0&&end>0){
    try{
    rotation = Integer.parseInt(buffer.substring(0, start));
    lenght = Integer.parseInt(buffer.substring(start+1,end));
    
    if(rotation > 179)
    rotation = 359-rotation;
    
    lenghts[rotation] = lenght;

    }catch(Exception e){
      e.printStackTrace();
    }
  }else{
    println("Failed to parse \"" + buffer + "\"");
  }
  
}

void drawHud(){
  stroke(0,255,0);
  line(0,0,-width/2,-height);//left
  line(0,0,0,-height);//middle
  line(0,0,width/2,-height);//Right
  noFill();
  
  arc(0,0, width/2, height, PI, PI+PI);
  
  arc(0,0, width, height*2, PI, PI+PI);
  
  
  text("Rotation: " + rotation + " Distance: " + lenght, -width/2+10,-16);
}