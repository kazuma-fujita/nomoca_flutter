import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/data/entity/remote/family_user_entity.dart';
import 'package:nomoca_flutter/data/entity/remote/patient_card_entity.dart';
import 'package:nomoca_flutter/presentation/components/molecules/error_snack_bar.dart';
import 'package:nomoca_flutter/presentation/family_user_list_view.dart';
import 'package:nomoca_flutter/presentation/patient_card/patient_card_view.dart';

void main() {
  ProviderScope setUpProviderScope(
      AsyncValue<List<FamilyUserEntity>> asyncValue) {
    return ProviderScope(
      overrides: [
        familyUserListProvider.overrideWithValue(asyncValue),
      ],
      child: MaterialApp(home: FamilyUserListView()),
    );
  }

  group('Testing the family user list view.', () {
    testWidgets('Testing widget of loading.', (WidgetTester tester) async {
      await tester.pumpWidget(setUpProviderScope(const AsyncValue.loading()));
      expect(find.text('花子'), findsNothing);
      expect(find.byType(ErrorSnackBar), findsNothing);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Testing empty list.', (WidgetTester tester) async {
      await tester.pumpWidget(setUpProviderScope(const AsyncValue.data([])));
      expect(find.byType(ErrorSnackBar), findsNothing);
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.text('家族アカウントを登録しましょう'), findsOneWidget);
    });

    testWidgets('Testing array with two element.', (WidgetTester tester) async {
      await tester.pumpWidget(setUpProviderScope(
        const AsyncData([
          FamilyUserEntity(
            id: 1372,
            nickname: '花子',
          ),
          FamilyUserEntity(
            id: 1373,
            nickname: '次郎',
          ),
        ]),
      ));
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.text('花子'), findsOneWidget);
      expect(find.text('次郎'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.byType(ErrorSnackBar), findsNothing);
    });

    testWidgets('Testing widget of error.', (WidgetTester tester) async {
      await tester.pumpWidget(
          setUpProviderScope(AsyncValue.error(Exception('Error message.'))));
      expect(find.text('花子'), findsNothing);
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.byType(ErrorSnackBar), findsOneWidget);
    });
  });
}
