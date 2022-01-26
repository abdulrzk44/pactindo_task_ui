import 'package:equatable/equatable.dart';

class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialEvent extends LoginEvent {}

class DefaultLogin extends LoginEvent {
  DefaultLogin();
}

class BiometricLogin extends LoginEvent {
  // final String username;
  // final String password;

  BiometricLogin();
}