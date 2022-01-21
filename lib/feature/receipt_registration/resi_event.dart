import 'package:equatable/equatable.dart';
import 'package:pactindo_task_ui/model/user.dart';

class ResiEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialEvent extends ResiEvent {}

class SubmitResi extends ResiEvent {
  final User user;

  SubmitResi({required this.user});
}