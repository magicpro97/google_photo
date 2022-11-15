import 'package:flutter/material.dart';

class FullScreenLoadingPage extends StatelessWidget {
  const FullScreenLoadingPage({
    Key? key,
    this.isLoading = false,
    this.body,
    this.appBar,
    this.bottomNavigationBar,
    this.floatingActionButton,
  }) : super(key: key);

  final bool isLoading;
  final Widget? body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: appBar,
          body: body,
          bottomNavigationBar: bottomNavigationBar,
          floatingActionButton: floatingActionButton,
        ),
        Visibility(
          visible: isLoading,
          child: Positioned.fill(
            child: Container(
              color: Colors.white.withOpacity(.7),
              child: const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
