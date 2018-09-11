import oscP5.*;
import netP5.*;

String ipNumber = "127.0.0.1";
int sendPort = 9998;
int receivePort = 7110;
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
  myMessage.add(1);
  myMessage.add(dot1.p.x / width);
  myMessage.add(dot1.p.y / height);
  oscP5.send(myMessage, myRemoteLocation);
  
  myMessage = new OscMessage("/blob");
  myMessage.add(hostName2);
  myMessage.add(1);
  myMessage.add(dot2.p.x / width);
  myMessage.add(dot2.p.y / height);
  oscP5.send(myMessage, myRemoteLocation);
} 

// Receive message example
void oscEvent(OscMessage msg) {
  if (msg.checkAddrPattern("/blob") && msg.checkTypetag("siff")) {
    println(msg.get(0).stringValue() + " " + msg.get(1).intValue() + " " + msg.get(2).floatValue() + " " + msg.get(3).floatValue());
    
    if (msg.get(0).stringValue().equals(hostName1)) {
      dot1.p = new PVector(msg.get(2).floatValue() * width, msg.get(3).floatValue() * height);
    } else if (msg.get(0).stringValue().equals(hostName2)) {
      dot2.p = new PVector(msg.get(2).floatValue() * width + (width/2), msg.get(3).floatValue() * height);
    }
  }
}