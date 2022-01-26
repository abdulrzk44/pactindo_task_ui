import 'package:equatable/equatable.dart';

class ResiState extends Equatable {
  @override
  List<Object?> get props => [];
}

/*Submit to SQFLITE*/
class SubmitResiLoading extends ResiState {}
class SubmitResiLoaded extends ResiState {
  final int response;

  SubmitResiLoaded({required this.response});
}
class SubmitResiFailed extends ResiState {
  final String error;

  SubmitResiFailed({required this.error});
}

/*Shared Preference State*/
class SubmitSharePrefsLoading extends ResiState {}
class SubmitSharePrefsLoaded extends ResiState {
  final int response;

  SubmitSharePrefsLoaded({required this.response});
}
class SubmitSharePrefsFailed extends ResiState {
  final String error;

  SubmitSharePrefsFailed({required this.error});
}