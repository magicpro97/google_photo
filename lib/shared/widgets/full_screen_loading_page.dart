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
        LoadingOverlay(
          loadCondition: isLoading,
        ),
      ],
    );
  }
}

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({
    Key? key,
    required this.loadCondition,
    this.progress,
  }) : super(key: key);

  final bool loadCondition;
  final double? progress;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: loadCondition,
      child: Positioned.fill(
        child: Container(
          color: Colors.white.withOpacity(.7),
          child: Center(
            child: progress == null
                ? const CircularProgressIndicator.adaptive()
                : CircularProgressIndicator(
                    value: progress,
                  ),
          ),
        ),
      ),
    );
  }
}
