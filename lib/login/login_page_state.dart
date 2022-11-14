part of 'login_page_bloc.dart';

abstract class LoginPageState extends Equatable {
  const LoginPageState();
}

class LoginPageLoading extends LoginPageState {
  final bool isLoading;

  const LoginPageLoading(this.isLoading);
  
  @override
  List<Object> get props => [isLoading];
}

class LoginError extends LoginPageState {
  final AppError error;

  const LoginError(this.error);

  @override
  List<Object> get props => [error];
}

class LoginSuccess extends LoginPageState {
  @override
  List<Object?> get props => [];
}