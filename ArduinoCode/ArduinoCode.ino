#define trigPin 5
#define echoPin 12

unsigned long pulseTime;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);//We have to stop using 9600 as default, it's slow.
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  digitalWrite(trigPin,HIGH);
  delayMicroseconds(10);      //Datasheet says ATLEAT 10microseconds
  digitalWrite(trigPin,LOW);

  pulseTime = pulseIn(echoPin, HIGH, 19000);
  Serial.print(pulseTime);
  Serial.print('\n');
  delay(30);
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
