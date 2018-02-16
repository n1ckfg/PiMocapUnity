import oscP5.*;
import netP5.*;

String ipNumber = "127.0.0.1";
int sendPort = 9998;
int receivePort = 9999;
OscP5 oscP5;
NetAddress myRemoteLocation;

void oscSetup() {
  oscP5 = new OscP5(this, receivePort);
  myRemoteLocation = new NetAddress(ipNumber, sendPort);
}

// Send message example
void sendOsc() {
  OscMessage myMessage;

  myMessage = new OscMessage("/blob");
  myMessage.add("nfgRPi1");
  myMessage.add(1);
  myMessage.add(dot1.p.x / width);
  myMessage.add(dot1.p.y / height);
  oscP5.send(myMessage, myRemoteLocation);
  
  myMessage = new OscMessage("/blob");
  myMessage.add("nfgRPi2");
  myMessage.add(1);
  myMessage.add(dot2.p.x / width);
  myMessage.add(dot2.p.y / height);
  oscP5.send(myMessage, myRemoteLocation);
} 

// Receive message example
void oscEvent(OscMessage msg) {
  if (msg.checkAddrPattern("/blob") && msg.checkTypetag("siff")) {
    if (msg.get(0).stringValue().equals("nfgRPi1")) {
      dot1.p = new PVector(msg.get(2).floatValue() * (width/2), msg.get(3).floatValue() * height);
    } else if (msg.get(0).stringValue().equals("nfgRPi2")) {
      dot2.p = new PVector(msg.get(2).floatValue() * (width/2) + (width/2), msg.get(3).floatValue() * height);
    }
  }
}