import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/data/entity/remote/user_nickname_entity.dart';
import 'package:nomoca_flutter/presentation/components/molecules/error_snack_bar.dart';
import 'package:nomoca_flutter/presentation/family_user_list_view.dart';
import 'package:nomoca_flutter/states/reducers/family_user_list_reducer.dart';

void main() {
  ProviderScope setUpProviderScope(
      AsyncValue<List<UserNicknameEntity>> asyncValue) {
    return ProviderScope(
      overrides: [
        familyUserListReducer.overrideWithValue(asyncValue),
      ],
      child: const MaterialApp(home: FamilyUserListView()),
    );
  }

  group('Testing the family user list view.', () {
    testWidgets('Testing view of element.', (WidgetTester tester) async {
      await tester.pumpWidget(setUpProviderScope(const AsyncValue.loading()));
      expect(find.text('家族アカウント管理'), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

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
          UserNicknameEntity(
            id: 1372,
            nickname: '花子',
          ),
          UserNicknameEntity(
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
