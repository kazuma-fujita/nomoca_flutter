import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/data/entity/remote/patient_card_entity.dart';
import 'package:nomoca_flutter/presentation/components/molecules/error_snack_bar.dart';
import 'package:nomoca_flutter/presentation/patient_card/patient_card_view.dart';
import 'package:nomoca_flutter/states/providers/patient_card_provider.dart';

void main() {
  const contentsBaseUrl = 'https://contents-debug.nomoca.com';

  // Widget testはHTTP 通信が 400 - Bad Request になる仕様
  // Image.network() で画像の取得が失敗する為、400 errorになる仕組みを無効化
  setUpAll(() => HttpOverrides.global = null);

  ProviderScope setUpProviderScope(
      AsyncValue<List<PatientCardEntity>> asyncValue) {
    return ProviderScope(
      overrides: [
        patientCardProvider.overrideWithValue(asyncValue),
      ],
      child: MaterialApp(home: PatientCardView()),
    );
  }

  group('Testing the patient card view.', () {
    testWidgets('Testing array with one element.', (WidgetTester tester) async {
      await tester.pumpWidget(setUpProviderScope(
        const AsyncData([
          PatientCardEntity(
            nickname: '花子',
            qrCodeImageUrl: '$contentsBaseUrl/qr/1372/MbQRuYNDyPFxLPhY.png',
          ),
        ]),
      ));

      expect(find.byType(ErrorSnackBar), findsNothing);
      expect(find.text('花子'), findsOneWidget);
      expect(find.byType(SvgPicture), findsNWidgets(2));
    });

    testWidgets('Testing array with two element.', (WidgetTester tester) async {
      await tester.pumpWidget(setUpProviderScope(
        const AsyncData([
          PatientCardEntity(
            nickname: '太郎',
            qrCodeImageUrl: '$contentsBaseUrl/qr/1344/ueR8q99hD7Ux4VrK.png',
          ),
          PatientCardEntity(
            nickname: '花子',
            qrCodeImageUrl: '$contentsBaseUrl/qr/1372/MbQRuYNDyPFxLPhY.png',
          ),
        ]),
      ));

      expect(find.byType(ErrorSnackBar), findsNothing);
      expect(find.text('太郎'), findsOneWidget);
      expect(find.text('花子'), findsOneWidget);
      expect(find.byType(SvgPicture), findsNWidgets(2));
    });

    group('Testing error of patient card view.', () {
      testWidgets('Testing widget of error.', (WidgetTester tester) async {
        await tester.pumpWidget(
            setUpProviderScope(AsyncValue.error(Exception('Error message.'))));
        expect(find.text('太郎'), findsNothing);
        expect(find.byType(ErrorSnackBar), findsOneWidget);
      });
    });
  });
}
