part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginInitialEvent extends LoginEvent {
  final String username, password;

  LoginInitialEvent(this.username, this.password);

  @override
  List<Object> get props => [username, password];
}

class LogoutEvent extends LoginEvent {}
