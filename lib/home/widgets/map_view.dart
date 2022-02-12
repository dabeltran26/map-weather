import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_weather/home/bloc/map/map_bloc.dart';

class MapView extends StatelessWidget {

  final LatLng initialLocation;
  final List<Marker> customMarkers;

  const MapView({ 
    Key? key, 
    required this.initialLocation,
    required this.customMarkers
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final mapBloc = BlocProvider.of<MapBloc>(context);
    Completer<GoogleMapController> mapController = Completer();

    final CameraPosition initialCameraPosition = CameraPosition(
        target: initialLocation,
        zoom: 15
    );

    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: size.height,
      child: GoogleMap(
        markers: customMarkers.toSet(),
        initialCameraPosition: initialCameraPosition,
        myLocationEnabled: true,
        onMapCreated: ( controller ) {
          mapBloc.add( OnMapInitialzedEvent(controller));
          mapController.complete(controller);
        },
      ),
    );
  }
}