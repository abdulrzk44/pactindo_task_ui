import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pactindo_task_ui/data/repository/check_account_repository.dart';
import 'package:pactindo_task_ui/feature/splash_screen/splash_screen_event.dart';
import 'package:pactindo_task_ui/feature/splash_screen/splash_screen_state.dart';

class SplashScreenBloc extends Bloc {
  CheckAccountRepository? checkaccountRepository;

  SplashScreenBloc({this.checkaccountRepository}) : super(InitialEvent()) {
    on<SplashScreenEvent>((event, emit) async {
      if (event is CheckUserEvent) {
        emit(CheckUserLoading());
        try {
          final response = await checkaccountRepository!.checkAccount();
          emit(CheckUserLoaded(response: response));
        } catch (e) {
          emit(CheckUserFailed(error: e.toString()));
        }
      }
    });
  }
}