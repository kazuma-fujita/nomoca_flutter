import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nomoca_flutter/constants/route_names.dart';
import 'package:nomoca_flutter/data/entity/remote/preview_cards_entity.dart';
import 'package:nomoca_flutter/states/arguments/fetch_preview_cards_provider_arguments.dart';
import 'package:nomoca_flutter/states/providers/fetch_preview_cards_provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrReadInputView extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userToken = useState('');
    final args = FetchPreviewCardsProviderArguments(
        userToken: userToken.value, familyUserId: null);
    final asyncValue = ref.watch(fetchPreviewCardsProvider(args));
    return Scaffold(
      appBar: AppBar(
        title: const Text('診察券登録'),
      ),
      body: QrReadWidget(
        fetchPreviewCardsAsyncValue: asyncValue,
        userToken: userToken,
      ),
    );
  }
}

class QrReadWidget extends StatefulWidget {
  const QrReadWidget({
    required this.fetchPreviewCardsAsyncValue,
    required this.userToken,
  });

  final AsyncValue<PreviewCardsEntity> fetchPreviewCardsAsyncValue;
  final ValueNotifier<String> userToken;

  @override
  _QrReadWidgetState createState() => _QrReadWidgetState();
}

class _QrReadWidgetState extends State<QrReadWidget> {
  QRViewController? _qrController;
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
  bool _isQRScanned = false;

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
    qrController.scannedDataStream.listen((scanData) {
      // QRのデータが取得出来ない場合SnackBar表示
      if (scanData.code.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('QRコードが読み取れません'),
          ),
        );
        return;
      }
      // トークンを最新化
      widget.userToken.value = scanData.code;
      print('qrCode value:${widget.userToken.value}');

      widget.fetchPreviewCardsAsyncValue.when(
        data: (entity) async {
          // ローディング非表示
          await EasyLoading.dismiss();
          // 次の画面へ遷移
          await _transitionToNextScreen(entity);
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
    });
  }

  Future<void> _transitionToNextScreen(PreviewCardsEntity entity) async {
    if (!_isQRScanned) {
      // カメラを一時停止
      await _qrController?.pauseCamera();
      _isQRScanned = true;
      // 次の画面へ遷移
      await Navigator.pushNamed(
        context,
        RouteNames.qrReadConfirm,
        arguments: entity,
      ).then(
        // 遷移先画面から戻った場合カメラを再開
        (value) {
          _qrController?.resumeCamera();
          _isQRScanned = false;
        },
      );
    }
  }
}
