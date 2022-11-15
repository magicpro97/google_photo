import 'package:auto_route/auto_route.dart';
import 'package:flash/flash.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_photo/app/router/app_router.dart';

import '../generated/l10n.dart';

class AppError {
  final String message;

  AppError(this.message);
}

class UnauthorizedError extends AppError {
  UnauthorizedError(super.message);

  @override
  String get message => S.current.session_expired;
}

Future<void> showError(
  BuildContext context,
  AppError error,
) {
  return showFlash(
    context: context,
    duration: const Duration(seconds: 3),
    builder: (_, controller) {
      return Flash.bar(
        controller: controller,
        child: FlashBar(
          title: Text(S.current.error),
          content: Text(
            error.message,
          ),
        ),
      );
    },
  ).then((value) {
    if (error is UnauthorizedError) {
      context.replaceRoute(const LoginRoute());
    }
  });
}
