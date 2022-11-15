import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

import '../authencation/authentication_storage.dart';
import '../generated/l10n.dart';
import '../shared/error.dart';

part 'login_page_event.dart';

part 'login_page_state.dart';

@injectable
class LoginPageBloc extends Bloc<LoginPageEvent, LoginPageState> {
  LoginPageBloc(
    this._googleSignIn,
    this._authenticationStorage,
  ) : super(const LoginPageLoading(false)) {
    on<Login>(_onLogin);
  }

  final GoogleSignIn _googleSignIn;
  final AuthenticationStorage _authenticationStorage;

  FutureOr<void> _onLogin(
    Login event,
    Emitter<LoginPageState> emit,
  ) async {
    emit(const LoginPageLoading(true));
    try {
      GoogleSignInAccount? googleAccount;
      if (await _googleSignIn.isSignedIn()) {
        googleAccount = await _googleSignIn.signInSilently();
      } else {
        googleAccount = await _googleSignIn.signIn();
      }
      if (googleAccount != null) {
        final authentication = await googleAccount.authentication;
        _authenticationStorage.saveAccessToken(authentication.accessToken!);
        emit(LoginSuccess());
      } else {
        emit(LoginError(AppError(S.current.login_unsuccessfully)));
      }

      emit(const LoginPageLoading(false));
    } catch (e) {
      emit(const LoginPageLoading(false));
      emit(LoginError(AppError(S.current.login_unsuccessfully)));
    }
  }
}
