import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

/*Login with Username & Password*/
class DefaultLoginLoading extends LoginState {}
class DefaultLoginLoaded extends LoginState {
  final List<String> response;

  DefaultLoginLoaded({required this.response});
}
class DefaultLoginFailed extends LoginState {
  final String error;

  DefaultLoginFailed({required this.error});
}

/*Login with Biometric*/
class BiometricLoginLoading extends LoginState {}
class BiometricLoginLoaded extends LoginState {
  final String response;

  BiometricLoginLoaded({required this.response});
}
class BiometricLoginFailed extends LoginState {
  final String error;

  BiometricLoginFailed({required this.error});
}