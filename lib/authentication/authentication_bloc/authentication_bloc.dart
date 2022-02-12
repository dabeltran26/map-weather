import 'package:bloc/bloc.dart';
import 'package:map_weather/authentication/authentication_bloc/authentication_event.dart';
import 'package:map_weather/authentication/authentication_bloc/authentication_state.dart';
import 'package:map_weather/repository/user_repository.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {

  final UserRepository _userRepository;
  AuthenticationBloc(this._userRepository) : super( Uninitialized() ) {

    on<AppStarted>( (event, emit ) async {
      try{
        final isSignedIn = await _userRepository.isSignedIn();
        if(isSignedIn){
          final user = await _userRepository.getUser();
          emit(Authenticated(user.toString()));
        }
        else{
          emit(Unauthenticated());
        }
      }catch(_){
        emit(Unauthenticated());
      }
    });


    on<LoggedIn>( (event, emit ) async {
      final user = await _userRepository.getUser();
      emit(Authenticated(user.toString()));
    });

    on<LoggedOut>( (event, emit ) async {
      emit(Unauthenticated());
      _userRepository.singOut();
    });

  }

}