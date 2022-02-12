import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:http/http.dart' as http;
import 'package:map_weather/models/places_models.dart';
import 'package:map_weather/models/weather_model.dart';
import 'package:map_weather/utils/constants.dart';

class HomeRepository {
  final String baseUrl;

  HomeRepository({this.baseUrl = Constants.apiBaseUrl});

  Future<String?> getCountry(LatLng latLng) async {
    final uri = Uri.https('api.openweathermap.org', 'geo/1.0/reverse', {'lat': '${latLng.latitude}','lon': '${latLng.longitude}','limit' : '5','appid': Constants.openWeatherAPIKey });
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        String name = data[0]['name'];
        return name;
      } else {
        return  '';
      }
    } catch (_) {
      if (kDebugMode) {
        print(_);
      }
    }
  }

  Future<Weather?> getWeather(String city) async {

    Map<String, dynamic> cityQueryParameters(String city) => {
          "q": city,
          "appid": Constants.openWeatherAPIKey,
          "units": "metric",
        };

    final uri = Uri(
      scheme: "https",
      host: baseUrl,
      path: Constants.apiPath,
      queryParameters: cityQueryParameters(city),
    );

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        Weather weather = Weather.fromJson(json.decode(response.body));
        return weather;
      } else {
        return null;
      }
    } catch (_) {
      if (kDebugMode) {
        print(_);
      }
    }
  }

  Future<List<Feature>> getResultsByQuery( LatLng proximity, String query ) async {

    if ( query.isEmpty ) return [];

    final uri = Uri(
      scheme: "https",
      host: Constants.apiBaseMapBox,
      path: '/geocoding/v5/mapbox.places/$query.json',
      queryParameters: {
        'access_token': Constants.accessTokenMapBox,
        'limit' : '5'
      },
    );

    final response = await http.get(uri);
    final placesResponse = ResponseSearch.fromJson(json.decode(response.body));
    return placesResponse.features;
  }
}
