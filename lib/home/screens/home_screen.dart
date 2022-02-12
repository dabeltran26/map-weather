import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_weather/home/bloc/location/home_bloc.dart';
import 'package:map_weather/home/bloc/map/map_bloc.dart';
import 'package:map_weather/home/widgets/map_view.dart';
import 'package:map_weather/home/widgets/searchbar.dart';
import 'package:map_weather/utils/btn_location.dart';
import 'package:map_weather/utils/colors.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late HomeBloc locationBloc;

  @override
  void initState() {
    super.initState();
    locationBloc = BlocProvider.of<HomeBloc>(context);
    locationBloc.getCurrentPosition();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.myLocation == null) {
            return const Center(child: Text('Loading'));
          }

          state.customMarkers!.isNotEmpty ? mapBloc.moveCamera(state.customMarkers![0].position) : {};
          return SingleChildScrollView(
            child: Stack(
              children: [
                MapView(initialLocation: state.myLocation!,customMarkers: state.customMarkers!),
                const SearchBar(),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Container(
                      decoration: BoxDecoration(
                          color: GeneralColors.black.withOpacity(0.4),
                          shape: BoxShape.circle),
                      height: 50,
                      width: 50,
                      child: Center(
                        child: Text(state.temperature.toString() + '°',
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                ?.copyWith(color: GeneralColors.white)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [BtnCurrentLocation()],
      ),
    );
  }
}
