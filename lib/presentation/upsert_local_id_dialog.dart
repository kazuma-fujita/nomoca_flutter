import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/states/providers/update_local_id_provider.dart';

class UpsertLocalIdDialog extends HookConsumerWidget {
  UpsertLocalIdDialog(
      {required this.institutionId,
      required this.userId,
      this.localId,
      required Key key})
      : super(key: key);

  final int institutionId;
  final int userId;
  final String? localId;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inputState = useState('');
    // final controller = useTextEditingController(text: localId);
    // 診察券番号登録処理
    ref.watch(updateLocalIdProvider).when(
      data: (isSuccess) async {
        if (isSuccess) {
          // ローディング非表示
          await EasyLoading.dismiss();
          Navigator.pop(context, inputState.value);
          // Dialogのinstanceが破棄されずstateが残るので初期化
          ref.read(updateLocalIdProvider.notifier).initialState();
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
          // Dialogのinstanceが破棄されずstateが残るので初期化
          ref.read(updateLocalIdProvider.notifier).initialState();
        });
      },
    );

    return AlertDialog(
      title: const Text('診察券番号登録'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          key: Key('localId-dialog-TextField-$institutionId$userId'),
          // controller: controller,
          initialValue: localId,
          maxLength: 20,
          decoration: const InputDecoration(
            hintText: '診察券番号を入力してください',
            labelText: '診察券番号',
          ),
          autofocus: true,
          // キーボードを数値に制限
          keyboardType: TextInputType.number,
          // コピペなどでも数値以外入力出来ないよう制限
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: (String? input) {
            return input == null || input.isEmpty ? '診察券番号を入力してください' : null;
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
              ref.read(updateLocalIdProvider.notifier).updateLocalId(
                    userId: userId,
                    institutionId: institutionId,
                    localId: inputState.value,
                  );
            }
          },
          child: const Text('保存'),
        )
      ],
    );
  }
}
