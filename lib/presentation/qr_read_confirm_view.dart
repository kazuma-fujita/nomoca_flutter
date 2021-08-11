import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/constants/route_names.dart';
import 'package:nomoca_flutter/data/entity/remote/preview_cards_entity.dart';
import 'package:nomoca_flutter/presentation/arguments/qr_read_confirm_argument.dart';
import 'package:nomoca_flutter/states/providers/registration_card_provider.dart';

class QrReadConfirmView extends HookConsumerWidget {
  const QrReadConfirmView({this.args});

  final QrReadConfirmArgument? args;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 診察券登録ボタン押下時処理
    ref.watch(registrationCardProvider).when(
      data: (isSuccess) async {
        if (isSuccess) {
          // ローディング非表示
          await EasyLoading.dismiss();
          // 今までのスタックを削除してプロフィール画面へ遷移。引数にSnackBarで表示するメッセージを設定
          await Navigator.pushNamedAndRemoveUntil(
            context,
            RouteNames.userManagement,
            (_) => false,
            arguments: '診察券を登録しました',
          );
        }
      },
      loading: () async {
        // ローディング表示
        await EasyLoading.show();
      },
      error: (error, _) {
        // ローディング非表示
        EasyLoading.dismiss();
        // SnackBar表示
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(error.toString())));
        });
      },
    );

    final asyncValue = ref.watch(registrationCardProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('診察券登録'),
        actions: [
          TextButton(
            // 読み込み中はボタンdisabled
            onPressed: () => asyncValue is AsyncLoading
                ? null
                : ref.read(registrationCardProvider.notifier).registration(
                      sourceUserId: args!.entity.sourceUserId,
                      familyUserId: args!.familyUserId,
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
                itemCount: args!.entity.patients.length,
                itemBuilder: (BuildContext context, int index) {
                  return _listItem(args!.entity.patients[index], context, ref);
                }),
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
}
