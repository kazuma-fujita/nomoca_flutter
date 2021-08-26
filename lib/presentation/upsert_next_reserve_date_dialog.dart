import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    // final initialValue = reserveDate != null
    //     ? DateFormat('yyyy-MM-dd HH:mm').format(
    //         DateFormat('yyyy/MM/dd(E) HH:mm', 'ja_JP').parse(reserveDate!))
    //     : DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());
    // final controller = useTextEditingController(text: initialValue);
    // final inputState = useState(reserveDate);
    final inputState = useState('');
    final inputFormatDateState = useState('');
    // 診察券番号登録処理
    ref.watch(updateNextReserveDateProvider).when(
      data: (isSuccess) async {
        if (isSuccess) {
          // ローディング非表示
          await EasyLoading.dismiss();
          Navigator.pop(context, inputFormatDateState.value);
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
    final nowDate = DateTime.now();
    return AlertDialog(
      title: const Text(
        '次回予約日時メモとしてご利用ください\n実際のご予約は病院へお問い合わせください',
        style: TextStyle(fontSize: 12),
      ),
      content: Form(
        key: _formKey,
        child: DateTimePicker(
          key: Key(
              'nextReserveDate-dialog-DateTimePicker-$institutionId$userId'),
          // controller: controller,
          type: DateTimePickerType.dateTimeSeparate,
          dateMask: 'yyyy/MM/dd',
          initialValue: nowDate.toString(),
          // initialValue: reserveDate != null
          //     ? DateFormat('yyyy/MM/dd(E) HH:mm', 'ja_JP')
          //         .parse(reserveDate!)
          //         .toString()
          //     : DateTime.now().toString(),
          firstDate: nowDate,
          lastDate: DateTime(nowDate.year + 10),
          icon: const Icon(Icons.event),
          dateLabelText: '予約日',
          timeLabelText: '時刻',
          onChanged: (input) {
            print('onChanged:$input');
          },
          validator: (input) {
            print('validator:$input');
            return null;
          },
          onSaved: (input) {
            inputState.value = input!;
            print('onSave:$input');
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
            // final formatDate = DateFormat('yyyy/MM/dd(E) HH:mm', 'ja_JP')
            //     .format(DateTime.parse(controller.text));
            // print('controller: ${controller.text}');
            // print('format: $formatDate');
            // inputState.value = formatDate;
            // // 登録・更新処理実行
            // ref
            //     .read(updateNextReserveDateProvider.notifier)
            //     .updateNextReserveDate(
            //   userId: userId,
            //   institutionId: institutionId,
            //   reserveDate: controller.text,
            // );
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              final formatDate = DateFormat('yyyy/MM/dd(E) HH:mm', 'ja_JP')
                  .format(DateTime.parse(inputState.value));
              print('inputState: ${inputState.value}');
              print('format: $formatDate');
              inputFormatDateState.value = formatDate;
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
