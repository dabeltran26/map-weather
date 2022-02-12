part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class OnNewUserLocationEvent extends HomeEvent {
  final LatLng newLocation;
  final List<Marker> customMarkers;
  const OnNewUserLocationEvent(this.newLocation,this.customMarkers);
}