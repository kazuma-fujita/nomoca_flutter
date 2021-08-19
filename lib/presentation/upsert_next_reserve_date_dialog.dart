import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/states/providers/update_next_reserve_date_provider.dart';

class UpsertNextReserveDateDialog extends HookConsumerWidget {
  UpsertNextReserveDateDialog(
      {required this.institutionId,
      required this.userId,
      this.reserveDate,
      required Key key})
      : super(key: key);

  final int institutionId;
  final int userId;
  final String? reserveDate;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inputState = useState('');
    // 診察券番号登録処理
    ref.watch(updateNextReserveDateProvider).when(
      data: (isSuccess) async {
        if (isSuccess) {
          // ローディング非表示
          await EasyLoading.dismiss();
          Navigator.pop(context, inputState.value);
          // Dialogのinstanceが破棄されずstateが残るので初期化
          ref.read(updateNextReserveDateProvider.notifier).initialState();
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

    return AlertDialog(
      title: const Text('次回予約日時メモ'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          initialValue: reserveDate,
          maxLength: 20,
          decoration: const InputDecoration(
            hintText: '次回予約日時メモを入力してください',
            labelText: '次回予約日時メモ',
          ),
          autofocus: true,
          // キーボードを数値に制限
          keyboardType: TextInputType.number,
          // コピペなどでも数値以外入力出来ないよう制限
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: (String? input) {
            return input == null || input.isEmpty ? '次回予約日時を選択してください' : null;
          },
          onSaved: (String? input) {
            inputState.value = input!;
          },
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('キャンセル'),
        ),
        ElevatedButton(
          onPressed: () {
            // TextFormFieldのvalidate実行
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              // 登録・更新処理実行
              ref
                  .read(updateNextReserveDateProvider.notifier)
                  .updateNextReserveDate(
                    userId: userId,
                    institutionId: institutionId,
                    reserveDate: inputState.value,
                  );
            }
          },
          child: const Text('保存'),
        )
      ],
    );
  }
}
