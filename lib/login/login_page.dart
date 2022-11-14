import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import '../app/di/dependencies.dart';
import '../app/router/app_router.dart';
import '../shared/error.dart';
import '../shared/widgets/full_screen_loading_page.dart';
import 'login_page_bloc.dart';

class LoginPage extends StatelessWidget implements AutoRouteWrapper {
  const LoginPage({Key? key}) : super(key: key);

  void _onGoogleSignInButtonPressed(BuildContext context) {
    context.read<LoginPageBloc>().add(Login());
  }

  void _loginPageBlocListener(
    BuildContext context,
    LoginPageState state,
  ) {
    if (state is LoginSuccess) {
      context.replaceRoute(const HomeRoute());
    } else if (state is LoginError) {
      showError(context, state.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginPageBloc, LoginPageState>(
      listener: _loginPageBlocListener,
      builder: _loginPageBlocBuilder,
    );
  }

  Widget _loginPageBlocBuilder(
    BuildContext context,
    LoginPageState state,
  ) {
    return FullScreenLoadingPage(
      isLoading: state is LoginPageLoading ? state.isLoading : false,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SignInButton(
              Buttons.Google,
              onPressed: () => _onGoogleSignInButtonPressed(context),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<LoginPageBloc>(
      create: (_) => getIt(),
      child: this,
    );
  }
}
