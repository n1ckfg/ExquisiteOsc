import oscP5.*;
import netP5.*;

byte[] videoBytes;

String ipNumber = "127.0.0.1";
int sendPort = 9998;
int receivePort = 7110;
int datagramSize = 100000;

OscP5 oscP5;
NetAddress myRemoteLocation;

void oscSetup() {  
  OscProperties op = new OscProperties();
  op.setListeningPort(receivePort);
  op.setDatagramSize(datagramSize);
  oscP5 = new OscP5(this, op);
  
  myRemoteLocation = new NetAddress(ipNumber, sendPort);
}

// Receive message example
void oscEvent(OscMessage msg) {
  if (msg.checkAddrPattern("/video") && msg.checkTypetag("sb")) {
    
    videoBytes = msg.get(1).blobValue();

  }
}
