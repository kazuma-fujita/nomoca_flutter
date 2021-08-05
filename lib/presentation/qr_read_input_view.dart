import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/constants/route_names.dart';
import 'package:nomoca_flutter/data/entity/remote/preview_cards_entity.dart';
import 'package:nomoca_flutter/presentation/arguments/qr_read_confirm_argument.dart';
import 'package:nomoca_flutter/states/providers/fetch_preview_cards_provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrReadInputView extends HookConsumerWidget {
  const QrReadInputView({this.familyUserId});

  final int? familyUserId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userToken = useState('');
    return Scaffold(
      appBar: AppBar(
        title: const Text('診察券登録'),
      ),
      body: QrReadWidget(
        ref: ref,
        userToken: userToken,
        familyUserId: familyUserId,
      ),
    );
  }
}

class QrReadWidget extends StatefulWidget {
  const QrReadWidget({
    required this.ref,
    required this.userToken,
    required this.familyUserId,
  });

  final WidgetRef ref;
  final ValueNotifier<String> userToken;
  final int? familyUserId;

  @override
  _QrReadWidgetState createState() => _QrReadWidgetState();
}

class _QrReadWidgetState extends State<QrReadWidget> {
  QRViewController? _qrController;
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
  bool _isFetchData = false;

  // ホットリロードを機能させるには、プラットフォームがAndroidの場合はカメラを一時停止するか、
  // プラットフォームがiOSの場合はカメラを再開する必要がある
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      _qrController?.pauseCamera();
    }
    _qrController?.resumeCamera();
  }

  @override
  void dispose() {
    _qrController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.ref.watch(fetchPreviewCardsProvider).when(
      data: (entity) async {
        if (entity != null) {
          // ローディング非表示
          await EasyLoading.dismiss();
          // 次の画面へ遷移
          await _transitionToNextScreen(entity);
        }
      },
      loading: () async {
        // ローディング表示
        await EasyLoading.show();
      },
      error: (error, _) {
        // ローディング非表示
        EasyLoading.dismiss();
        // API呼び出しを有効にする
        _isFetchData = false;
        // カメラ一時停止再開
        _qrController?.resumeCamera();
        // SnackBar表示
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(error.toString())));
        });
      },
    );

    return QRView(
      key: _qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.green,
        borderRadius: 16,
        borderLength: 24,
        borderWidth: 8,
      ),
    );
  }

  void _onQRViewCreated(QRViewController qrController) {
    setState(() {
      _qrController = qrController;
    });
    // QRを読み込みをlistenする
    qrController.scannedDataStream.listen((scanData) async {
      // QRのデータが取得出来ない場合SnackBar表示
      if (scanData.code.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('QRコードが読み取れません'),
          ),
        );
        return;
      }
      // QRコード連続読み込みによるAPI連続呼び出し防止判定
      if (!_isFetchData) {
        // API連続呼び出し防止フラグを立てる
        _isFetchData = true;
        // カメラを一時停止
        await _qrController?.pauseCamera();
        // トークンを最新化
        widget.userToken.value = scanData.code;
        print('qrCode value:${widget.userToken.value}');

        await widget.ref.read(fetchPreviewCardsProvider.notifier).fetchCards(
              userToken: widget.userToken.value,
              familyUserId: widget.familyUserId,
            );
      }
    });
  }

  Future<void> _transitionToNextScreen(PreviewCardsEntity entity) async {
    // 確認画面の引数
    final args = QrReadConfirmArgument(
      entity: entity,
      familyUserId: widget.familyUserId,
    );
    // 次の画面へ遷移
    await Navigator.pushNamed(
      context,
      RouteNames.qrReadConfirm,
      arguments: args,
    ).then(
      // 遷移先画面から戻った場合カメラを再開
      (value) {
        _qrController?.resumeCamera();
        _isFetchData = false;
      },
    );
  }
}
