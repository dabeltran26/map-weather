import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_weather/home/bloc/location/home_bloc.dart';
import 'package:map_weather/home/bloc/map/map_bloc.dart';

class BtnCurrentLocation extends StatelessWidget {
  
  const BtnCurrentLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final locationBloc = BlocProvider.of<HomeBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);

    return Container(
      margin: const EdgeInsets.only( bottom: 10 ),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: const Icon( Icons.my_location_outlined, color: Colors.black ),
          onPressed: () {

            final userLocation = locationBloc.state.myLocation;

            if ( userLocation == null ) {
                return;
            }
            mapBloc.moveCamera(userLocation);
          }
        ),
      ),
    );
  }
}