#include "SoftwareSerial.h"
#include "stdio.h"
#include "string.h"

SoftwareSerial esp(2,3);// RX, TX
String string;
 String width;
String starts="start";
String complete="process";
String shut="closed";
bool b;
    String tmpResp;
void setup() {
  
  
esp.begin(115200);

Serial.begin(115200);
httppost();
 esp.println("AT+CIPSEND=0,7");//start a TCP connection.
    if(esp.find(">")) { 
      Serial.println("Sending.."); 
      esp.println(starts);
    }
      
     while(esp.readString()){
       tmpResp=esp.readString();
     //  Serial.println(tmpResp); // Should be just "Herld!"
      int first = tmpResp.indexOf(':');
      int second =tmpResp.indexOf('\n');
      int third = tmpResp.indexOf(':', second + 1);
   //   String width = tmpResp.substring(0, first);
      String ok = tmpResp.substring(first+1 ,first+3 );
   //   String animationSpeed = tmpResp.substring(second + 1, third);
      // String isAnimation = tmpResp.substring(first,0);
     //   Serial.println(width);
        Serial.println(ok);
        
        if(ok=="ok")
        {
            result();
             Serial.println("ok is success");
             break;
        }
      
      //  Serial.println(animationSpeed);
     
       // tmpResp.remove(2,8); // Remove six characters starting at index=2
      //  Serial.println("String after removing six characters starting at the third position");
      //  Serial.println(tmpResp); // Should be just "Herld!"
      //  tmpResp.remove(1,4); // Remove six characters starting at index=2
     //   Serial.println(tmpResp);
        
       }
     /* while(esp.readString()){
      tmpResp=esp.readString();
     
      
 //     int first = tmpResp.indexOf(':');
 //     int second =tmpResp.indexOf(first+1);
   //   width =  tmpResp.substring(0, second);
  //    Serial.println( width); 
  //    String ok = tmpResp.substring(first +2, second);
      //Serial.println(ok); 
      //Serial.println(tmpResp); 
     // s.Concate(");
     // char tmpResp[100]  =s; 
      //Serial.println( width);    
      }
         
      //process();
     // result();*/

  }
 
  // put your setup code here, to run once:



void loop() {
   //   tmpResp=esp.readString();
  //    Serial.println(tmpResp);
      // Serial.println( width);  

  //result();
/*   while(1){
    tmpResp=esp.readString();
  tmpResp.remove(2, 8); // Remove six characters starting at index=2
  Serial.println("String after removing six characters starting at the third position");
  Serial.println(tmpResp); // Should be just "Herld!"
   }*/
  
}

void process(){
     
      result();
}

void result(){
  
  

   esp.println("AT+CIPSEND=0,9");//start a TCP connection.
    if(esp.find(">")) { 
     Serial.println("Sending.. process"); 
      esp.println("process");
    //  tmpResp="";
    
}
}


void httppost () {

  
esp.println("AT+CIFSR");

String ip = esp.readString();
Serial.println(ip);
delay(1000);
esp.println("AT+CIPMUX=1");
String mux = esp.readString();
Serial.println(mux);

esp.println("AT+CIPSERVER=1,139");//start a TCP connection.

if( esp.find("OK")) {

//Serial.println("Connected to server");
// delay(1000);
// delay(1000);
}
}
