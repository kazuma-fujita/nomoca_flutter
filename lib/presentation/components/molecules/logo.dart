import 'package:flutter/material.dart';
import 'package:nomoca_flutter/presentation/components/atoms/logo_mark.dart';
import 'package:nomoca_flutter/presentation/components/atoms/logo_type.dart';

class Logo extends StatelessWidget {
  const Logo({
    Key? key,
    required this.logoMarkHeight,
    required this.logoTypeHeight,
  }) : super(key: key);

  final double logoMarkHeight;
  final double logoTypeHeight;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: [
        LogoMark(height: logoMarkHeight),
        Align(
          alignment: Alignment.bottomCenter,
          child: LogoType(height: logoTypeHeight),
        ),
      ],
    );
  }
}
