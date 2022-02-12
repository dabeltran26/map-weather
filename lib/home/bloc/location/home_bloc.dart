import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show BitmapDescriptor, InfoWindow, LatLng, Marker, MarkerId;
import 'package:map_weather/home/repository/home_repository.dart';
import 'package:map_weather/models/places_models.dart';
import 'package:map_weather/models/weather_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  
  StreamSubscription<Position>? positionStream;
  HomeRepository homeRepository  = HomeRepository();
  Weather?  myWeather;
  List<Marker> customMarkers = [];

  HomeBloc() : super( const HomeState() ) {
    on<OnNewUserLocationEvent>((event, emit)  async {
      emit( 
        state.copyWith(
          myLocation: event.newLocation,
          temperature: myWeather?.main.temp.toInt(),
          customMarkers: event.customMarkers
        ) 
      );
    });
  }

  Future getCurrentPosition() async {
    final position = await Geolocator.getCurrentPosition();
    String? city = await homeRepository.getCountry(LatLng( position.latitude, position.longitude ));
    myWeather =  await homeRepository.getWeather(city!);
    add( OnNewUserLocationEvent( LatLng( position.latitude, position.longitude ) ,customMarkers) );
  }

  Future searchPlaces(String query) async {
    customMarkers = [];
    final position = await Geolocator.getCurrentPosition();
    List<Feature>  places = await homeRepository.getResultsByQuery(LatLng( position.latitude, position.longitude ),query);

    for(int i = 0; i <places.length;i++){
      if(places[i].geometry.coordinates != null){
        customMarkers.add(Marker(
            markerId: MarkerId(places[i].placeName),
            position: LatLng(places[i].geometry.coordinates[0], places[i].geometry.coordinates[1]),
            infoWindow: InfoWindow(
              title: places[i].placeName,
            ),
            icon: BitmapDescriptor.defaultMarker
        ));
      }
    }
    add( OnNewUserLocationEvent( LatLng( position.latitude, position.longitude ) ,customMarkers) );
  }

}
