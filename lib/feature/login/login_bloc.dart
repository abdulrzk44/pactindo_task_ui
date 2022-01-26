import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pactindo_task_ui/data/repository/login_repository.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc{
  final LoginRepository? loginRepository;

  LoginBloc({this.loginRepository}) : super(InitialEvent()) {
    on<LoginEvent>((event, emit) async {
      if (event is DefaultLogin) {
        emit(DefaultLoginLoading());
        try {
          final response = await loginRepository!.getDataLogin();
          emit(DefaultLoginLoaded(response: response));
        } catch (e) {
          emit(DefaultLoginFailed(error: e.toString()));
        }
      }else if (event is BiometricLogin) {
        emit(BiometricLoginLoading());
        try {
          final response2 = await loginRepository!.getBiometricLogin();
          emit(BiometricLoginLoaded(response: response2));
        } catch (e) {
          emit(BiometricLoginFailed(error: e.toString()));
        }
      }
    });
  }
}