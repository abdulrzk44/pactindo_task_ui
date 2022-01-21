import 'package:equatable/equatable.dart';

class ResiState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SubmitResiLoading extends ResiState {}
class SubmitResiLoaded extends ResiState {
  final int response;

  SubmitResiLoaded({required this.response});
}
class SubmitResiFailed extends ResiState {
  final String error;

  SubmitResiFailed({required this.error});
}