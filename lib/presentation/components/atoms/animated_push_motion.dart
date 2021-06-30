import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AnimatedPushMotion extends HookWidget {
  const AnimatedPushMotion({required this.child, this.onTap});
  final Widget child;
  final Function()? onTap;

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
          if (onTap != null) {
            onTap!();
          }
        },
        onTapCancel: () {
          isPushed.value = false;
        },
        child: child,
      ),
    );
  }
}
