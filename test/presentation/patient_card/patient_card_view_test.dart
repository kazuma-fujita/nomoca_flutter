import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/data/entity/remote/patient_card_entity.dart';
import 'package:nomoca_flutter/main.dart';
import 'package:nomoca_flutter/presentation/patient_card/patient_card_view.dart';

void main() {
  // Widget testはHTTP 通信が 400 - Bad Request になる仕様
  // Image.network() で画像の取得が失敗する為、400 errorになる仕組みを無効化
  setUpAll(() => HttpOverrides.global = null);

  group('Testing the patient card view.', () {
    testWidgets('Testing Array with one element.', (WidgetTester tester) async {
      const contentsBaseUrl = 'https://contents-debug.nomoca.com';
      await tester.pumpWidget(ProviderScope(
        overrides: [
          patientCardProvider.overrideWithValue(
            const AsyncData([
              PatientCardEntity(
                nickname: '花子',
                qrCodeImageUrl: '$contentsBaseUrl/qr/1372/MbQRuYNDyPFxLPhY.png',
              ),
            ]),
          ),
        ],
        child: MaterialApp(home: PatientCardView()),
      ));

      expect(find.byType(CircularProgressIndicator), findsNothing);
    });
  });
}
