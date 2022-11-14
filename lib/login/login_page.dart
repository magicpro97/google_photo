import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import '../shared/widgets/full_screen_loading_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  void _onGoogleSignInButtonPressed() {

  }

  @override
  Widget build(BuildContext context) {
    return FullScreenLoadingPage(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SignInButton(
              Buttons.Google,
              onPressed: _onGoogleSignInButtonPressed,
            ),
          ] ,
        ),
      ),
    );
  }
}
