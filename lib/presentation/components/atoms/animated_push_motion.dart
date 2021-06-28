import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AnimatedPushMotion extends HookWidget {
  const AnimatedPushMotion({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isPushed = useState<bool>(false);
    return AnimatedPadding(
      // 8ms分Widgetが押し込まれるpushアニメーションをする
      duration: const Duration(milliseconds: 8),
      padding: EdgeInsets.all(isPushed.value ? 8 : 0),
      child: GestureDetector(
        onTapDown: (TapDownDetails downDetails) {
          isPushed.value = true;
        },
        onTap: () {
          isPushed.value = false;
        },
        onTapCancel: () {
          isPushed.value = false;
        },
        child: child,
      ),
    );
  }
}
