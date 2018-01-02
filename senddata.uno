#include "SoftwareSerial.h"
String ssid ="CTPL2018";

String password="12345678";

SoftwareSerial esp(2,3);// RX, TX

String starts="started";
String complete="completed";
String shut="closed";

String server = "192.168.43.56";

String uri = "";

int DHpin = 8;//sensor pin

byte dat [5];

String temp ,hum;

void setup() {

//pinMode (DHpin, OUTPUT);

esp.begin(115200);

Serial.begin(115200);

//reset();

//connectWifi();

httppost();

}

//reset the esp8266 module

void reset() {

esp.println("AT+RST");

delay(1000);

if(esp.find("OK") ) Serial.println("Module Reset");

}

//connect to your wifi network

void connectWifi() {

String cmd = "AT+CWJAP=\"" +ssid+"\",\"" + password + "\"";

esp.println(cmd);


delay(4000);

if(esp.find("OK")) {

 delay(1000);

Serial.println("Connected!");

}

else {

connectWifi();

Serial.println("Cannot connect to wifi"); }

}

void loop () {

//start_test ();

// convert the bit data to string form

//hum = String(dat[0]);

//temp= String(dat[2]);

//data = "temperature=" + temp + "&humidity=" + hum;// data sent must be under this form //name1=value1&name2=value2.

}

void httppost () {

  
esp.println("AT+CIFSR");

String ip = esp.readString();
Serial.println(ip);
delay(1000);
esp.println("AT+CIPMUX=1");
String mux = esp.readString();
Serial.println(mux);
esp.println("AT+CIPSERVER=1,3333");//start a TCP connection.

if( esp.find("OK")) {

Serial.println("Connected to server");
 delay(1000);
 delay(1000);
  
  packet();

//Serial.println(postRequest);
//Serial.println(postRequest.length());
/*String sendCmd = "AT+CIPSEND=0,7";//determine the number of caracters to be sent.

esp.println(sendCmd);
delay(700);
//esp.println(postRequest.length() );
if(esp.find(">")) { 
  
  Serial.println("Sending.."); 
  esp.println(data);

if( esp.find("Send ok")) 
{ 
  Serial.println("Packet sent");

while (esp.available()) {

String tmpResp = esp.readString();

Serial.println(tmpResp);

}
}*/
}
}

// close the connection

//esp.println("AT+CIPCLOSE");
void packet(){
  while (esp.available()) {

  String tmpResp = esp.readString();

  Serial.println(tmpResp);
  if(esp.find("start")){
    esp.println("AT+CIPSEND=0,7");//start a TCP connection.
    if(esp.find(">")) { 
  
    Serial.println("Sending.."); 
      esp.println(starts);
    }
    break;
    
 }
  else if(esp.find("complete")){
    esp.println("AT+CIPSEND=0,9");//start a TCP connection.
    if(esp.find(">")) { 
  
    Serial.println("Sending.."); 
      esp.println(complete);
    }
    break;
 }
  else if(esp.find("close")){
    esp.println("AT+CIPSEND=0,6");//start a TCP connection.
    if(esp.find(">")) { 
  
    Serial.println("Sending.."); 
      esp.println(shut);
      break;
    }
 }
 
  return;
  }

}



