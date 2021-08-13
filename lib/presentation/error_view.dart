import 'package:flutter/material.dart';
import 'package:nomoca_flutter/constants/route_names.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({this.errorMessage});

  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: _Body(errorMessage: errorMessage),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({this.errorMessage});

  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Spacer(),
        const Text(
          '例外エラーが発生しました',
          textAlign: TextAlign.center,
        ),
        const Spacer(),
        Text(
          errorMessage!,
          textAlign: TextAlign.center,
        ),
        OutlinedButton(
          onPressed: () => Navigator.pushNamed(context, RouteNames.top),
          child: const Text('Topへ戻る'),
        ),
        const Spacer(),
      ],
    );
  }
}
