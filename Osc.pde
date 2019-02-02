import oscP5.*;
import netP5.*;

byte[] sendBytes = null;
byte[] receiveBytes = null;

String ipNumber = "127.0.0.1";
int sendPort = 7110;
int receivePort = 7111;

OscP5 oscP5;
NetAddress myRemoteLocation;

void oscSetup() {  
  OscProperties op = new OscProperties();
  op.setListeningPort(receivePort);
  op.setDatagramSize(1000000);
  
  oscP5 = new OscP5(this, op);
  myRemoteLocation = new NetAddress(ipNumber, sendPort);  
}

// Receive message example
void oscEvent(OscMessage msg) {
  if (msg.checkAddrPattern("/video") && msg.checkTypetag("b")) {
    
    receiveBytes = msg.get(0).blobValue();

  }
}

void oscSend() {
  try {
    sendBytes = encodeJpeg(sendGfx.get());
  } catch (Exception e) { }
    
  OscMessage msg;
  msg = new OscMessage("/video");
  msg.add(sendBytes);
  try {
    oscP5.send(msg, myRemoteLocation);
  } catch (Exception e) { }
}
