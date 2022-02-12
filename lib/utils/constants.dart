
import 'package:firebase_auth/firebase_auth.dart';

class Constants {
  static const apiBaseUrl = "api.openweathermap.org";
  static const apiPath = "/data/2.5/weather";
  static const apiBaseMapBox = "api.mapbox.com";
  static var firebaseAuth = FirebaseAuth.instance;
  static String openWeatherAPIKey = '3d4f5519c96bb3326c428389628c9d2a';
  static String accessTokenMapBox = 'pk.eyJ1IjoiZGFiZWx0cmFuIiwiYSI6ImNremZ2NHZxcDBwM2Mydm4yaTh5a2NyaHYifQ.W2_RWMZbNvZ0uN9DrLLEXw';
}