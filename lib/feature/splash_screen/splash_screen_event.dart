import 'package:equatable/equatable.dart';

class SplashScreenEvent extends Equatable {
  @override
  List<Object?> get props => []; 
}

class InitialEvent extends SplashScreenEvent {}

class CheckUserEvent extends SplashScreenEvent {}