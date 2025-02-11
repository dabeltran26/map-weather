import 'package:bloc/bloc.dart';
import 'package:map_weather/register/bloc/register_event.dart';
import 'package:map_weather/register/bloc/register_state.dart';
import 'package:map_weather/repository/user_repository.dart';
import 'package:map_weather/utils/validators.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository _userRepository;

  RegisterBloc(this._userRepository) : super(RegisterState.empty()) {

    on<EmailChanged>( (event, emit ) async {
      emit(state.update(
          isEmailValid: Validators.isValidEmail(event.email)
      ));
    });

    on<PasswordChanged>( (event, emit ) async {
      emit(state.update(
          isPasswordValid: Validators.isValidPassword(event.password)
      ));
    });

    on<Submitted>( (event, emit ) async {
      emit(RegisterState.loading());
      try{
        await _userRepository.signUp(event.email, event.password);
        emit(RegisterState.success());
      }catch(_){
        emit(RegisterState.failure());
      }
    });

  }
  
}
