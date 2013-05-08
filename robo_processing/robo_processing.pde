import oscP5.*;
import netP5.*;

import processing.serial.*;

Serial myPort;
OscP5 oscP5;
NetAddress myRemoteLocation;
String emotion;

void setup() {
  size(200, 200);
  String portName = Serial.list()[6];
  myPort = new Serial(this, portName, 9600);
  oscP5 = new OscP5(this, 6449);
  myRemoteLocation = new NetAddress("127.0.0.1",6449);
}

void draw() {
  background(#000000);
  if (emotion != null) {
    if      (emotion.contains("asleep")) drawAsleep();
    else if (emotion.contains("happy")) drawHappy();
    else if (emotion.contains("sad")) drawSad();
    else if (emotion.contains("angry")) drawAngry();
    else if (emotion.contains("bored")) drawBored();
    else if (emotion.contains("excited")) drawExcited();
    else if (emotion.contains("shocked")) drawShocked();
    else println("Error!");

    if (emotion.contains("excited") && random(0, 100000) < 10) {
      println("Robo's giving you a present!");
      open(sketchPath("trytohelp"));
    }
  }
}

void drawAsleep() {
  background(#000000);
  fill(#FFFFFF);
  rect(50, 50, 25, 7);
  rect(125, 50, 25, 7);
  rect(50, 150, 100, 5);
}

void drawHappy() {
  background(#FFFF00);
  fill(#000000);
  rect(50, 50, 25, 25);
  rect(125, 50, 25, 25);
  noFill();
  strokeWeight(3);
  arc(100, 135, 150, 80, 0, PI);
}

void drawSad() {
  background(#0000FF);
  fill(#000000);
  rect(50, 50, 25, 25);
  rect(125, 50, 25, 25);
  noFill();
  strokeWeight(3);
  arc(100, 150, 150, 50, PI, TWO_PI);
}

void drawAngry() {
  background(#FF0000);
  fill(#000000);
  triangle(50, 50, 50, 75, 75, 75);
  triangle(150, 50, 150, 75, 125, 75);
  noFill();
  strokeWeight(3);
  arc(100, 150, 150, 50, PI, TWO_PI);
}

void drawBored() {
  background(#CCCCCC);
  fill(#000000);
  rect(50, 50, 25, 15);
  rect(125, 50, 25, 15);
  rect(50, 150, 100, 5);
}

void drawExcited() {
  background(#00FF00);
  fill(#000000);
  rect(50, 50, 25, 25);
  rect(125, 50, 25, 25);
  arc(100, 135, 150, 80, 0, PI);
}

void drawShocked() {
  background(#FFA500);
  fill(#000000);
  rect(50, 50, 25, 25);
  rect(125, 50, 25, 25);
  arc(100, 135, 150, 50, degrees(-180), degrees(180));
}

void serialEvent(Serial p) {
  String message = myPort.readStringUntil(13);
  if (message != null) {
    emotion = message;
    print(emotion);
  }
}

void mousePressed() {
  //if (emotion.contains("happy")) {
    OscMessage myMessage = new OscMessage("/foo/notes");
    myMessage.add(1);
    oscP5.send(myMessage, myRemoteLocation);
    println("message sent!");
  //} else if (emotion.contains("sad")) {
  //  OscMessage myMessage = new OscMessage("/foo/notes");
  //  myMessage.add(2);
  //  oscP5.send(myMessage, myRemoteLocation);
  //}
}
