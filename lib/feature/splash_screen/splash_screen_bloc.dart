import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pactindo_task_ui/data/repository/account_repository.dart';
import 'package:pactindo_task_ui/feature/splash_screen/splash_screen_event.dart';
import 'package:pactindo_task_ui/feature/splash_screen/splash_screen_state.dart';

class SplashScreenBloc extends Bloc {
  AccountRepository? accountRepository;

  SplashScreenBloc({this.accountRepository}) : super(InitialEvent()) {
    on<SplashScreenEvent>((event, emit) async {
      if (event is CheckUserEvent) {
        emit(CheckUserLoading());
        try {
          final response = await accountRepository!.checkUser();
          emit(CheckUserLoaded(response: response));
        } catch (e) {
          emit(CheckUserFailed(error: e.toString()));
        }
      }
    });
  }
}