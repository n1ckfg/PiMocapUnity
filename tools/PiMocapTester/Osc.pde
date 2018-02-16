import oscP5.*;
import netP5.*;

String ipNumber = "127.0.0.1";
int sendPort = 9999;
int receivePort = 9998;
OscP5 oscP5;
NetAddress myRemoteLocation;

void oscSetup() {
  oscP5 = new OscP5(this, receivePort);
  myRemoteLocation = new NetAddress(ipNumber, sendPort);
}

// Send message example
void sendOsc() {
  OscMessage myMessage;

  myMessage = new OscMessage("/pos");
  myMessage.add((mouseX-pmouseX) * (destWidth/width));
  myMessage.add((mouseY-pmouseY) * (destHeight/height));
  myMessage.add(clicked);
  oscP5.send(myMessage, myRemoteLocation);
} 

// Receive message example
void oscEvent(OscMessage msg) {
  if (msg.checkAddrPattern("/pos") && msg.checkTypetag("f")) {
    //
  }
}