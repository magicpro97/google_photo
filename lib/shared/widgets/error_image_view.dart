import 'package:flutter/material.dart';

class ErrorImageView extends StatelessWidget {
  const ErrorImageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(
        Icons.error,
        size: 48,
        color: Colors.red,
      ),
    );
  }
}