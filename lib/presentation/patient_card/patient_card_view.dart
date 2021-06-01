import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/data/entity/remote/patient_card_entity.dart';
import 'package:nomoca_flutter/main.dart';
import 'package:nomoca_flutter/presentation/patient_card/patient_card_view_model.dart';

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
    useEffect(() {
      print('useEffect');
      context.read(patientCardViewModelProvider.notifier).fetchList();
      return () => print('dispose');
    }, const []);

    context.read(patientCardViewModelProvider).when(
      data: (patientCardList) {
        print('fetch data. $patientCardList');
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
