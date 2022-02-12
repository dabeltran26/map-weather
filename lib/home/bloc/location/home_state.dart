part of 'home_bloc.dart';

class HomeState extends Equatable {
  final LatLng? myLocation;
  final int temperature;
  final List<Marker>? customMarkers;

  const HomeState(
      {
        this.customMarkers,
      this.myLocation,
      this.temperature = 0});

  HomeState copyWith({
    List<Marker>? customMarkers,
    LatLng? myLocation,
    int? temperature,
  }) =>
      HomeState(
        customMarkers: customMarkers ?? this.customMarkers,
        myLocation: myLocation ?? this.myLocation,
        temperature: temperature ?? this.temperature,
      );

  @override
  List<Object?> get props =>
      [ myLocation, temperature,customMarkers];
}
