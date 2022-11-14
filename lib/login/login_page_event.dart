part of 'login_page_bloc.dart';

abstract class LoginPageEvent extends Equatable {
  const LoginPageEvent();
}

class Login extends LoginPageEvent {
  @override
  List<Object?> get props => [];
}