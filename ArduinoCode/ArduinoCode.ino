#define trigPin 5
#define echoPin 12
#define servoPin 11
#include <Servo.h>

unsigned long pulseTime;

Servo rotator;
const unsigned long maxPulseTime = 150;
const unsigned int dly = 30;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);//We have to stop using 9600 as default, it's slow.
  pinMode(servoPin, OUTPUT);
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
  rotator.attach(servoPin);
}

void loop() {
  // put your main code here, to run repeatedly:

  for(int rotation = 0;rotation<360;rotation++){
      //rotation = 90;
      //rotator.detach();
    if(rotation<=180){
      rotator.write(rotation);
    }else{
      rotator.write((360-rotation));
    }
    delay(dly);
    digitalWrite(trigPin,HIGH);
    delayMicroseconds(10);      //Datasheet says ATLEAT 10microseconds
    digitalWrite(trigPin,LOW);
    pulseTime = pulseIn(echoPin, HIGH, maxPulseTime*58);//max pulse time is 38ms (datasheet)
    if(pulseTime==0){
      pulseTime=maxPulseTime*58;//pulsetime /58 = cm
    }
    Serial.print(rotation);
    Serial.print(",");
    Serial.print(pulseTime/58);
    Serial.print('\n');
    //delay(dly);
  }
}

//Datasheet:  
/*distance = (high level time×velocity of sound (340M/S) / 2
Working Voltage DC 5 V
Working Current 15mA
Working Frequency 40Hz
Max Range 4m
Min Range 2cm
MeasuringAngle 15 degree
Trigger Input Signal 10uS TTL pulse
Echo Output Signal Input TTL lever signal and the range in
proportion
Dimension 45*20*15mm 
 */
