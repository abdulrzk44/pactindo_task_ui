import 'package:equatable/equatable.dart';

class SplashScreenState extends Equatable {
  @override
  List<Object?> get props => []; 
}

class CheckUserLoading extends SplashScreenState {}
class CheckUserLoaded extends SplashScreenState {
  final bool? response;

  CheckUserLoaded({this.response});
}
class CheckUserFailed extends SplashScreenState {
  final String? error;

  CheckUserFailed({this.error});
}