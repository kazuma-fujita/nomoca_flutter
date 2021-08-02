import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/constants/route_names.dart';
import 'package:nomoca_flutter/data/entity/remote/preview_cards_entity.dart';
import 'package:nomoca_flutter/states/providers/registration_card_provider.dart';

class QrReadConfirmView extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entity =
        ModalRoute.of(context)!.settings.arguments as PreviewCardsEntity?;
    // final args = RegistrationCardProviderArguments(
    //   sourceUserId: entity!.sourceUserId,
    //   familyUserId: null,
    // );
    final asyncValue = ref.watch(registrationCardProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('診察券登録'),
        actions: [
          TextButton(
            // 読み込み中はボタンdisabled
            onPressed: () => asyncValue is AsyncLoading
                ? null
                : _transitionToNextScreen(
                    context,
                    ref,
                    entity!.sourceUserId,
                    null,
                  ),
            child: Text(
              '登録',
              style: TextStyle(
                color: asyncValue is AsyncLoading ? Colors.grey : null,
                fontWeight: asyncValue is AsyncLoading
                    ? FontWeight.normal
                    : FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const Spacer(),
          const Expanded(
            flex: 1,
            child: Text(
              'こちらの診察券を登録してよろしいでしょうか？',
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 3,
            child: ListView.builder(
              key: UniqueKey(),
              padding: const EdgeInsets.all(16),
              itemCount: entity!.patients.length,
              itemBuilder: (BuildContext context, int index) {
                return _listItem(entity.patients[index], context, ref);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _listItem(
    PreviewCardPatientEntity patients,
    BuildContext context,
    WidgetRef ref,
  ) {
    return ListTile(
      key: Key(patients.institution.institutionId.toString()),
      title: Center(
        child: Text(
          patients.institution.institutionName,
          style: Theme.of(context).textTheme.headline6, // fontSize 20
          textAlign: TextAlign.center,
        ),
      ),
      subtitle: Center(
        child: Text(
          '${patients.nameKana}  診察券番号 ${patients.localId}',
          style: Theme.of(context).textTheme.subtitle1, // fontSize 16
          // style: const TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Future<void> _transitionToNextScreen(
    BuildContext context,
    WidgetRef ref,
    int sourceUserId,
    int? familyUserId,
  ) async {
    await ref
        .read(registrationCardProvider.notifier)
        .registration(sourceUserId: sourceUserId, familyUserId: familyUserId);

    await ref.watch(registrationCardProvider).when(
      data: (_) async {
        // ローディング非表示
        await EasyLoading.dismiss();
        // 今までのスタックを削除してプロフィール画面へ遷移
        await Navigator.pushNamedAndRemoveUntil(
            context, RouteNames.userManagement, (_) => false,
            arguments: '診察券を登録しました');
        // // SnackBar表示
        // ScaffoldMessenger.of(context)
        //     .showSnackBar(const SnackBar(content: Text('診察券を登録しました')));
      },
      loading: () async {
        // ローディング表示
        await EasyLoading.show();
      },
      error: (error, _) {
        // ローディング非表示
        EasyLoading.dismiss();
        // SnackBar表示
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      },
    );
  }
}
