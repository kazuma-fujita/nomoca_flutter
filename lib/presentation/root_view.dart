import 'package:flutter/material.dart';
import 'package:nomoca_flutter/constants/route_names.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nomoca_flutter/states/providers/user_dao_provider.dart';

class RootView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _Body(),
    );
  }
}

class _Body extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // DBからユニークなuserレコード取得
    final user = ref.read(userDaoProvider).get();
    useEffect(() {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        if (user == null ||
            user.authenticationToken == null ||
            user.userId == null ||
            user.nickname == null) {
          // userのカラムデータが無ければTopへ遷移
          Navigator.pushNamed(context, RouteNames.top);
        } else {
          // userのカラムデータがあればBottomNaviBar画面を表示
          Navigator.pushNamed(context, RouteNames.bottomNavigation);
        }
      });
    }, []);
    return const Center(child: CircularProgressIndicator());
  }
}
