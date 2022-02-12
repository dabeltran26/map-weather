import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_weather/home/bloc/gps/gps_bloc.dart';
import 'package:map_weather/home/screens/gps_access_screen.dart';
import 'package:map_weather/home/screens/home_screen.dart';

class LoadingScreen extends StatelessWidget {
   
   const LoadingScreen({Key? key}) : super(key: key);
   
   @override
   Widget build(BuildContext context) {
   return Scaffold(
      body: BlocBuilder<GpsBloc, GpsState>(
        builder: (context, state) {
          return state.isAllGranted
            ? const MapScreen()
            : const GpsAccessScreen();
        },
      )
   );
   }
}