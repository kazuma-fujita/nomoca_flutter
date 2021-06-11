import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/data/entity/remote/user_nickname_entity.dart';
import 'package:nomoca_flutter/presentation/upsert_user_view.dart';

void main() {
  ProviderScope setUpProviderScope(Future<UserNicknameEntity> futureValue) {
    return ProviderScope(
      overrides: [
        createFamilyUserProvider
            .overrideWithProvider((ref, param) => futureValue),
      ],
      child: MaterialApp(home: UpsertUserView()),
    );
  }

  group('Testing the create family user view.', () {
    testWidgets('Testing widget of loading.', (WidgetTester tester) async {
      await tester.pumpWidget(setUpProviderScope(
          Future.value(const UserNicknameEntity(id: 1237, nickname: '花子'))));
      await tester.enterText(find.byType(TextFormField), '花子');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
      expect(find.byType(EasyLoading), findsNothing);
      expect(find.text('花子'), findsOneWidget);
    });
  });
}
