#include <ESP8266WiFi.h>
#include <FirebaseESP8266.h>
#include "HX711.h"
#include <LiquidCrystal_I2C.h>
#include <SPI.h>
#include <MFRC522.h>

#define WIFI_SSID "******"      // SSID
#define WIFI_PASSWORD "******"  // Password

#define DATABASE_URL "nodemcu-ac498-default-rtdb.firebaseio.com" //<databaseName>.firebaseio.com or <databaseName>.<region>.firebasedatabase.app
#define DATABASE_SECRET "rcp3WJs0ArgiIZTOPt4GLOU1pKnAIOr88BY1H4g2"

FirebaseData fbdo;
FirebaseAuth auth;
FirebaseConfig config;

unsigned long sendDataPrevMillis = 0;

HX711 scale;

const int LOADCELL_DOUT_PIN = D5;
const int LOADCELL_SCK_PIN = D6;

float weight_total = 0.0;
float weight_added = 0.0;
float weight_old = 0.0;

float calibration_factor = -83297;

void setup()
{

  Serial.begin(9600);
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("Connecting to Wi-Fi");
  while (WiFi.status() != WL_CONNECTED)
  {
    Serial.print(".");
    delay(300);
  }
  Serial.println();
  Serial.print("Connected with IP: ");
  Serial.println(WiFi.localIP());
  Serial.println();

  Serial.printf("Firebase Client v%s\n\n", FIREBASE_CLIENT_VERSION);
  config.database_url = DATABASE_URL;
  config.signer.tokens.legacy_token = DATABASE_SECRET;
  Firebase.reconnectWiFi(true);
  Firebase.begin(&config, &auth);

  scale.begin(LOADCELL_DOUT_PIN, LOADCELL_SCK_PIN);

  scale.set_scale();
  scale.tare(); //Reset the scale to 0

  long zero_factor = scale.read_average(); //Get a baseline reading
  Serial.print("Zero factor: "); //This can be used to remove the need to tare the scale. Useful in permanent scale projects.
  Serial.println(zero_factor);
  scale.tare();

}

void loop() {

  scale.set_scale(calibration_factor);

  if (scale.is_ready()) {

    Serial.print("Reading: ");
    Serial.print(scale.get_units(), 3);
    Serial.print(" kg");

    weight_total = scale.read();
    Serial.print("HX711 reading: ");
    Serial.println(weight_total);
  } else {
    Serial.println("HX711 not found.");
  }

  // Code for JSON handling. Currently broken
  //  if (Firebase.ready() && (millis() - sendDataPrevMillis > 15000 || sendDataPrevMillis == 0))
  //  {
  //    FirebaseJson json;
  //    json.add("ID", "6G34");
  //    json.add("IN_USE", true);
  //    json.add("weight", weight);
  //
  //    Serial.printf("Push json... %s\n", Firebase.pushJSON(fbdo, "/6G34", json) ? "ok" : fbdo.errorReason().c_str());
  //  }

  weight_added = weight_total - weight_old;

  Firebase.setFloat(fbdo, "/6G34/WEIGHT_TOTAL", weight_total);
  Firebase.setFloat(fbdo, "/6G34/WEIGHT_ADDED", weight_added);
  Firebase.setFloat(fbdo, "/6G34/WEIGHT_PREV_TOTAL", weight_old);

  weight_old = weight_total;

  Firebase.setTimestamp(fbdo, "/6G34/LAST_READ_TIME");

  delay(10000);
}
