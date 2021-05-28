import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/main.dart';

class PatientCardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('診察券'),
      ),
      body: _PatientCardView(),
    );
  }
}

class _PatientCardView extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final state = useProvider(signupViewModelProvider);
    state.when(
      data: (isSuccess) {
        if (isSuccess as bool) {
          print('isSuccess');
        } else {
          print('here now');
        }
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
          context.read(signupViewModelProvider.notifier).signUp(
                mobilePhoneNumber: '',
                nickname: '',
              );
        },
        child: const Text('登録する'),
      ),
    );
  }
}
