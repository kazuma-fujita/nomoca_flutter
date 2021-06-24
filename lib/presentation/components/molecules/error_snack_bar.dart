import 'package:flutter/material.dart';

class ErrorSnackBar extends StatelessWidget {
  const ErrorSnackBar({
    required this.errorMessage,
    required this.callback,
    this.backScreenWidget,
  });
  final String errorMessage;
  final Function() callback;
  final Widget? backScreenWidget;

  @override
  Widget build(BuildContext context) {
    final snackBar = SnackBar(
      content: Text(errorMessage),
      duration: const Duration(days: 365),
      action: SnackBarAction(
        label: '再試行',
        onPressed: () {
          callback();
          // snackBar非表示
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
        },
      ),
    );
    // 全Widgetのbuild後にsnackBarを表示させる
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
    return backScreenWidget ?? Container();
  }
}
