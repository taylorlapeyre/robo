const int LED = 13;
const int LIGHT = 7;

int randNum;
int crankiness;

typedef void (* EmotionPtr) ();
EmotionPtr emotions[7] = {asleep, happy, sad, angry, bored, excited, shocked};

void setup() {
  pinMode(LED, OUTPUT);
  pinMode(LIGHT, INPUT);
  Serial.begin(9600);
}

void loop() {
  crankiness = analogRead(LIGHT);
  randNum = random(1000);

  if (randNum < crankiness) {
    int emotion = random(1, 6);
    for (int i = 0; i <= randNum; i++) { // should be randNum
      emotions[emotion](); // should be 'emotion'
    }
  } else {
    for (int i = 0; i < 10; i++) { // should be 10
      emotions[0]();
    }
  }
}

void asleep() {
  Serial.println("asleep");
  digitalWrite(LED, HIGH);
  delay(1000);
  digitalWrite(LED,LOW);
  delay(3000);
}

void happy() {
  Serial.println("happy");
  digitalWrite(LED, HIGH);
  delay(200);
  digitalWrite(LED, LOW);
  delay(200);
}

void sad() {
  Serial.println("sad");
  digitalWrite(LED, HIGH);
  delay(700);
  digitalWrite(LED, LOW);
  delay(100);
  digitalWrite(LED, HIGH);
  delay(100);
  digitalWrite(LED, LOW);
  delay(100);
}

void angry() {
  Serial.println("angry");
  digitalWrite(LED, HIGH);
  delay(200);
  digitalWrite(LED, LOW);
  delay(1000);
}

void bored() {
  Serial.println("bored");
  digitalWrite(LED, HIGH);
  delay(1000);
  digitalWrite(LED, LOW);
  delay(200);
}

void excited() {
  Serial.println("excited");
  digitalWrite(LED, HIGH);
  delay(100);
  digitalWrite(LED, LOW);
  delay(50);
  digitalWrite(LED, HIGH);
  delay(120);
  digitalWrite(LED, LOW);
  delay(70);
}

void shocked() {
  Serial.println("shocked");
  digitalWrite(LED, HIGH);
  delay(500);
  digitalWrite(LED, LOW);
  delay(500);
  digitalWrite(LED, HIGH);
  delay(500);
  digitalWrite(LED, LOW);
  delay(500);
  digitalWrite(LED, HIGH);
  delay(1000);
  digitalWrite(LED, LOW);
  delay(500);
}
