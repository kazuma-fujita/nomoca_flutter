import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/constants/route_names.dart';
import 'package:nomoca_flutter/data/entity/remote/preview_cards_entity.dart';
import 'package:nomoca_flutter/data/entity/remote/user_nickname_entity.dart';
import 'package:nomoca_flutter/presentation/upsert_user_view_arguments.dart';

class QrReadConfirmView extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entity =
        ModalRoute.of(context)!.settings.arguments as PreviewCardsEntity?;
    return Scaffold(
      appBar: AppBar(
        title: const Text('診察券登録'),
        actions: [
          TextButton(
            // List取得成功時以外は+ボタンdisabled
            onPressed: () => _transitionToNextScreen(context),
            child: const Text('登録'),
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
          style: const TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
      subtitle: Center(
        child: Text(
          '${patients.nameKana}  診察券番号 ${patients.localId}',
          style: const TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Future<void> _transitionToNextScreen(BuildContext context,
      {UserNicknameEntity? user}) async {
    // upsert-user画面へ遷移。pushNamedの戻り値は遷移先から取得した値。
    final result = await Navigator.pushNamed(context, RouteNames.upsertUser,
            arguments: UpsertUserViewArguments(isFamilyUser: true, user: user))
        as String?;

    if (result != null) {
      // 家族アカウントを(作成/編集)しましたメッセージをSnackBarで表示
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(result)));
    }
  }
}
