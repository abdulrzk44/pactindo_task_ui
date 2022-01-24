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

class PrefResi extends ResiEvent {
  final String username;
  final String password;

  PrefResi({required this.username, required this.password});
}