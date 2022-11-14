import 'package:flutter/material.dart';

class FullScreenLoadingPage extends StatelessWidget {
  const FullScreenLoadingPage({
    Key? key,
    this.isLoading = false,
    this.body,
    this.appBar,
  }) : super(key: key);

  final bool isLoading;
  final Widget? body;
  final PreferredSizeWidget? appBar;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: appBar,
          body: body,
        ),
        Visibility(
          visible: isLoading,
          child: const Positioned.fill(
            child: SafeArea(
              child: Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
