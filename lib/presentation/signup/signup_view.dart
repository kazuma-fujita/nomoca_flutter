import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/main.dart';
import 'package:nomoca_flutter/presentation/signup/signup_view_model.dart';

class SignupView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('アカウント登録'),
      ),
      body: _SignupView(),
    );
  }
}

class _SignupView extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final state = useProvider(signupViewModelProvider) as AsyncData<void>;
    // ignore: cascade_invocations
    state.when(
      data: (data) {
        print('data here');
      },
      loading: () {
        print('loading here');
      },
      error: (error, _) {
        print('error here $error');
      },
    );
    return Center(
      child: ElevatedButton(
        onPressed: () {
          context.read(signupViewModelProvider).signup();
        },
        child: const Text('登録する'),
      ),
    );
  }
}
