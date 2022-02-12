import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_weather/home/bloc/location/home_bloc.dart';
import 'package:map_weather/utils/colors.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeBloc = BlocProvider.of<HomeBloc>(context);
    TextEditingController searchController = TextEditingController();
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only( top: 10,left: 0 ),
        padding: const EdgeInsets.symmetric( horizontal: 10 ),
        width: 300,
        child: Container(
          decoration: BoxDecoration(
              color: GeneralColors.white,
              borderRadius: BorderRadius.circular(100),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    offset: Offset(0,5)
                )
              ]
          ),
          padding: const EdgeInsets.symmetric( horizontal: 18, vertical: 8),
          child: TextField(
            controller: searchController,
            onEditingComplete: () {
              homeBloc.searchPlaces(searchController.text);
            },
            style: const TextStyle(color: Colors.black),
            cursorColor: Colors.black,
            autofocus: true,
            decoration: const InputDecoration(
              focusColor: GeneralColors.black,
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: GeneralColors.white)),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: GeneralColors.white)),
            ),
          ),
        )
        ),
      );
  }
}