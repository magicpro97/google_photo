import 'package:flash/flash.dart';
import 'package:flutter/cupertino.dart';

class AppError {
  final String message;

  AppError(this.message);
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
          title: const Text('Error'),
          content: Text(
            error.message,
          ),
        ),
      );
    },
  );
}
