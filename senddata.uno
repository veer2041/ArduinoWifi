#include "SoftwareSerial.h"
String ssid ="CTPL2018";

String password="12345678";

SoftwareSerial esp(2,3);// RX, TX

String data="started";

String server = "192.168.43.56";

String uri = "";

int DHpin = 8;//sensor pin

byte dat [5];

String temp ,hum;

void setup() {

pinMode (DHpin, OUTPUT);

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

byte read_data () {

byte data;

for (int i = 0; i < 8; i ++) {

if (digitalRead (DHpin) == LOW) {

while (digitalRead (DHpin) == LOW); // wait for 50us

delayMicroseconds (30); // determine the duration of the high level to determine the data is '0 'or '1'

if (digitalRead (DHpin) == HIGH)

data |= (1 << (7-i)); // high front and low in the post

while (digitalRead (DHpin) == HIGH);

// data '1 ', wait for the next one receiver

}

} return data; }

void start_test () {

digitalWrite (DHpin, LOW); // bus down, send start signal

delay (30); // delay greater than 18ms, so DHT11 start signal can be detected

digitalWrite (DHpin, HIGH);

delayMicroseconds (40); // Wait for DHT11 response

pinMode (DHpin, INPUT);

while (digitalRead (DHpin) == HIGH);

delayMicroseconds (80);

// DHT11 response, pulled the bus 80us

if (digitalRead (DHpin) == LOW);

delayMicroseconds (80);

// DHT11 80us after the bus pulled to start sending data

for (int i = 0; i < 4; i ++)

// receive temperature and humidity data, the parity bit is not considered

dat[i] = read_data ();

pinMode (DHpin, OUTPUT);

digitalWrite (DHpin, HIGH);

// send data once after releasing the bus, wait for the host to open the next Start signal

}

void loop () {

//start_test ();

// convert the bit data to string form

//hum = String(dat[0]);

//temp= String(dat[2]);

//data = "temperature=" + temp + "&humidity=" + hum;// data sent must be under this form //name1=value1&name2=value2.




delay(1000);

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


//Serial.println(postRequest);
//Serial.println(postRequest.length());
String sendCmd = "AT+CIPSEND=0,7";//determine the number of caracters to be sent.

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
}

// close the connection

esp.println("AT+CIPCLOSE");

}

}
}
