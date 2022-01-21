import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pactindo_task_ui/data/repository/registration_repository.dart';
import 'package:pactindo_task_ui/feature/receipt_registration/resi_event.dart';
import 'package:pactindo_task_ui/feature/receipt_registration/resi_state.dart';

class ResiBloc extends Bloc {
  final RegistrationRepository? registrationRepository;

  ResiBloc({this.registrationRepository}) : super(InitialEvent()) {
    on<ResiEvent>((event, emit) async {
      if (event is SubmitResi) {
        emit(SubmitResiLoading());
        try {
          final response = await registrationRepository!.registrationSubmit(user: event.user);
          emit(SubmitResiLoaded(response: response));
        } catch (e) {
          emit(SubmitResiFailed(error: e.toString()));
        }
      }
    });
  }
}