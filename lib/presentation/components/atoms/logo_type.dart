import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nomoca_flutter/constants/asset_paths.dart';
import 'package:nomoca_flutter/themes/custom_color_scheme.dart';

class LogoType extends StatelessWidget {
  const LogoType({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      '${AssetPaths.logoImagePath}/logo_type.svg',
      height: height,
      color: Theme.of(context).colorScheme.logoPrimaryColor,
    );
  }
}
