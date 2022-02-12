import 'package:bloc/bloc.dart';
import 'package:map_weather/login/bloc/login_event.dart';
import 'package:map_weather/repository/user_repository.dart';
import 'package:map_weather/utils/validators.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent,LoginState> {

  final UserRepository _userRepository;
  LoginBloc(this._userRepository) : super( LoginState.empty() ) {

    on<EmailChanged>( (event, emit ) async {
      emit(state.update(isEmailValid: Validators.isValidEmail(event.email)
      ));
    });

    on<PasswordChanged>( (event, emit ) async {
      emit(state.update(isPasswordValid: Validators.isValidPassword(event.password)));
    });

    on<LoginWithCredentials>( (event, emit ) async {
      emit(LoginState.loading());
      try{
        await _userRepository.signInWithCredentials(event.email, event.password);
        emit(LoginState.success());
      }catch(_){
        emit(LoginState.failure());
      }
    });

  }

}