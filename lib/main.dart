import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_weather/authentication/authentication_bloc/authentication_bloc.dart';
import 'package:map_weather/authentication/authentication_bloc/authentication_event.dart';
import 'package:map_weather/authentication/authentication_bloc/authentication_state.dart';
import 'package:map_weather/home/bloc/gps/gps_bloc.dart';
import 'package:map_weather/home/bloc/location/home_bloc.dart';
import 'package:map_weather/home/bloc/map/map_bloc.dart';
import 'package:map_weather/login/login_page.dart';
import 'package:map_weather/repository/user_repository.dart';
import 'home/screens/loading_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final UserRepository userRepository = UserRepository();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => AuthenticationBloc(userRepository)..add(AppStarted())),
      BlocProvider(create: (_) => GpsBloc()),
      BlocProvider(create: (context) => HomeBloc() ),
      BlocProvider(create: (context) => MapBloc() )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'weather app',
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: ( _ , state) {
          if (state is Uninitialized) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is Authenticated) {
            return const LoadingScreen();
          }
          if (state is Unauthenticated) {
            return LoginPage();
          }
          return Container();
        },
      ),
    );
  }
}