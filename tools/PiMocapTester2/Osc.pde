import oscP5.*;
import netP5.*;

String ipNumber = "127.0.0.1";
int sendPort = 7110;
int receivePort = 9998;
OscP5 oscP5;
NetAddress myRemoteLocation;

String hostName1 = "RPi_180219175326360";
String hostName2 = "RPi_180219180801264";

void oscSetup() {
  oscP5 = new OscP5(this, receivePort);
  myRemoteLocation = new NetAddress(ipNumber, sendPort);
}

// Send message example
void sendOsc() {
  OscMessage myMessage;

  myMessage = new OscMessage("/blob");
  myMessage.add(hostName1);
  myMessage.add(0);
  myMessage.add(1 / (width/2));
  myMessage.add(1 / height);
  oscP5.send(myMessage, myRemoteLocation);
  
  myMessage = new OscMessage("/blob");
  myMessage.add(hostName2);
  myMessage.add(0);
  myMessage.add((1 - (width/2)) / (width/2));
  myMessage.add(1 / height);
  oscP5.send(myMessage, myRemoteLocation);
} 

// Receive message example
void oscEvent(OscMessage msg) {
  if (msg.checkAddrPattern("/pos") && msg.checkTypetag("f")) {
    //
  }
}
