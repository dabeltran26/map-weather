import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_weather/register/bloc/register_bloc.dart';
import 'package:map_weather/register/widgets/register_form.dart';
import 'package:map_weather/repository/user_repository.dart';

class RegisterPage extends StatelessWidget {
  final UserRepository _userRepository = UserRepository();

  RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(_userRepository),
          child: const RegisterForm(),
        ),
      ),
    );
  }
}